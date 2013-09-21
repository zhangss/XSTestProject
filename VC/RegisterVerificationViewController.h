//
//  RegisterVerificationViewController.h
//  Megafon
//
//  Created by 张永亮 on 13-4-27.
//  Copyright (c) 2013年 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "RegisterVerificationView.h"

typedef enum
{
    RegisterVC = 0,
    LoginVC
}VCType;

@interface RegisterVerificationViewController : BaseController<UITextFieldDelegate,RegisterVerificationViewDelegate>
{
    RegisterVerificationView *bgView;
    NSString   *numberString;
    NSString   *pwdString;
    NSString   *randomString;
    NSString   *random;
    NSString   *navigationTitle;
    UIScrollView *m_scrollView;
    VCType  vcType;
}
@property(nonatomic,retain)    NSString   *numberString;
@property(nonatomic,retain)    NSString   *pwdString;
@property(nonatomic,retain)    NSString   *randomString;
@property(nonatomic,retain)    NSString   *random;
@property(nonatomic,retain)    NSString   *navigationTitle;
@property(nonatomic,assign)    VCType  vcType;
- (id)initWithNumber:(NSString *)numStr andPwd:(NSString *)pwdStr andRandom:(NSString *)randomStr andVCType:(VCType)vctype andBackTitle:(NSString *)title;
@end
