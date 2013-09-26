//
//  BaseManager.m
//  XSTestProject
//
//  Created by zhangss on 13-9-26.
//
//

#import "BaseManager.h"

@implementation BaseManager

#pragma mark -
#pragma mark Common Methods
- (void)notificationOnMainWith:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo
{
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       //UI修改 主线程抛出通知
                       [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:userInfo];
                   });
}

@end
