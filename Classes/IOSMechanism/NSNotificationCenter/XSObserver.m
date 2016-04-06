//
//  XSObserver.m
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-10-10.
//
//

#import "XSObserver.h"

@implementation XSObserver

+ (instancetype)initWithObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
    XSObserver *tempObserver = [[XSObserver alloc] init];
    tempObserver.observer = observer;
    tempObserver.selector = aSelector;
    tempObserver.name = aName;
    tempObserver.object = anObject;
    return tempObserver;
}

@end
