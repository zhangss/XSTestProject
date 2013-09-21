//
//  AudioPlayerView.m
//  XSTestProject
//
//  Created by zhangss on 12-7-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AudioPlayerView.h"
#import "XSTestUtils.h"


@implementation AudioPlayerView

@synthesize audioURLStr;
@synthesize updateProgressTimer;
@synthesize audioDuration;
@synthesize audioArtist;

#pragma mark -
#pragma mark Streamer
//
// destroyStreamer
//
// Removes the streamer, the UI update timer and the change notification
//
- (void)destroyStreamer
{
	if (streamer)
	{
		[[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:ASStatusChangedNotification
         object:streamer];
        
        [self setProgressStart];

        NSLog(@"Streamer Destory:%@",streamer);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        isBegin = NO;
        if (![streamer isIdle] && ![streamer isPaused])
        {
            //正常情况下 不用强制设置
            [streamer setState:AS_STOPPING];  
        }
		[streamer stop];
        [streamer release];
        streamer = nil;
	}
}
//
// createStreamer
//
// Creates or recreates the AudioStreamer object.
//
- (void)createStreamer
{
    if (streamer)
    {
        return;
    }

    [self destroyStreamer];
    
    /* 暂时不用编码 需要判断URL是否编码过 如果编码了就不能再次编码 否则会有问题
     NSString *escapedValue =
     [(NSString *)CFURLCreateStringByAddingPercentEscapes(
     nil,
     (CFStringRef)audioURLStr,
     NULL,
     NULL,
     kCFStringEncodingUTF8)
     autorelease];
     */
    
    NSURL *url = [NSURL URLWithString:audioURLStr];
    NSLog(@"AudioURL:%@",audioURLStr);
    streamer = [[AudioStreamer alloc] initWithURL:url];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(playbackStateChanged:)
     name:ASStatusChangedNotification
     object:streamer];
//#ifdef SHOUTCAST_METADATA
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(metadataChanged:)
//     name:ASUpdateMetadataNotification
//     object:streamer];
//#endif
}


#pragma mark -
#pragma mark CALLBACK
//
// playbackStateChanged:
//
// Invoked when the AudioStreamer
// reports that its playback status has changed.
//
- (void)playbackStateChanged:(NSNotification *)aNotification
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    if ([streamer isPlaying])
    {
        isBegin = YES;
        NSLog(@"Audio isPlaying");
        //[streamer setMeteringEnabled:YES];
        [self setButtonImage:[UIImage imageNamed:@"viose_stop"]];
    }
    else if ([streamer isIdle]) 
    {
        NSLog(@"Audio isIdle");
        isBegin = NO;
        [self setButtonImage:[UIImage imageNamed:@"viose_icon"]];
        [self destroyStreamer];
    }
    else if ([streamer isWaiting]) 
    {
        isBegin = YES;
        NSLog(@"Audio isWaiting");
        //[streamer setMeteringEnabled:NO];
        [self setButtonImage:[UIImage imageNamed:@"viose_stop"]];
    }
    else if ([streamer isPaused])
    {
        isBegin = NO;
        NSLog(@"Audio isPaused");
        [self setButtonImage:[UIImage imageNamed:@"viose_icon"]];
    }

}

- (void)aAudioStartedCallBack:(NSNotification *)noti
{
    NSDictionary *userInfo = [noti userInfo];
    AudioStreamer *playingStreamer = [userInfo objectForKey:@"AudioStreamer"];
    if (![playingStreamer isEqual:streamer])
    {
        [self setButtonImage:[UIImage imageNamed:@"viose_icon"]];
        [self destroyStreamer];
    }
}

