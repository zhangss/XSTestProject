    //
//  AudioViewController.m
//  XSTestProject
//
//  Created by 张松松 on 12-7-2.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AudioViewController.h"

#import "AudioPlayerView.h"

@implementation AudioViewController

//Audio 测试的URL
#define kAudioTestURL1 @"http://2015.wma.9ku.com//file2/80/79104.mp3"

#define kPlayBtnTag 10001

#pragma mark -
#pragma mark Init
- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

#pragma mark -
#pragma mark life cycle
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"Audio",@"")];
    
    m_tableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    m_tableV.dataSource = self;
    m_tableV.delegate = self;
    [self.view addSubview:m_tableV];
    
    //原始Demo中的部分 footView
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height - m_tableV.frame.size.height - 10)];
    footView.backgroundColor = [UIColor blueColor];
    m_tableV.tableFooterView = footView;
    [footView release];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
    [self destroyStreamer];
    [audioButton release];
    [super dealloc];
}

#pragma mark -
#pragma mark Methods
//点击播放/暂停 Button的方法
- (void)audioPlay:(id)sender
{
    if (!isBegin)
	{	
        isBegin = YES;
		[self createStreamer];
		[self setButtonImage:[UIImage imageNamed:@"loadingbutton"]];
		[streamer start];
	}
	else
	{
        isBegin = NO;
		[streamer stop];
        [self setButtonImage:[UIImage imageNamed:@"stopbutton"]];

	}
}

//
// setButtonImage:
//
// Used to change the image on the playbutton. This method exists for
// the purpose of inter-thread invocation because
// the observeValueForKeyPath:ofObject:change:context: method is invoked
// from secondary threads and UI updates are only permitted on the main thread.
//
// Parameters:
//    image - the image to set on the play button.
//
- (void)setButtonImage:(UIImage *)aImage
{
    //移除Button的动画
    [audioButton.layer removeAllAnimations];
    
    //设置图片
    if (aImage)
    {
        [audioButton setImage:aImage forState:UIControlStateNormal];
    }
    else
    {
        [audioButton setImage:[UIImage imageNamed:@"playbutton"] forState:UIControlStateNormal];
        if (isWaiting) 
        {
            [self spinButtonImage];
        }
    }
}

//加载的时候做的button旋转
- (void)spinButtonImage 
{
    [CATransition begin];
    [CATransition setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    CGRect frame = [audioButton frame];
	audioButton.layer.anchorPoint = CGPointMake(0.5, 0.5);
	audioButton.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
	[CATransaction commit];
    
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:1.0] forKey:kCATransactionAnimationDuration];
    
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:0.0];
	animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
	[audioButton.layer addAnimation:animation forKey:@"rotationAnimation"];
    
	[CATransaction commit];
}

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
	
	NSString *escapedValue =
    [(NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                         nil,
                                                         (CFStringRef)@"http://2015.wma.9ku.com//file2/80/79104.mp3",
                                                         NULL,
                                                         NULL,
                                                         kCFStringEncodingUTF8)
     autorelease];
    
	NSURL *url = [NSURL URLWithString:escapedValue];
	streamer = [[AudioStreamer alloc] initWithURL:url];
	
	[[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(playbackStateChanged:)
     name:ASStatusChangedNotification
     object:streamer];
#ifdef SHOUTCAST_METADATA
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(metadataChanged:)
	 name:ASUpdateMetadataNotification
	 object:streamer];
#endif
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
	if ([streamer isWaiting])
	{
		[streamer setMeteringEnabled:NO];
		[self setButtonImage:[UIImage imageNamed:@"loadingbutton.png"]];
	}
	else if ([streamer isPlaying])
	{
		[streamer setMeteringEnabled:YES];
		[self setButtonImage:[UIImage imageNamed:@"stopbutton.png"]];
	}
	else if ([streamer isIdle])
	{
		[self destroyStreamer];
		[self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
	}
	else if ([streamer isPaused])
    {
		[self setButtonImage:[UIImage imageNamed:@"pausebutton.png"]];
	}
    
}

