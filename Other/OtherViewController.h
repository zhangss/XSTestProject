//
//  OtherViewController.h
//  XSTestProject
//
//  Created by 张永亮 on 12-10-8.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface OtherViewController : BaseController <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *m_tableData; //数据源
}

@end
