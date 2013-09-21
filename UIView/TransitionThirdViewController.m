//
//  TransitionThirdViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-3-1.
//
//

#import "TransitionThirdViewController.h"

@interface TransitionThirdViewController ()

@end

@implementation TransitionThirdViewController

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
    self.view.backgroundColor = [UIColor blueColor];
    
    //<UIView: 0x8284c30; frame = (0 20; 320 548); autoresize = W+H; layer = <CALayer: 0x8284c00>>
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