#ifdef SHOUTCAST_METADATA
/** Example metadata
 * 
 StreamTitle='Kim Sozzi / Amuka / Livvi Franc - Secret Love / It's Over / Automatik',
 StreamUrl='&artist=Kim%20Sozzi%20%2F%20Amuka%20%2F%20Livvi%20Franc&title=Secret%20Love%20%2F%20It%27s%20Over%20%2F%20Automatik&album=&duration=1133453&songtype=S&overlay=no&buycd=&website=&picture=',
 
 Format is generally "Artist hypen Title" although servers may deliver only one. This code assumes 1 field is artist.
 */
- (void)metadataChanged:(NSNotification *)aNotification
{
	NSString *streamArtist;
	NSString *streamTitle;
	NSArray *metaParts = [[[aNotification userInfo] objectForKey:@"metadata"] componentsSeparatedByString:@";"];
	NSString *item;
	NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
	for (item in metaParts) {
		// split the key/value pair
		NSArray *pair = [item componentsSeparatedByString:@"="];
		// don't bother with bad metadata
		if ([pair count] == 2)
			[hash setObject:[pair objectAtIndex:1] forKey:[pair objectAtIndex:0]];
	}
    
	// do something with the StreamTitle
	NSString *streamString = [[hash objectForKey:@"StreamTitle"] stringByReplacingOccurrencesOfString:@"'" withString:@""];
	
	NSArray *streamParts = [streamString componentsSeparatedByString:@" - "];
	if ([streamParts count] > 0) {
		streamArtist = [streamParts objectAtIndex:0];
	} else {
		streamArtist = @"";
	}
	// this looks odd but not every server will have all artist hyphen title
	if ([streamParts count] == 2) {
		streamTitle = [streamParts objectAtIndex:1];
	} else {
		streamTitle = @"";
	}
	NSLog(@"%@ by %@", streamTitle, streamArtist);
    
	// only update the UI if in foreground
	iPhoneStreamingPlayerAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	if (appDelegate.uiIsVisible) {
		metadataArtist.text = streamArtist;
		metadataTitle.text = streamTitle;
	}
}
#endif

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 75;
    }
    else
    {
        return 50;
    }
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = 0;
    if (section == 0)
    {
        rowCount = 1;
    }
    else if (section == 1)
    {
        rowCount = 1;
    }
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
    }
    
    if (indexPath.section == 1)
    {
        
        cell.textLabel.text = NSLocalizedString(@"Audio Artist",@"");
        cell.detailTextLabel.text = NSLocalizedString(@"Audio Title",@"");
        
        if (audioButton == nil)
        {
            audioButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
            audioButton.frame = CGRectMake(240, 9, 32, 32);
            [audioButton addTarget:self action:@selector(audioPlay:) forControlEvents:UIControlEventTouchUpInside];
            audioButton.tag = kPlayBtnTag;
            [self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
            [cell.contentView addSubview:audioButton];
        }

    }
    else
    {
        NSString *audioArtist = NSLocalizedString(@"Audio Artist",@"");
        NSString *audioDuration = NSLocalizedString(@"300",@"");
        NSString *audioURLStr = kAudioTestURL1;
        AudioPlayerView *aPlayer = [[AudioPlayerView alloc] initWithFrame:CGRectMake(10, 5,280, 65) audioArtist:audioArtist andDuration:audioDuration];
        aPlayer.audioURLStr = audioURLStr;
        [cell.contentView addSubview:aPlayer];
        [aPlayer release];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleString = nil;
    if (section == 0)
    {
        titleString = [NSString stringWithString:NSLocalizedString(@"Custom By Myself",@"")];
    }
    else
    {
        titleString = [NSString stringWithString:NSLocalizedString(@"Original Demo",@"")];
    }
    return titleString;
}

@end
