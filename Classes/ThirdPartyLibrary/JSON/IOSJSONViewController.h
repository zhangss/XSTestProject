//
//  IOSJSONViewController.h
//  XSTestProject
//
//  Created by 张松松 on 13-11-21.
//
//

typedef NS_ENUM(NSInteger, JSONType)
{
    JSONTypeiOS = 0,
    JSONTypeJsonKit = 1,
    JSONTypeSBJson = 2,
    JSONTypeTouchJson = 3
};

#import "BaseController.h"

@interface IOSJSONViewController : BaseController <UITableViewDataSource,UITableViewDelegate>

@end
