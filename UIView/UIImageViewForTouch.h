//
//  UIImageViewForTouch.h
//  XSTestProject
//
//  Created by 张永亮 on 12-11-26.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

/*
 继承UIImageView 用来传递touch事件
 */

#import <UIKit/UIKit.h>
#import <Foundation/NSObject.h>

@protocol UIImageViewForTouchDelegate <NSObject>
@optional
- (void)touches:(NSSet *)touches withEvent:(UIEvent *)event;
@end


@interface UIImageViewForTouch : UIImageView
{
    id<UIImageViewForTouchDelegate> delegate;
}

@property(nonatomic, assign)id<UIImageViewForTouchDelegate> delegate;

@end
