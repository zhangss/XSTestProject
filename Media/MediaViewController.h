//
//  MediaViewController.h
//  XSTestProject
//
//  Created by 张松松 on 12-7-2.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface MediaViewController : BaseController<UITableViewDelegate,UITableViewDataSource> 
{
    NSMutableArray *m_tableData;
}

@end
