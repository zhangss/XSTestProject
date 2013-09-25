//
//  OtherViewController.m
//  XSTestProject
//
//  Created by 张永亮 on 12-10-8.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "OtherViewController.h"

#import "DateFormatViewController.h"
#import "PNGViewController.h"
#import "UIButtonViewController.h"
#import "FileOperateViewController.h"

@implementation OtherViewController


#pragma mark -
#pragma mark Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        m_tableData = [[NSMutableArray alloc] init];
        
        //第一项 DateFormat
        NSString *dateFormatStr = [NSString stringWithString:NSLocalizedString(@"DateFormat",@"格式化时间")];
        [m_tableData addObject:dateFormatStr];
        
        //第二项 JPG/PNG
        NSString *JPG_PGNString = [NSString stringWithString:NSLocalizedString(@"JPG/PNG",@"图片的引用")];
        [m_tableData addObject:JPG_PGNString];
        
        //第三项 UIButton
        NSString *btnString = [NSString stringWithString:NSLocalizedString(@"UIButton",@"格式化时间")];
        [m_tableData addObject:btnString];
        
        //第四项 文件及文件夹操作
        NSString *fileString = [NSString stringWithString:NSLocalizedString(@"File Operation",@"文件操作")];
        [m_tableData addObject:fileString];
    }
    return self;
}

- (void)dealloc 
{
    [m_tableData release];
    [super dealloc];
}


/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad 
{
    [super viewDidLoad];

    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"Other",@"")];
    
    UITableView *myTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    myTableV.dataSource = self;
    myTableV.delegate = self;
    [self.view addSubview:myTableV];
    [myTableV release];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [m_tableData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [m_tableData objectAtIndex:indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Navigation logic may go here. Create and push another view controller.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        DateFormatViewController *dateFormatVC = [[DateFormatViewController alloc] init];
        [self.navigationController pushViewController:dateFormatVC animated:YES];
        [dateFormatVC release];
    }
    else if (indexPath.row == 1)
    {
        PNGViewController *pngVC = [[PNGViewController alloc] init];
        [self.navigationController pushViewController:pngVC animated:YES];
        [pngVC release];
    }    
    else if (indexPath.row == 2)
    {
        UIButtonViewController *btnVC = [[UIButtonViewController alloc] init];
        [self.navigationController pushViewController:btnVC animated:YES];
        [btnVC release];
    }
    else if (indexPath.row == 3)
    {
        FileOperateViewController *btnVC = [[FileOperateViewController alloc] init];
        [self.navigationController pushViewController:btnVC animated:YES];
        [btnVC release];
    }

}

@end

