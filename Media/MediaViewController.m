    //
//  MediaViewController.m
//  XSTestProject
//
//  Created by 张松松 on 12-7-2.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MediaViewController.h"

#import "XSTestUtils.h"

#import "AudioViewController.h"
#import "VideoViewController.h"

@implementation MediaViewController


#pragma mark -
#pragma mark Init
- (id)init
{
    self = [super init];
    if (self)
    {
        m_tableData = [[NSMutableArray alloc] init];
        
        //第一个 音频播放
        NSString *audioStr = [NSString stringWithString:NSLocalizedString(@"Audio",@"音频相关")];
        [m_tableData addObject:audioStr];
        
        //第二个 视频相关
        audioStr = [NSString stringWithString:NSLocalizedString(@"Video",@"视频相关")];
        [m_tableData addObject:audioStr];
    }
    return self;
}

- (void)dealloc {
    [m_tableData release];
    [super dealloc];
}

#pragma mark -
#pragma mark life cycle
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"Media",@"")];
    
    UITableView *myTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    myTableV.dataSource = self;
    myTableV.delegate = self;
    [self.view addSubview:myTableV];
    [myTableV release];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark Methods


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
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (0 == indexPath.row)
    {
        AudioViewController *audioV = [[AudioViewController alloc] init];
        audioV.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:audioV animated:YES];
        [audioV release];
    }
    else if (1 == indexPath.row)
    {
        VideoViewController *videoV = [[VideoViewController alloc] init];
        videoV.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:videoV animated:YES];
        [videoV release];
    }
}

@end
