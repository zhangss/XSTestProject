//
//  IOSJSONViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-11-21.
//
//

#import "IOSJSONViewController.h"

@interface IOSJSONViewController ()

@end

@implementation IOSJSONViewController

#pragma mark -
#pragma mark Init / Dealloc
- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark Life Cycel
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSArray *jsonType = [NSArray arrayWithObjects:
                         @"NSJSONSerialization",
                         @"JSONKit",
                         @"SBJSON",
                         @"TouchJson",nil];
    UISegmentedControl *segement = [[UISegmentedControl alloc] initWithItems:jsonType];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Methods

@end
