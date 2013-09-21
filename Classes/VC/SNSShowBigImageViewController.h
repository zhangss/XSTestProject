//
//  SNSShowBigImageViewController.h
//  Megafon
//
//  Created by  xiongguofeng on 2012-05-18
//  Copyright 2012 华为技术有限公司. All rights reserved.
//
/*
    文件第一负责人：熊国锋
    文件第二负责人：张松松
 */

#import <UIKit/UIKit.h>
#import "ShowImageView.h"
#import "SNSFeedData.h"

@interface SNSShowBigImageViewController : BaseController <UIScrollViewDelegate,UIActionSheetDelegate,ShowImageViewDelegate>
{
    ShowImageView   *photoView;
    UIScrollView    *photoScrollView;
    NSString        *imgPath;
    NSString        *imgUrl;
    SNSFeedData     *snsFeed;
    UIActivityIndicatorView *loadingIndicator;
    UIImageView     *previewImageView;//add by wang chao 2012/5/31
    UINavigationBar *_navigationBar;
    UIButton        *_rightButton;
    NSTimer         *_delayHideTimer;
    BOOL            _tabBarHidden;
}

@property (nonatomic,retain)UIScrollView *photoScrollView;

- (id)initWithFeed:(SNSFeedData *)feed;
- (id)initWithImages:(NSString *)picture source:(NSString *)source;
- (void)showimage;
- (void)backButtonClicked;
- (void)showPreviewImage:(NSString*)_imgPath;//add by wang chao 2012/5/31
- (void)toogleShowNavigationBar;
- (void)setNavigationBarHide:(BOOL)hide;
- (void)startHideNavigationBarTimer;

@end
