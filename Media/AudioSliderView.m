//
//  AudioSliderView.m
//  Megafon
//
//  Created by 张松松 on 12-7-12.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import "AudioSliderView.h"


@implementation AudioSliderView

@synthesize delegate;
@synthesize progressLeght;

#define kProgressPointWidth 10

#pragma mark -
#pragma mark life cecle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        progressLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
        progressLine.backgroundColor = [UIColor grayColor];
        [self addSubview:progressLine];
        
        progressPoint = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1 - 5, kProgressPointWidth, 5)];
        progressPoint.backgroundColor = [UIColor grayColor];
        [self addSubview:progressPoint];
        
        progressLeght = frame.size.width - kProgressPointWidth;
    }
    return self;
}

- (void)dealloc 
{
    [progressLine release];
    [progressPoint release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITouchEvent
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"touches%@",touches);
    isTouchMoving = NO;
    touchBegin = CGPointZero;
    NSArray *touchArr = [touches allObjects];
    if ([touchArr count] > 0)
    {
        UITouch *aTouch = [touchArr objectAtIndex:0];
        CGPoint touchPoint = [aTouch locationInView:self];
        CGRect targetRect = progressPoint.frame;
        if (touchPoint.x <= targetRect.origin.x + targetRect.size.width + 10 &&
            touchPoint.x >= targetRect.origin.x &&
            touchPoint.y <= targetRect.origin.y + targetRect.size.height + 10 &&
            touchPoint.y >= targetRect.origin.y - 10 )
        {
            //满足条件 记录初始点
            touchBegin = touchPoint;
            //NSLog(@"Is touch on point Begin:%f",touchBegin.x);
            if ([delegate respondsToSelector:@selector(audioSliderMoveBegin)]) 
            {
                [delegate audioSliderMoveBegin];
            }
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray *touchArr = [touches allObjects];
    //NSLog(@"TouchMove");
    if ([touchArr count] >0)
    {
        isTouchMoving = YES;
        UITouch *aTouch = [touchArr lastObject];
        //是拖动
        if (aTouch.phase == UITouchPhaseMoved) 
        {
            CGPoint touchPoint = [aTouch locationInView:self];
            CGPoint touchPointPre = [aTouch previousLocationInView:self];
            CGFloat length = 0.0;
            if (touchBegin.x > 0)
            {
                length = touchPoint.x - touchPointPre.x;
                //NSLog(@"move from %f to %f",touchPointPre.x , touchPoint.x);
            }
            
            CGRect pointRect = progressPoint.frame;
            pointRect.origin.x += length;
            if (pointRect.origin.x >= progressLeght)
            {
                pointRect.origin.x = progressLeght;
            }
            
            if (pointRect.origin.x <= 0) 
            {
                pointRect.origin.x = 0;
            }
            progressPoint.frame = pointRect;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //事件结束
    NSArray *touchArr = [touches allObjects];
    //NSLog(@"TouchEnd:%@",touches);
    if (isTouchMoving)
    {
        if ([touchArr count] >0)
        {
            UITouch *aTouch = [touchArr objectAtIndex:0];
            CGPoint touchEndPoint = [aTouch locationInView:self];
            CGFloat length = 0.0;
            if (touchBegin.x > 0)
            {
                if (touchEndPoint.x <= 0) 
                {
                    touchEndPoint.x = 0.0;
                }
                if (touchEndPoint.x >= progressLeght)
                {
                    touchEndPoint.x = progressLeght;
                }
                //移动的长度
                if (touchEndPoint.x >= touchBegin.x) 
                {
                    length = touchEndPoint.x - touchBegin.x;
                }
                else
                {
                    length = touchBegin.x - touchEndPoint.x;
                }
                
                NSLog(@"length=%f withBegin:%f andEnd:%f",length,touchBegin.x,touchEndPoint.x);
                if (length > 0.0)
                {
                    if ([delegate respondsToSelector:@selector(audioSliderMoveEnd:)])
                    {
                        [delegate audioSliderMoveEnd:touchEndPoint.x];
                    }
                }
            }
        }
    }
    else
    {
        isTouchMoving = NO;
        touchBegin = CGPointZero;
    }
}

#pragma mark -
#pragma mark Methods
- (void)setProgressPonitValue:(CGFloat)xPoint
{
    CGRect pointRect = progressPoint.frame;
    if (xPoint >= progressLeght)
    {
        xPoint = progressLeght;
    }
    if (xPoint <= 0.0)
    {
        xPoint = 0.0;
    }
    pointRect.origin.x = xPoint;
    progressPoint.frame = pointRect;
}

@end
