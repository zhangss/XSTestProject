//
//  UICollectionViewInfoViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-2-26.
//
//

#import "UICollectionViewInfoViewController.h"
#import "UILineLayoutViewController.h"
#import "UICircleLayoutViewController.h"
#import "ToogleCollectionViewController.h"

@interface UICollectionViewInfoViewController ()

@end

@implementation UICollectionViewInfoViewController

#pragma mark -
#pragma mark Init
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        m_tableData = [[NSMutableArray alloc] init];
        
        //Line Layout
        NSString *tmpStr = NSLocalizedString(@"Line Layout",@"");
        [m_tableData addObject:tmpStr];
        
        //CirCle Layout
        tmpStr = NSLocalizedString(@"CirCle Layout",@"");
        [m_tableData addObject:tmpStr];
        
        //CirCle Layout
        tmpStr = NSLocalizedString(@"Toogle Layout",@"");
        [m_tableData addObject:tmpStr];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"Layout List",@"")];
    
    UITableView *myTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    myTableV.dataSource = self;
    myTableV.delegate = self;
    [self.view addSubview:myTableV];
    [myTableV release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSourc
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_tableData count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"LayoutCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [m_tableData objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController = nil;
    if (0 == indexPath.row)
    {
        UILineLayoutViewController *lineLayoutVC = [[UILineLayoutViewController alloc] init];
        viewController = lineLayoutVC;
        
    }
    else if (1 == indexPath.row)
    {
        UICircleLayoutViewController *circleLayoutVC = [[UICircleLayoutViewController alloc] init];
        viewController = circleLayoutVC;
    }
    else if (2 == indexPath.row)
    {
        ToogleCollectionViewController *toogleVC = [[ToogleCollectionViewController alloc] init];
        viewController = toogleVC;
    }
    
    if (viewController)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
}

#pragma mark -
#pragma mark 设备方向
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

@end
