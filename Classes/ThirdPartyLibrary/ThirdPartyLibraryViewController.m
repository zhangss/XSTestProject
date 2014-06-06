//
//  ThirdPartyLibraryViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-8-5.
//
//

#import "ThirdPartyLibraryViewController.h"
#import "GAViewController.h"
#import "TestFlightViewController.h"
#import "QQLoginViewController.h"
#import "IOSJSONViewController.h"

@interface ThirdPartyLibraryViewController ()

@end

@implementation ThirdPartyLibraryViewController

#pragma mark -
#pragma mark init
- (id)init
{
    self = [super init];
    if (self)
    {
        tableData = [[NSMutableArray alloc] init];
        
        //GA相关简介
        NSString *tempStr = @"Google AnaLytics";
        [tableData addObject:tempStr];
        
        //TestFlight相关介绍
        tempStr = @"Test Flight";
        [tableData addObject:tempStr];
        
        //QQAPI相关介绍
        tempStr = @"QQ Open API";
        [tableData addObject:tempStr];
        
        //IOS JSON相关介绍
        tempStr = @"IOS JSON";
        [tableData addObject:tempStr];
    }
    return self;
}

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
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"Third Party Library", @"第三方类库使用")];
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    [table release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ThirdPartyCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark Device Direction
/*
 //iPhone的重力感应装置感应到屏幕由横向变为纵向或者由纵向变为横向是调用此方法。如返回结果为NO，则不自动调整显示方式；如返回结果为YES，则自动调整显示方式。
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController = nil;
    if (0 == indexPath.row)
    {
        GAViewController *gaVC = [[GAViewController alloc] init];
        viewController = gaVC;
        
    }
    else if (1 == indexPath.row)
    {
        TestFlightViewController *testFlightVC = [[TestFlightViewController alloc] init];
        viewController = testFlightVC;
    }
    else if (2 == indexPath.row)
    {
        QQLoginViewController *testFlightVC = [[QQLoginViewController alloc] init];
        viewController = testFlightVC;
    }
    else if (3 == indexPath.row)
    {
        IOSJSONViewController *jsonVC = [[IOSJSONViewController alloc] init];
        viewController = jsonVC;
    }
    
    if (viewController)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
}

@end
