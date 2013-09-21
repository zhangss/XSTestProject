//
//  IOSMechanismViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-5-16.
//
//

#import "IOSMechanismViewController.h"
#import "CALayerViewController.h"
#import "CoreAnimationViewController.h"
#import "BlockViewController.h"

@interface IOSMechanismViewController ()

@end

@implementation IOSMechanismViewController

#pragma mark - 
#pragma mark Init
- (id)init
{
    self = [super init];
    if (self)
    {
        m_tableData = [[NSMutableArray alloc] initWithCapacity:3];
        
        NSString *string = nil;
        
        string = NSLocalizedString(@"CALayer", @"");
        [m_tableData addObject:string];
        
        string = NSLocalizedString(@"CoreAnimation", @"");
        [m_tableData addObject:string];
        
        string = NSLocalizedString(@"Block", @"");
        [m_tableData addObject:string];
    }
    return  self;
}

- (void)dealloc
{
    [m_tableData release];
    [super dealloc];
}

#pragma mark -
#pragma mark Life Cycel
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"IOS Mechanism", @"")];
    
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    [tableV release];
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
    return [m_tableData count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [m_tableData objectAtIndex:indexPath.row];
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
        CALayerViewController *CALayerVC = [[CALayerViewController alloc] init];
        viewController = CALayerVC;
    }
    if (1 == indexPath.row)
    {
        CoreAnimationViewController *coreAnimationVC = [[CoreAnimationViewController alloc] init];
        viewController = coreAnimationVC;
    }
    if (1 == indexPath.row)
    {
        BlockViewController *blockVC = [[BlockViewController alloc] init];
        viewController = blockVC;
    }
    
    if (viewController)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
}


@end
