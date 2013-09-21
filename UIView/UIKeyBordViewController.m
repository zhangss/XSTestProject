//
//  UIKeyBordViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-6-5.
//
//

#import "UIKeyBordViewController.h"

@interface UIKeyBordViewController ()

@end

#define kTextFieldTag 100

@implementation UIKeyBordViewController

#pragma mark -
#pragma mark Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self addKeyBoradNotify];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark -
#pragma mark Lyfe Cycel
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"Keyboard", nil)];
    UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake( VIEW_INTERVAL, VIEW_INTERVAL, self.view.frame.size.width - VIEW_INTERVAL * 2, VIEW_INTERVAL * 3)];
    textFiled.borderStyle = UITextBorderStyleLine;
    textFiled.borderStyle = UITextBorderStyleRoundedRect;
    textFiled.tag = kTextFieldTag;
    [self.view addSubview:textFiled];
    [textFiled release];
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    aButton.frame = CGRectMake(VIEW_INTERVAL, VIEW_INTERVAL + textFiled.frame.origin.y + textFiled.frame.size.height, VIEW_INTERVAL * 4, VIEW_INTERVAL * 2);
    [aButton addTarget:self action:@selector(aButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
    [aButton setTitle:NSLocalizedString(@"Send", @"") forState:UIControlStateNormal];
    [aButton sizeToFit];
    [self.view addSubview:aButton];
    
    //逻辑代码
    [textFiled becomeFirstResponder];

//崩溃测试
//    NSString *jidStr = @"123";
//    NSString *suffixStr = @"1";
//    NSRange range = [jidStr rangeOfString:suffixStr];
//    {
//        NSString *jid = [jidStr stringByReplacingCharactersInRange:range withString:@"@gmail.com"];
//
//    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Methods
/*
 功能描述:点击发送之后，如果键盘是第一响应者,并且键盘切换到了数字或者特殊字符模式。
         那么点击发送，重置键盘到默认模式，如原生IMessage会话那样。
 <1>暂时找不到正确的API 只能使textField暂时失去第一响应者然后在获取第一响应者 从而达到重置键盘效果。
 <2>已经找到API 重新加载InputView
 */
- (void)aButtonTaped:(id)sender
{
    UITextField *textField = (UITextField *)[self.view viewWithTag:kTextFieldTag];
//    if ([textField isFirstResponder])
//    {
//        [textField resignFirstResponder];
//        [textField becomeFirstResponder];
//    }
    [textField reloadInputViews];
}

#pragma mark -
#pragma mark KeyBoard Notification
- (void)addKeyBoradNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoradWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoradWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyBoradWillShow:(NSNotification *)noti
{
    NSLog(@"keyBoradWillShow:%@",noti);
}

- (void)keyBoradWillHide:(NSNotification *)noti
{
    NSLog(@"keyBoradWillHide:%@",noti);
}

@end
