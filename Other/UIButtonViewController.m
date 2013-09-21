    //
//  UIButtonViewController.m
//  XSTestProject
//
//  Created by 张永亮 on 12-11-15.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UIButtonViewController.h"


@implementation UIButtonViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Button 的titile位置
    NSString *stringShort = @"111111111111111111111111";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor blackColor]];
    btn.titleLabel.backgroundColor = [UIColor blueColor];
    [btn setTitle:stringShort forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 5, 300, 40);
    [self.view addSubview:btn];
    
//    UIButton *btnTitle = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnTitle setBackgroundColor:[UIColor redColor]];
//    btnTitle.titleLabel.backgroundColor = [UIColor blueColor];
//    [btnTitle setTitle:stringShort forState:UIControlStateNormal];
//    btnTitle.frame = CGRectMake(300, 5, 100, 40);
//    [self.view addSubview:btnTitle];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundColor:[UIColor blackColor]];
    btn1.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 50);
    btn1.titleLabel.backgroundColor = [UIColor blueColor];
    [btn1 setTitle:stringShort forState:UIControlStateNormal];
    btn1.frame = CGRectMake(10, 65, 300, 40);
    [self.view addSubview:btn1];

//    UIButton *btnTitle1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnTitle1 setBackgroundColor:[UIColor redColor]];
//    btnTitle1.titleEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
//    btnTitle1.titleLabel.backgroundColor = [UIColor blueColor];
//    [btnTitle1 setTitle:stringShort forState:UIControlStateNormal];
//    btnTitle1.frame = CGRectMake(200, 55, 100, 40);
//    [self.view addSubview:btnTitle1];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setBackgroundColor:[UIColor blackColor]];
    btn2.contentEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
    btn2.titleLabel.backgroundColor = [UIColor blueColor];
    [btn2 setTitle:stringShort forState:UIControlStateNormal];
    btn2.frame = CGRectMake(10, 105, 200, 40);
    [self.view addSubview:btn2];
    
    UIButton *btnTitle2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnTitle2 setBackgroundColor:[UIColor redColor]];
    btnTitle2.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    btnTitle2.titleLabel.backgroundColor = [UIColor blueColor];
    [btnTitle2 setTitle:stringShort forState:UIControlStateNormal];
    btnTitle2.frame = CGRectMake(300, 105, 100, 40);
    [self.view addSubview:btnTitle2];
    
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setBackgroundColor:[UIColor blackColor]];
    btn3.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 20, 0);
    btn3.titleLabel.backgroundColor = [UIColor blueColor];
    [btn3 setTitle:stringShort forState:UIControlStateNormal];
    btn3.frame = CGRectMake(10, 155, 100, 40);
    [self.view addSubview:btn3];
    
    UIButton *btnTitle3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnTitle3 setBackgroundColor:[UIColor redColor]];
    btnTitle3.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 20, 0);
    btnTitle3.titleLabel.backgroundColor = [UIColor blueColor];
    [btnTitle3 setTitle:stringShort forState:UIControlStateNormal];
    btnTitle3.frame = CGRectMake(200, 155, 100, 40);
    [self.view addSubview:btnTitle3];
    
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [btn4 setBackgroundColor:[UIColor blackColor]];
    btn4.titleLabel.backgroundColor = [UIColor blueColor];
    [btn4 setTitle:stringShort forState:UIControlStateNormal];
    btn4.frame = CGRectMake(10, 205, 100, 40);
    [self.view addSubview:btn4];
    
    UIButton *btnTitle4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTitle4.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    btnTitle4.titleLabel.backgroundColor = [UIColor blueColor];
    [btnTitle4 setBackgroundColor:[UIColor redColor]];
    [btnTitle4 setTitle:stringShort forState:UIControlStateNormal];
    btnTitle4.frame = CGRectMake(200, 205, 100, 40);
    [self.view addSubview:btnTitle4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
    [btn5 setBackgroundColor:[UIColor blackColor]];
    btn5.titleLabel.backgroundColor = [UIColor blueColor];
    [btn5 setTitle:stringShort forState:UIControlStateNormal];
    btn5.frame = CGRectMake(10, 255, 100, 40);
    [self.view addSubview:btn5];
    
    UIButton *btnTitle5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTitle5.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
    btnTitle5.titleLabel.backgroundColor = [UIColor blueColor];
    [btnTitle5 setBackgroundColor:[UIColor redColor]];
    [btnTitle5 setTitle:stringShort forState:UIControlStateNormal];
    btnTitle5.frame = CGRectMake(200, 255, 100, 40);
    [self.view addSubview:btnTitle5];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn6.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    btn6.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [btn6 setBackgroundColor:[UIColor blackColor]];
    btn6.titleLabel.backgroundColor = [UIColor blueColor];
    [btn6 setTitle:stringShort forState:UIControlStateNormal];
    btn6.frame = CGRectMake(10, 305, 100, 40);
    [self.view addSubview:btn6];
    
    UIButton *btnTitle6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTitle6.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 20, 0);
    btnTitle6.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 20, 0);
    btnTitle6.titleLabel.backgroundColor = [UIColor blueColor];
    [btnTitle6 setBackgroundColor:[UIColor blueColor]];
    [btnTitle6 setTitle:stringShort forState:UIControlStateNormal];
    [btnTitle6 addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchUpInside];
    btnTitle6.frame = CGRectMake(200, 305, 100, 40);
    [self.view addSubview:btnTitle6];
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width / 3, 40)];
    aView.backgroundColor = [UIColor redColor];
    aView.tag = 100;
    [self.view addSubview:aView];
    [aView release];
    
}

- (void)touchDown:(id)sender
{
    UIView *aView = [self.view viewWithTag:100];
    CGRect selfFrame = aView.frame;
    if (selfFrame.origin.x == 0)
    {
        selfFrame.origin.x = self.view.frame.size.width / 3 * 2;
    }
    else
    {
        selfFrame.origin.x = 0;
    }
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:.3];
    aView.frame = selfFrame;
    [UIView commitAnimations];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
