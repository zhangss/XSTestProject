//
//  UIViewInfoController.h
//  XSTestProject
//
//  Created by 张永亮 on 12-11-24.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

/*
 所有的UIView的子类介绍
 */

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface UIViewInfoController : BaseController <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *m_tableData;
}

/*
 加载循环:
 1.程序请求了controller的view.或者访问了View属性
 2.如果view当前不在内存中，controller调用loadview函数。
 loadView 进行如下操作:
 <1>如果你重载了这个函数，你应该自己创建必要的views并且将一个非nil值赋给view属性
 <2>如果你没有重载这个函数，默认实现会使用controller的nibName 和 nibBundle属性来尝试从nib文件加载view。如果没有找到nib文件，它尝试寻找一个与view controller类名匹配（viewControllerClassName.nib）的nib文件。
 <3>如果没有可用的nib文件，那么它创建一个空的UIView作为它的view。
 3.controller 调用  viewDidLoad 方法来执行一些加载时（加载时一词，相对于编译时、运行时）任务.程序可以重载loadView 和 viewDidLoad来执行一些任务
 
 卸载循环:
 1.程序收到内存警告.
 每个view controller调用 didReceiveMemoryWarning:
 If you override this method, you should use it to release any custom data that your view controller object no longer needs. You should not use it to release your view controller’s view. You must call super at some point in your implementation to perform the default behavior.（iOS3.0以后不建议重载这个函数来进行额外的清除操作，使用viewDidUnload）
 
 2.默认实现会在确定可以安全地释放view时释放掉view。
 如果controller释放了它的view, 它会调用 viewDidUnload. .可以重载这个函数来进行额外的清理操作（不要清除view和那些加载循环中无法rebuild的数据）。
 */

@end
