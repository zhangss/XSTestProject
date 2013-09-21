//
//  UIImageViewInfoViewController.h
//  XSTestProject
//
//  Created by 张永亮 on 12-11-26.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "UIBigImageView.h"

/*
 UIImageView 查看大图
 1.点击全屏查看图片
 2.双击双倍放大图片
 3.单击或者点击按钮大图消失
 */

@interface UIImageViewInfoViewController : BaseController <UIBigImageViewDelegate>
{
    NSMutableArray *imageArr;
}

@end
