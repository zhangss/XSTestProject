//
//  ZSManager.m
//  XSTestProject
//
//  Created by zhangss on 13-9-26.
//
//

#import "ZSManager.h"

@implementation ZSManager

#pragma mark -
#pragma mark Init
- (id)init
{
    self = [super init];
    if (self)
    {
        _processor = [[ZSProcessor alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_processor release];
}

@end
