//
//  BaseManager.h
//  XSTestProject
//
//  Created by zhangss on 13-9-26.
//
//

#import <Foundation/Foundation.h>

@interface BaseManager : NSObject

//公共方法
- (void)notificationOnMainWith:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo;

@end
