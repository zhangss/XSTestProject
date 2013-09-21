//
//  TransitionSecondViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-3-1.
//
//

#import "TransitionSecondViewController.h"

@interface TransitionSecondViewController ()

@end

@implementation TransitionSecondViewController


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
    self.view.backgroundColor = [UIColor greenColor];
    
    CGRect selfRect = self.view.frame;
    selfRect.origin.y = 0.0;
    self.view.frame = selfRect;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
