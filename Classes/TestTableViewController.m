    //
//  TestTableViewController.m
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TestTableViewController.h"

#import "MediaViewController.h"
#import "UIViewInfoController.h"
#import "OtherViewController.h"
#import "IOSMechanismViewController.h"
#import "IOSExceptionViewController.h"
#import "CoreDataViewController.h"
#import "SimpleCrashViewController.h"
#import "ThirdPartyLibraryViewController.h"

@implementation TestTableViewController

#pragma mark -
#pragma mark Init
- (id)init 
{
    self = [super init];
    if (self)
    {
        tableData = [[NSMutableArray alloc] init];
        
        //初始化逻辑数据源
        //第一个多媒体
        NSString *mediaStr = [NSString stringWithString:NSLocalizedString(@"Media",@"多媒体类别")];
        [tableData addObject:mediaStr];
        
        //第二个UIView
        NSString *viewStr = [NSString stringWithString:NSLocalizedString(@"UIView",@"View研究")];
        [tableData addObject:viewStr];

        //第三个IOS机制 Mechanism[ˈmekəˌnɪzəm]机制 机能
        NSString *iosMechanism = NSLocalizedString(@"IOS Mechanism", @"IOS机制");
        [tableData addObject:iosMechanism];
        
        //第三个IOSException 异常处理捕获
        NSString *iosException = NSLocalizedString(@"IOS Exception", @"IOS异常");
        [tableData addObject:iosException];
        
        //第四个 数据库相关
        NSString *coreDataInfo = NSLocalizedString(@"CoreData Info", @"数据库相关");
        [tableData addObject:coreDataInfo];
        
        //第五个 简单崩溃记录
        NSString *crashRecord = NSLocalizedString(@"Simple Crash Record", @"简单崩溃记录");
        [tableData addObject:crashRecord];
        
        //第六个 其他的第三方库
        NSString *thirdPartyLibrary = NSLocalizedString(@"Third Party Library", @"其他的第三方类库");
        [tableData addObject:thirdPartyLibrary];
        
        //最后一个
        NSString *otherStr = [NSString stringWithString:NSLocalizedString(@"Other",@"其它类型 杂乱的小类型")];
        [tableData addObject:otherStr];
    }
    return self;
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
    
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"List",@"")];
    
    //初始化一个Plan类型的TableV
    UITableView *myTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

    /*1
     @property(nonatomic,readonly) UITableViewStyle style;
     */
    //if (myTableV.style == UITableViewStylePlain)
    
    /*2
     @property(nonatomic,assign)   id <UITableViewDataSource> dataSource;
     @property(nonatomic,assign)   id <UITableViewDelegate>   delegate;     
     */
    myTableV.delegate = self;
    myTableV.dataSource = self;
    
    
    [self.view addSubview:myTableV];

    
    /*3
     //当使用Delegate是指cellHeight或者HeaderHeight及FooterHeight时 以代理为准
     will return the default value if unset
     @property(nonatomic)          CGFloat                    rowHeight;
     @property(nonatomic)          CGFloat                    sectionHeaderHeight;
     @property(nonatomic)          CGFloat                    sectionFooterHeight;   
     */
    
    /*4
     the background view will be automatically resized to track the size of the table view.  
     this will be placed as a subview of the table view behind all cells and headers/footers.  
     default may be non-nil for some devices.
    @property(nonatomic, readwrite, retain) UIView *backgroundView __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_2); 
     */
    myTableV.backgroundView = nil;
    
    /*5
     Editing. When set, rows show insert/delete/reorder controls based on data source queries
     default is NO. setting is not animated.
     @property(nonatomic,getter=isEditing) BOOL editing;                             
     - (void)setEditing:(BOOL)editing animated:(BOOL)animated;
     */
    //myTableV.editing 
    [myTableV setEditing:NO animated:NO];
    
    /*6
     default is YES. Controls whether rows can be selected when not in editing mode
     @property(nonatomic) BOOL allowsSelection __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);  
     
     default is NO. Controls whether rows can be selected when in editing mode
     @property(nonatomic) BOOL allowsSelectionDuringEditing;                        
     */
    
    /*7
    show special section index list on right when row count reaches this value. default is NSIntegerMax
    行计数达到此值时在右边显示特殊地段索引列表 仅适用与Plan格式
    @property(nonatomic) NSInteger sectionIndexMinimumDisplayRowCount;
    */
    
    /*8
     Style需要在cellForRow中设置
     @property(nonatomic) UITableViewCellSeparatorStyle separatorStyle;// default is UITableViewCellSeparatorStyleSingleLine
     typedef enum {
     UITableViewCellSeparatorStyleNone,
     UITableViewCellSeparatorStyleSingleLine,
     UITableViewCellSeparatorStyleSingleLineEtched   // This separator style is only supported for grouped style table views currently
     } UITableViewCellSeparatorStyle;
     
     @property(nonatomic,retain) UIColor               *separatorColor;// default is the standard separator gray
    */
    
    /*9 
     confused: [kənˈfjuzd]混乱的混淆的
     @property(nonatomic,retain) UIView *tableHeaderView;// accessory view for above row content. default is nil. not to be confused with section header
     @property(nonatomic,retain) UIView *tableFooterView;// accessory view below content. default is nil. not to be confused with section footer
    */
    
    //方法
    // Data
    /*1.
     // reloads everything from scratch. redisplays visible rows. because we only keep info about visible rows, this is cheap. will adjust offset if table shrinks
     - (void)reloadData;
     */
    
    /*2.
    - (void)reloadSectionIndexTitles __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);   // reloads the index bar.
    
    // Info
    
    - (NSInteger)numberOfSections;
    - (NSInteger)numberOfRowsInSection:(NSInteger)section;
    
    - (CGRect)rectForSection:(NSInteger)section;                                    // includes header, footer and all rows
    - (CGRect)rectForHeaderInSection:(NSInteger)section;
    - (CGRect)rectForFooterInSection:(NSInteger)section;
    - (CGRect)rectForRowAtIndexPath:(NSIndexPath *)indexPath;
    
    - (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point;                         // returns nil if point is outside table
    - (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell;                      // returns nil if cell is not visible
    - (NSArray *)indexPathsForRowsInRect:(CGRect)rect;                              // returns nil if rect not valid 
    
     returns nil if cell is not visible or index path is out of range
    - (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
    - (NSArray *)visibleCells;
    - (NSArray *)indexPathsForVisibleRows;
    
    - (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
    - (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
    
    // Row insertion/deletion/reloading.
    
    - (void)beginUpdates;   // allow multiple insert/delete of rows and sections to be animated simultaneously. Nestable
    - (void)endUpdates;     // only call insert/delete/reload calls or change the editing state inside an update block.  otherwise things like row count, etc. may be invalid.
    
    - (void)insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
    - (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
    - (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);
    
    - (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
    - (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
    - (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);
    // Selection
    
    - (NSIndexPath *)indexPathForSelectedRow;                                       // return nil or index path representing section and row of selection.
    
    // Selects and deselects rows. These methods will not call the delegate methods (-tableView:willSelectRowAtIndexPath: or tableView:didSelectRowAtIndexPath:), nor will it send out a notification.
    - (void)selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
    - (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
    - (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;  // Used by the delegate to acquire an already allocated cell, in lieu of allocating a new one.
     */
    [myTableV release];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    /*在内存紧张的时候 同时界面在后台显示时会调用此方法释放一些视图 当界面重新出现在前台时重新ViewDidLoad加载视图UI*/
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [tableData release];
    [super dealloc];
}

