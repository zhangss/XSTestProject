//
//  XSObserver.h
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-10-10.
//
//

#import <Foundation/Foundation.h>

@interface XSObserver : NSObject

@property (nonatomic, strong) id observer;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, strong) id object;

+ (instancetype)initWithObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

@end
