//
//  ThirdPartyLibraryViewController.h
//  XSTestProject
//
//  Created by 张松松 on 13-8-5.
//
//

#import "BaseController.h"

@interface ThirdPartyLibraryViewController : BaseController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *tableData;
}

@end
