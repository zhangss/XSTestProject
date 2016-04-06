//
//  XSNotificationCenter.h
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-10-10.
//
//

#import <Foundation/Foundation.h>

@interface XSNotificationCenter : NSObject

@property (nonatomic, readonly, strong) NSMutableDictionary *observerContener;

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

- (void)postNotification:(NSNotification *)notification;
- (void)postNotificationName:(NSString *)aName object:(id)anObject;
- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject;

@end
