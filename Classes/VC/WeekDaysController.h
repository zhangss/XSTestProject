//
//  WeekDaysController.h
//  Megafon
//
//  Created by zhangshengrong on 11-10-18.
//  Copyright 2011 华为技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "ForwardPolicy.h"

@protocol WeekDaysControllerDelegate<NSObject>
- (void)setParentControllerDays:(NSString *)theDays;
@end

@interface WeekDaysController : BaseController <UITableViewDelegate,UITableViewDataSource>
{
	NSArray *weekDays;
	NSMutableDictionary *currentDays;
	UITableView *daysTable;
	id<WeekDaysControllerDelegate> delegate;
}
@property (nonatomic, retain) NSMutableDictionary *currentDays;
@property (nonatomic, assign) id<WeekDaysControllerDelegate> delegate;
- (void) addDay:(BOOL)ischecked withIndex:(NSInteger)index;

@end
