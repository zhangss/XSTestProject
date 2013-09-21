//
//  GAConfiger.h
//  XSTestProject
//
//  Created by 张松松 on 13-8-1.
//
//

#import <Foundation/Foundation.h>
#import "GAITracker.h"

@interface GAConfiger : NSObject
{
    id <GAITracker> tracker;
    
}
@property (nonatomic,retain)id <GAITracker> tracker;

+ (GAConfiger *)shareInStrance;

#pragma mark -
#pragma mark Google Analized
- (void)addAndStartGA;
//增加GA检测点
- (void)addGATrackerWithCategory:(NSString *)category
                      withAction:(NSString *)action
                       withLabel:(NSString *)label
                       withValue:(NSNumber *)value;
//
- (BOOL)sendGATimingWithCategory:(NSString *)category
                       withValue:(NSTimeInterval)time
                        withName:(NSString *)name
                       withLabel:(NSString *)label;

@end
