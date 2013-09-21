//
//  DayTimeController.h
//  Megafon
//
//  Created by zhangshengrong on 11-10-18.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "DatePickerView.h"
@interface ingorePasteField: UITextField 
{
}
@end
@protocol DayTimeControllerDelegate<NSObject>
- (void)setParentControllerTime:(NSString *)theTime;
@end

@interface DayTimeController : BaseController
<UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
DatePickerViewDelegate> 
{
	UITableView *timeTable;
	DatePickerView *datePickView;
	UITextField *fromField;
	UITextField *toField;
	NSString *startString;
	NSString *endString;
	NSString *timeStr;
	UISwitch *switchView;
	id<DayTimeControllerDelegate> delegate;
}
@property (nonatomic, retain) UITableView *timeTable;
@property (nonatomic, retain) DatePickerView *datePickView;
@property (nonatomic, retain) UITextField *fromField;
@property (nonatomic, retain) UITextField *toField;
@property (nonatomic, retain) NSString *timeStr;
@property (nonatomic, assign) id<DayTimeControllerDelegate> delegate;
@property (nonatomic,retain) NSString *startString;
@property (nonatomic,retain) NSString *endString;
@end