#pragma mark -
#pragma mark life cecle
- (id)initWithFrame:(CGRect)frame audioArtist:(NSString *)aArtist andDuration:(NSString *)aDuration
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.audioArtist = [NSString stringWithString:aArtist];
        self.audioDuration = [NSString stringWithString:aDuration];
        
        CGFloat width = frame.size.width;
        //按钮
        playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        playButton.layer.cornerRadius = 5.0;
        [playButton setBackgroundImage:[UIImage imageNamed:@"viose_icon"] forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(audioPlay:) forControlEvents:UIControlEventTouchUpInside];
        playButton.frame = CGRectMake(0, 0, 66, 64);
        [self addSubview:playButton];
        
        audioSlider = [[AudioSliderView alloc] initWithFrame:CGRectMake(70, 50, width - 70 - 5, 10)];
        audioSlider.delegate = self;
        audioSlider.userInteractionEnabled = NO;
        [self addSubview:audioSlider];
        
        NSString *timeStr = nil;
        if ([audioDuration intValue] == 0)
        {
            timeStr = @"00:00";
        }
        else
        {
            timeStr = [self getTimeString:[audioDuration intValue]]; 
        }

        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width - 50 - 5, 10, 50, 20)];
        timeLabel.textAlignment = UITextAlignmentRight;
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.text = timeStr;
        //[timeLabel labelWithType:kSNSTime];
        [self addSubview:timeLabel];
        
        audioArtistLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, width - 70 - 50 - 5, 20)];
        audioArtistLabel.textAlignment = UITextAlignmentLeft;
        audioArtistLabel.backgroundColor = [UIColor clearColor];
        audioArtistLabel.text = audioArtist;
        //[audioArtistLabel labelWithType:kTitleContentMark];
        [self addSubview:audioArtistLabel];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(aAudioStartedCallBack:)
         name:@"AAudioStarted"
         object:nil];
        
        //播放的URL
        self.audioURLStr = @"";
        
        //定时器 更新进度条
        updateProgressTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
                                                               target:self 
                                                             selector:@selector(updateProgress:) 
                                                             userInfo:nil
                                                              repeats:YES];
    }
    return self;
}

- (void)dealloc 
{
    [self destroyStreamer];
    updateProgressTimer = nil;
    [audioSlider release];
    [audioArtist release];
    [audioDuration release];
    [timeLabel release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [audioURLStr release];
    [super dealloc];
}

#pragma mark -
#pragma mark Methods
//点击播放/暂停 Button的方法
- (void)audioPlay:(id)sender
{
    
    if (!isBegin)
	{	
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        isBegin = YES;
		[self createStreamer];
		[self setButtonImage:[UIImage imageNamed:@"viose_stop"]];
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:streamer,@"AudioStreamer",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AAudioStarted" object:nil userInfo:userInfo];
        NSLog(@"Streamer Start:%@",streamer);
		[streamer start];
        
	}
	else
	{
        if ([streamer isWaiting])
        {
            return;
        }
        isBegin = NO;
        [self setButtonImage:[UIImage imageNamed:@"viose_icon"]];
        //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"Streamer Stop:%@",streamer);
        [streamer pause];

	}
}

//进度条位置初始化
- (void)setProgressStart
{
    if (audioSlider)
    {
        [audioSlider setProgressPonitValue:0.0];
    }
}

//时间转换
- (NSString *)getTimeString:(NSInteger)alltime
{
    NSInteger minu = 0;
    NSInteger sec = 0;
    minu = (alltime / 60);
    sec = alltime - (minu * 60);
    NSString *timeStr = [NSString stringWithFormat:@"%d:%d",minu,sec];
    NSDate *dateTime = [XSTestUtils dateFromString:timeStr withFormatString:@"mm:ss"];
    NSString *returnStr = [XSTestUtils stringDateByFormatString:@"mm:ss" withDate:dateTime];
    return returnStr;
}

//更新进度条
- (void)updateProgress:(NSTimer *)updatedTimer
{
	if (streamer.bitRate != 0.0)
	{
		double progress = streamer.progress;
		//double duration = streamer.duration;
        double duration = [audioDuration doubleValue];
        NSLog(@"Progress before:%f",progress);
        if ([streamer isPlaying]) 
        {
             NSLog(@"isPlaying: Progress:%f",progress);
            //2S 误差 平均加到每一次刷新中 总误差 * 当前进度 = 误差进度
            progress = progress + 2.0 * progress / duration;   
        }
        NSLog(@"Progress after:%f",progress);
		if (duration > 0 && [streamer isPlaying])
		{
            NSString *timeStr = [self getTimeString:duration];
            timeLabel.text = timeStr;
            CGFloat xValue = audioSlider.progressLeght * progress / duration;
            [audioSlider setProgressPonitValue:xValue];
            //audioSlider.userInteractionEnabled = YES;
		}
        else
        {
            //audioSlider.userInteractionEnabled = NO;
        }
	}
}

- (void)setButtonImage:(UIImage *)aImage
{
    //移除Button的动画
    [playButton.layer removeAllAnimations];
    
    //设置图片
    if (aImage)
    {
        [playButton setImage:aImage forState:UIControlStateNormal];
    }
    else
    {
        [playButton setImage:[UIImage imageNamed:@"viose_icon"] forState:UIControlStateNormal];
    }
}

#pragma mark -
#pragma mark AudioSliderDelegate
- (void)audioSliderMoveEnd:(CGFloat)progressValue
{
    NSLog(@"%f",progressValue);
    NSLog(@"%f",audioSlider.progressLeght);
    double newSeekTime = (progressValue / audioSlider.progressLeght) * streamer.duration;
	NSLog(@"%f",newSeekTime);
    [streamer pause];
    [streamer seekToTime:newSeekTime];
    
    if (!updateProgressTimer) 
    {
        updateProgressTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                               target:self
                                                             selector:@selector(updateProgress:)
                                                             userInfo:nil
                                                              repeats:YES];
        
    }
}

