//
//  EditTrustDeviceViewController.h
//  Megafon
//
//  Created by 张永亮 on 13-7-24.
//  Copyright (c) 2013年 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlackWhiteAccount.h"
@interface EditTrustDeviceViewController : BaseController<UITextFieldDelegate>
{
    UITextField  *tdTextField;
    TrustInfo  *tInfo;
}
@property(nonatomic,retain) TrustInfo  *tInfo;
- (id)initWithData:(TrustInfo *)info;
@end
