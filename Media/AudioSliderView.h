//
//  AudioSliderView.h
//  Megafon
//
//  Created by 张松松 on 12-7-12.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AudioSliderViewDelegate <NSObject>
- (void)audioSliderMoveBegin;
- (void)audioSliderMoveEnd:(CGFloat)progressValue;

@end



@interface AudioSliderView : UIView {

    UIView *progressLine;
    UIView *progressPoint;
    
    CGPoint touchBegin;
    BOOL isTouchMoving;
    id<AudioSliderViewDelegate> delegate;
    
    CGFloat progressLeght;
}

@property (nonatomic,assign) id<AudioSliderViewDelegate> delegate;
@property (nonatomic,assign) CGFloat progressLeght;

- (void)setProgressPonitValue:(CGFloat)xPoint;

@end
