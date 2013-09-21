//
//  TestTableViewController.h
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface TestTableViewController : BaseController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *tableData;    //例子种类列表
}

@end
