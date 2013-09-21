//
//  ShowMMSBigImageCtl.h
//  Megafon
//
//  Created by  sunliang on 11-11-23.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowImageView.h"

@interface ShowMMSBigImageCtl : BaseController <UIScrollViewDelegate,UIActionSheetDelegate,ShowImageViewDelegate>
{

	ShowImageView   *photoView;
	UIScrollView    *photoSrcollView;
	NSString        *imgUrl;
    UINavigationBar *_navigationBar;
    UIButton        *_rightButton;
    NSTimer         *_delayHideTimer;
    BOOL            _tabBarHidden;
}

@property (nonatomic,retain)ShowImageView *photoView;
@property (nonatomic,retain)UIScrollView *photoSrcollView;
@property (nonatomic,retain)NSString        *imgUrl;

- (id)initWithImageUrl:(NSString *)aUrl;
- (void)showimage;
- (void)startHideNavigationBarTimer;
@end