#pragma mark -
#pragma mark Methods


#pragma mark -
#pragma mark UITableViewDataSource
// @required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
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
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

// @optional
// Default is 1 if not implemented
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//
//}             

// fixed font style. use custom view (UILabel) if you want something different
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//
//}
//
//
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//
//}
//
//// Editing
//
//// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//// Moving/reordering
//
//// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//// Index
//
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//
//}
//
//// tell table which section corresponds to section title/index (e.g. "B",1))
//// return list of section titles to display in section index view (e.g. "ABCD...Z#")
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    
//}
//
//// Data manipulation - insert and delete support
//
//// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//// Data manipulation - reorder / moving support
//
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//
//}


#pragma mark -
#pragma mark UITableViewDelegate
// @optional
// Display customization
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

// Variable height support
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
//{
//    
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
//{
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//}

// Section header & footer information. Views are preferred over title should you decide to provide both
// custom view for header. will be adjusted to default or specified header height
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//}
//
//// custom view for footer. will be adjusted to default or specified footer height
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//
//}

// Accessories (disclosures). 
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
//{
//
//}

// Selection
// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        MediaViewController *mediaV = [[MediaViewController alloc] init];
        mediaV.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mediaV animated:YES];
        [mediaV release];
    }
    else if (indexPath.row == 1)
    {
        UIViewInfoController *viewInfoVC = [[UIViewInfoController alloc] init];
        viewInfoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewInfoVC animated:YES];
        [viewInfoVC release];
    }
    else if (indexPath.row == 2)
    {
        IOSMechanismViewController *iosMechanismVC = [[IOSMechanismViewController alloc] init];
        iosMechanismVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:iosMechanismVC animated:YES];
        [iosMechanismVC release];
    }
    else if (indexPath.row == 3)
    {
        IOSExceptionViewController *iosExceptionVC = [[IOSExceptionViewController alloc] init];
        iosExceptionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:iosExceptionVC animated:YES];
        [iosExceptionVC release];
    }
    else if (indexPath.row == 4)
    {
        CoreDataViewController *coreDataVC = [[CoreDataViewController alloc] init];
        coreDataVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:coreDataVC animated:YES];
        [coreDataVC release];
    }
    else if (indexPath.row == 5)
    {
        SimpleCrashViewController *simpleCrashVC = [[SimpleCrashViewController alloc] init];
        simpleCrashVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:simpleCrashVC animated:YES];
        [simpleCrashVC release];
    }
    else if (indexPath.row == 6)
    {
        ThirdPartyLibraryViewController *thirdVC = [[ThirdPartyLibraryViewController alloc] init];
        thirdVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:thirdVC animated:YES];
        [thirdVC release];
    }
    else
    {
        OtherViewController *otherVC = [[OtherViewController alloc] init];
        otherVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:otherVC animated:YES];
        [otherVC release];
    }


}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

// Editing

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//
//// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
//- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
//{
//
//}
//
//// Indentation
//// return 'depth' of row for hierarchies
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}


@end
