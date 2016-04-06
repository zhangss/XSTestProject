//
//  XSNotificationCenter.m
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-10-10.
//
//

#import "XSNotificationCenter.h"
#import "XSObserver.h"

@implementation XSNotificationCenter

+ (instancetype)defaultCenter
{
    static dispatch_once_t onceToken;
    static XSNotificationCenter *center;
    dispatch_once(&onceToken, ^{
        if (center == nil) {
            center = [[XSNotificationCenter alloc] init];
        }
    });
    return center;
}

- (id)init
{
    if (self == [super init])
    {
        _observerContener = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
    XSObserver *tempObserver = [XSObserver initWithObserver:observer selector:aSelector name:aName object:anObject];
    [self addObserverToList:tempObserver];
    
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:aSelector
                                                 name:aName
                                               object:anObject];
}

- (void)postNotification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
- (void)postNotificationName:(NSString *)aName object:(id)anObject
{
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
}
- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:aName
                                                        object:anObject
                                                      userInfo:aUserInfo];
}

- (void)removeObserver:(id)observer
{
    XSObserver *tempObserver = [[XSObserver alloc] init];
    tempObserver.observer = observer;
    [self removerObserverFromList:tempObserver];
    
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}
- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject
{
    XSObserver *tempObserver = [XSObserver initWithObserver:observer selector:nil name:aName object:anObject];
    [self removerObserverFromList:tempObserver];

    [[NSNotificationCenter defaultCenter] removeObserver:observer
                                                    name:aName
                                                  object:anObject];
}

- (void)addObserverToList:(XSObserver *)observer
{
    NSMutableArray *observerList = [_observerContener objectForKey:observer.observer];
    if (observerList == nil)
    {
        observerList = [[NSMutableArray alloc] init];
    }
    [observerList addObject:observer];
    [_observerContener setObject:observerList forKey:observer.observer];
}

- (void)removerObserverFromList:(XSObserver *)observer
{
    NSMutableArray *observerList = [[NSMutableArray alloc] initWithArray:[_observerContener objectForKey:observer.observer]];
    if (observerList != nil)
    {
        for (XSObserver *tempObserver in [_observerContener objectForKey:observer.observer])
        {
            if (observer.object == nil)
            {
                if (observer.name == nil)
                {
                    //按照Observer删除
                    [observerList removeObject:tempObserver];
                }
                else
                {
                    //按照Name删除
                    if ([observer.name isEqualToString:tempObserver.name])
                    {
                        [observerList removeObject:tempObserver];
                    }
                }
            }
            else
            {
                //按照Object删除
                if ([observer.object isEqual:tempObserver.object] &&
                    [observer.name isEqualToString:tempObserver.name])
                {
                    [observerList removeObject:tempObserver];
                }
            }
        }
    }
}

@end
