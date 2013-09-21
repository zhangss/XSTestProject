//
//  UIRefreshControlInfoViewController.h
//  XSTestProject
//
//  Created by 张松松 on 13-2-26.
//
//

/*
 不会模仿的公司不是好公司不会剽窃的公司不是优秀公司
 不会调戏代码的不是骨灰级码工
 你同意吗？
 苹果估计想取代第三方的pull to refresh
 */

/*
 1.如果你装了xcode_4.5_developer_preview,那么在UITableViewController.h文件中你会看到,UITableViewController里面有如下声明,说明UITableViewController已经内置了UIRefreshControl控件
 2.UIRefreshControl目前只能用于UITableViewController，如果用在其他ViewController中,运行时会得到如下错误提示：*** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'UIRefreshControl may only be managed by a UITableViewController'（即UIRefreshControl只能被UITableViewController管理）
 */

#import <UIKit/UIKit.h>

@interface UIRefreshControlInfoViewController : UITableViewController
{
    NSInteger refreshCount;   //每次刷新之后 自加1
}

@end