- (void)audioSliderMoveBegin
{
    if (updateProgressTimer)
    {
        [updateProgressTimer invalidate];
        updateProgressTimer  = nil;
    }
	[streamer pause];
}

#ifdef SHOUTCAST_METADATA
/** Example metadata
 * 
 StreamTitle='Kim Sozzi / Amuka / Livvi Franc - Secret Love / It's Over / Automatik',
 StreamUrl='&artist=Kim%20Sozzi%20%2F%20Amuka%20%2F%20Livvi%20Franc&title=Secret%20Love%20%2F%20It%27s%20Over%20%2F%20Automatik&album=&duration=1133453&songtype=S&overlay=no&buycd=&website=&picture=',
 
 Format is generally "Artist hypen Title" although servers may deliver only one. This code assumes 1 field is artist.
 */
//- (void)metadataChanged:(NSNotification *)aNotification
//{
//	NSString *streamArtist;
//	NSString *streamTitle;
//	NSArray *metaParts = [[[aNotification userInfo] objectForKey:@"metadata"] componentsSeparatedByString:@";"];
//	NSString *item;
//	NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
//	for (item in metaParts) {
//		// split the key/value pair
//		NSArray *pair = [item componentsSeparatedByString:@"="];
//		// don't bother with bad metadata
//		if ([pair count] == 2)
//			[hash setObject:[pair objectAtIndex:1] forKey:[pair objectAtIndex:0]];
//	}
//    
//	// do something with the StreamTitle
//	NSString *streamString = [[hash objectForKey:@"StreamTitle"] stringByReplacingOccurrencesOfString:@"'" withString:@""];
//	
//	NSArray *streamParts = [streamString componentsSeparatedByString:@" - "];
//	if ([streamParts count] > 0) {
//		streamArtist = [streamParts objectAtIndex:0];
//	} else {
//		streamArtist = @"";
//	}
//	// this looks odd but not every server will have all artist hyphen title
//	if ([streamParts count] == 2) {
//		streamTitle = [streamParts objectAtIndex:1];
//	} else {
//		streamTitle = @"";
//	}
//	NSLog(@"%@ by %@", streamTitle, streamArtist);
//    
//	// only update the UI if in foreground
//	iPhoneStreamingPlayerAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//	if (appDelegate.uiIsVisible) {
//		metadataArtist.text = streamArtist;
//		metadataTitle.text = streamTitle;
//	}
//}
#endif

@end
