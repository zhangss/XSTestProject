//
//  AssetsLibraryViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-7-3.
//
//

#import "AssetsLibraryViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface AssetsLibraryViewController ()

@end

@implementation AssetsLibraryViewController

#pragma mark -
#pragma mark Init
- (id)init
{
    self = [super init];
    if (self)
    {
        
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
    
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"AssetsLibrary", @"")];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView release];
    
    //初始化或者清空数组 防止ViewDidUnload造成泄漏
    if (!albumGroup)
    {
        albumGroup = [[NSMutableArray alloc] init];
    }
    else
    {
        [albumGroup removeAllObjects];
    }
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    ALAssetsLibraryGroupsEnumerationResultsBlock groupListBlick = ^(ALAssetsGroup *group,BOOL *stop)
    {
        if (group)
        {
            [albumGroup addObject:group];
        }
        else
        {
            //TableView Reload
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error)
    {
        NSString *errorMessage = nil;
        switch ([error code])
        {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
            {
                errorMessage = @"The user has declined access to it.";
                break;
            }
            default:
            {
                errorMessage = @"Reason Unknown";
                break;
            }
        }
        if (errorMessage)
        {
            NSLog(@"Assets Data Access Failure:%@",errorMessage);
        }
    };

    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces;
    [assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:groupListBlick failureBlock:failureBlock];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return albumGroup.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    ALAssetsGroup *groupForCell = [albumGroup objectAtIndex:indexPath.row];
    CGImageRef posterImageRef = [groupForCell posterImage];
    UIImage *posterImage = [UIImage imageWithCGImage:posterImageRef];
    cell.imageView.image = posterImage;
    cell.textLabel.text = [groupForCell valueForProperty:ALAssetsGroupPropertyName];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma makr OtherMethods

@end
