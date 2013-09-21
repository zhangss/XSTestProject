//
//  CoreGraphicView.m
//  XSTestProject
//
//  Created by zhangss on 13-9-12.
//
//

#import "CoreGraphicView.h"

@implementation CoreGraphicView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    NSLog(@"%@",NSStringFromCGRect(rect));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *aColor = [UIColor greenColor];
    CGContextSetFillColorWithColor(context, aColor.CGColor);
    CGContextFillRect(context, CGRectMake(5, 5, 290, 140));
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBFillColor(context, 1, 1, 1, 1.0);
    UIFont *font = [UIFont boldSystemFontOfSize:11.0];
    [@"abcd" drawInRect:CGRectMake(10, 10, 30, 10) withFont:font];

    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBFillColor(context, 1, 1, 1, 1.0);
    CGContextMoveToPoint(context, 20, 30);
    CGContextAddLineToPoint(context, 40, 100);
//    CGContextDrawPath(context, kCGPathStroke);
    CGContextStrokePath(context);
}

@end
