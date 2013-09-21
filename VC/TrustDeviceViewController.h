//
//  TrustDeviceViewController.h
//  Megafon
//
//  Created by 张永亮 on 13-7-24.
//  Copyright (c) 2013年 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrustDeviceViewController : BaseController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray  *array;
    UITableView   *tdTableView;
}
@property(nonatomic,retain)    NSMutableArray  *array;
@end
