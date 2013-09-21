//
//  CoreDataViewController.h
//  XSTestProject
//
//  Created by 张松松 on 13-7-4.
//
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface CoreDataViewController : BaseController <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *tableData;
}

@end
