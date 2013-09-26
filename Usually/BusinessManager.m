//
//  BusinessManager.m
//  XSTestProject
//
//  Created by zhangss on 13-9-26.
//
//

#import "BusinessManager.h"

@implementation BusinessManager

static BusinessManager *sharedManager = nil;
+ (BusinessManager *)sharedManager
{
    if (sharedManager == nil)
    {
        @synchronized(self)
        {
            if (sharedManager == nil)
            {
                sharedManager = [[BusinessManager alloc] init];
            }
        }
    }
    return sharedManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    if (sharedManager == nil)
    {
        @synchronized(self)
        {
            if (sharedManager == nil)
            {
                sharedManager = [super allocWithZone:zone];
            }
        }
    }
    return sharedManager;
}


- (id)init
{
    if (self = [super init])
    {
        [sharedManager initWithBusiness];
    }
    return self;
}


- (void)initWithBusiness
{
    //Manager初始化
}


@end
