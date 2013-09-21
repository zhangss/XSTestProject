//
//  IOSMechanismViewController.h
//  XSTestProject
//
//  Created by 张松松 on 13-5-16.
//
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface IOSMechanismViewController : BaseController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray     *m_tableData;
}

@end
