//
//  BaseController.h
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

//此方法换肤 继承自本控制器的控制器不能重写loadView方法 否则不响应换肤动作

#import <UIKit/UIKit.h>
#import "ThemeManager.h"
#import "GAITrackedViewController.h"

@interface BaseController : GAITrackedViewController {

}

@end
