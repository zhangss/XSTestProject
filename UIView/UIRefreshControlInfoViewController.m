//
//  UIRefreshControlInfoViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-2-26.
//
//

#import "UIRefreshControlInfoViewController.h"

@interface UIRefreshControlInfoViewController ()

@end

@implementation UIRefreshControlInfoViewController
#pragma mark -
#pragma mark Init
- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Lefe Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"UIRefreshControl",@"")];
    
    //自加计数
    refreshCount = 1;
    
    // 添加UIRefreshControl下拉刷新控件到UITableViewController的view中
    /*
     虽然UITableViewController已经声明了UIRefreshControl，但是貌似还没有初始化，所以需要我们自己初始化。
     很神奇，初始化的时候并不需要给它指定frame，UITableViewController会为我们进行管理。
     遗憾的时目前只看到下拉刷新功能，上拉刷新还没有，估计在最终版里面苹果会考虑加入上拉刷新功能。
     我们还可以给UIRefreshControl设置tintColor和attributedTitle。
     */
    self.refreshControl = [[[UIRefreshControl alloc] init] autorelease];
//    self.refreshControl.tintColor = [UIColor blueColor];   //可配置颜色
    self.refreshControl.attributedTitle = [[[NSAttributedString alloc] initWithString:@"下拉刷新..."] autorelease];
    [self.refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];

}

#pragma mark -
#pragma mark Methods
-(void)RefreshViewControlEventValueChanged
{
    //检查是否正在刷新
    if (self.refreshControl.refreshing)
    {
        NSLog(@"refreshing");
        self.refreshControl.attributedTitle = [[[NSAttributedString alloc]initWithString:@"刷新中..."] autorelease];
        //手动暂停1s后刷新
        [self performSelector:@selector(handleData) withObject:nil afterDelay:1];
        
        /*
         Call this method when an external event source triggers a programmatic refresh of your table. For example, if you use an NSTimer object to refresh the contents of the table view periodically, you would call this method as part of your timer handler. This method updates the state of the refresh control to reflect the in-progress refresh operation. When the refresh operation ends, be sure to call the endRefreshing method to return the control to its default state.
         */
        //[self.refreshControl beginRefreshing];
    }
}

- (void) handleData
{
    NSLog(@"refreshed");
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[[NSAttributedString alloc]initWithString:@"下拉刷新..."] autorelease];
    
    refreshCount ++;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return refreshCount;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"UIRefreshControlCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    NSString *tmpString = [NSString stringWithFormat:@"%@ %d",@"UIRefreshControl",indexPath.row + 1];
    cell.textLabel.text = tmpString;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
