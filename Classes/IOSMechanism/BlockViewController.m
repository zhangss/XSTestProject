//
//  BlockViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-8-10.
//
//

#import "BlockViewController.h"
#import "XSTestUtils.h"

@interface BlockViewController ()

@end

@implementation BlockViewController

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
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"Block Info", @"")];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
