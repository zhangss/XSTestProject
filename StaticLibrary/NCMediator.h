//
//  NCMediator.h
//  Nigra-Collector-IOS
//
//  Created by SAIC_Zhangss on 14-4-11.
//  Copyright (c) 2014年 Saike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCMessage.h"

typedef NS_ENUM(NSInteger,NCType)
{
    NCTypeDefault = 0,  //默认 自主信息收集
    NCTypeGA = 1,   //GA信息收集
    NCTypeOther
};

@interface NCMediator : NSObject
{
    NCType _type;
    
}

+ (NCMediator *)sharedInstance;

#pragma mark -
#pragma mark Interface
- (void)setNCType:(NCType)type;
- (void)setDebug:(BOOL)isDebug;
- (void)setTrackingId:(NSString *)trackingId;
- (void)setTravkUnCaughtException:(BOOL)isTrack;

- (void)onStart:(NSString *)screenName;
- (void)onStop:(NSString *)screenName;
- (void)onEvent:(NCMessage *)message;
- (void)onException:(NSException *)exception inScreen:(NSString *)screenName;

@end
