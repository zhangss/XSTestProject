//
//  AssetsLibraryViewController.h
//  XSTestProject
//
//  Created by 张松松 on 13-7-3.
//
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface AssetsLibraryViewController : BaseController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *albumGroup;
}

@end
