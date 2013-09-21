//
//  AudioPlayerView.h
//  XSTestProject
//
//  Created by zhangss on 12-7-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioStreamer.h"
#import "BaseController.h"
#import "AudioSliderView.h"

@interface AudioPlayerView : UIView <AudioSliderViewDelegate>
{
    UIButton *playButton;
    NSString *audioURLStr;
    BOOL isPlay;
    BOOL isWaiting;
    BOOL isBegin;
    AudioStreamer *streamer;
    NSTimer *updateProgressTimer;
    
    AudioSliderView *audioSlider;
    UILabel *timeLabel;
    
    UILabel *audioArtistLabel;
    
    NSString *audioArtist;
    NSString *audioDuration;
    
    CGPoint touchBegin;
    BOOL isTouchMoving;
}

@property (nonatomic,retain) NSString *audioURLStr;
@property (nonatomic,retain) NSTimer *updateProgressTimer;
@property (nonatomic,retain) NSString *audioArtist;
@property (nonatomic,retain) NSString *audioDuration;

- (id)initWithFrame:(CGRect)frame audioArtist:(NSString *)aArtist andDuration:(NSString *)aDuration;
- (void)setButtonImage:(UIImage *)aImage;
- (void)setProgressStart;
- (NSString *)getTimeString:(NSInteger)alltime;

@end
