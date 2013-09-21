//
//  CoreDataViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-7-4.
//
//

#import "CoreDataViewController.h"
#import "FecthResultsViewController.h"

@interface CoreDataViewController ()

@end

@implementation CoreDataViewController

#pragma mark -
#pragma mark Init
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        tableData = [[NSMutableArray alloc] init];
        
        //NSFetchResultsController
        NSString *tempStr = NSLocalizedString(@"FecthResultsController", @"数据库查询控制器");
        [tableData addObject:tempStr];

        /*
         这样初始化会有问题
        UIViewController *tempController = [[FecthResultsViewController alloc] init];
        [tableSelectData addObject:tempController];
        [tempController release];
         */
    }
    return self;
}

- (void)dealloc
{
    [tableData release];
    [super dealloc];
}

#pragma mark -
#pragma mark Life Cycel
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"CoreData Info", @"数据库相关")];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mrak UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier] autorelease];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        UIViewController *fetchController = [[FecthResultsViewController alloc] init];
        [self.navigationController pushViewController:fetchController animated:YES];
        [fetchController release];
    }
}

#pragma mark -
#pragma mark Other Methods

@end
