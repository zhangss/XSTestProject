//
//  QuestionViewController.h
//  XSTestProject
//
//  Created by 张永亮 on 12-10-16.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface QuestionViewController : BaseController <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *m_dateSource;

}

@end
