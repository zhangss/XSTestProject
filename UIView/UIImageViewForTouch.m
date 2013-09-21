    //
//  UIImageViewForTouch.m
//  XSTestProject
//
//  Created by 张永亮 on 12-11-26.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UIImageViewForTouch.h"

@implementation UIImageViewForTouch
@synthesize delegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([delegate respondsToSelector:@selector(touches:withEvent:)]) 
    {
        [delegate touches:touches withEvent:event];
    }
}

- (void)dealloc 
{
    [super dealloc];
}


@end
