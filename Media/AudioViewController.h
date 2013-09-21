//
//  AudioViewController.h
//  XSTestProject
//
//  Created by 张松松 on 12-7-2.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "AudioStreamer.h"

@interface AudioViewController : BaseController <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *m_tableV;
    
    BOOL isPlay;
    BOOL isWaiting;
    BOOL isBegin;
    UIButton *audioButton;
    AudioStreamer *streamer;
    
    
}

- (void)setButtonImage:(UIImage *)aImage;
- (void)destroyStreamer;
- (void)createStreamer;
- (void)spinButtonImage;

@end
