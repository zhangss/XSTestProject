//
//  TestFlightViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-8-5.
//
//

#import "TestFlightViewController.h"
#import "XSTestUtils.h"

@interface TestFlightViewController ()

@end

@implementation TestFlightViewController

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
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"Test Flight", @"")];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
