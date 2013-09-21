//
//  ImStateViewController.h
//  Megafon
////  manage by  zhengxiaohe on 11-10-31

//  Copyright 2012年 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThirdAccountInfo;
@class RCSAccount;
@interface ImStateViewController : BaseController<UITableViewDataSource,UITableViewDelegate>
{
     UITableView* table;
     NSInteger imType;
     NSArray* gtalkOrOdStateArr; 
     NSArray* vkStateArr;  
     NSArray* mtfonOrMruOrIcqStateArr;
     ThirdAccountInfo *tdIMAccount;    //保存第三方帐号
     NSNumber      *tempStatus;       //第三方状态
     RCSAccount *currentAccount;
     NSInteger isOldSelected;
}
@property (nonatomic, retain)  UITableView* table;
@property (nonatomic, assign)  NSInteger imType;
@property (nonatomic, retain)  NSArray* gtalkOrOdStateArr;
@property (nonatomic, retain)  NSArray* vkStateArr; 
@property (nonatomic, retain)  NSArray* mtfonOrMruOrIcqStateArr;
- (void)distributionImState;
@end
