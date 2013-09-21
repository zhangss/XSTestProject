//
//  UIBigImageView.h
//  XSTestProject
//
//  Created by 张永亮 on 12-11-26.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

/*
 改View的功能为
 1.显示图片
 2.双击支持图片缩放
 3.单击效果
 4.下载图片展示:
    <1>可以小图变大图loading
    <2>做小图拉伸模糊展示——loading下载——显示清晰大图
 */

#import <UIKit/UIKit.h>
#import "UIImageViewForTouch.h"
#import <Foundation/NSObject.h>

@protocol UIBigImageViewDelegate <NSObject>

@optional
- (void)disMissBigImageView;

@end


@interface UIBigImageView : UIView <UIScrollViewDelegate,UIImageViewForTouchDelegate,UIGestureRecognizerDelegate>
{
    UIScrollView *scrollView;       //多图的ScrollView
    NSArray      *imageArr;         //多图Image数组
    NSMutableArray *imageViewArr;     //多图View数组
    
    BOOL          isZooming;        //放大与否 放大之后不响应单击事件
    BOOL          isDrag;
    CGFloat      scrolloffSet;
    NSInteger    curPage;
    NSInteger    curImageV;
    
    UIImageView   *toolBar;         //底部工具栏
    UIButton      *backButton;      //点击返回按钮
    UIButton      *saveButton;      //保存按钮
    
    id<UIBigImageViewDelegate> delegate;
    
    UIViewController *aViewController;  //当前view的ViewController
    CGRect           originRect;
    UIImage *image;
}

@property(nonatomic, assign)id<UIBigImageViewDelegate> delegate;
@property(nonatomic, retain)UIImage *image;
@property(nonatomic, assign)UIViewController *aViewController;
@property(nonatomic, assign)BOOL isDrag;

- (void)setImageArr:(NSArray *)imageArray andSelIndex:(NSInteger)index;
- (void)beginAnimation;
- (void)setImage:(UIImage *)image;
- (void)resetSelfBounds:(CGRect)aBounds;


@end
