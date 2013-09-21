//
//  TransitionFirstViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-3-1.
//
//

#import "TransitionFirstViewController.h"

@interface TransitionFirstViewController ()

@end

@implementation TransitionFirstViewController


- (void)dealloc
{
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    CGRect selfRect = self.view.frame;
    selfRect.origin.y = 0.0;
    self.view.frame = selfRect;
}

//IOS 5的新特性 对视图的创建及释放
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
