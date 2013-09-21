//
//  ToogleCollectionViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-2-28.
//
//

#import "ToogleCollectionViewController.h"

#import "XSSmallLayout.h"
#import "XSLagerLayout.h"
#import "ToogleLayoutCell.h"
#import "XSTestUtils.h"

@interface ToogleCollectionViewController ()

@property (nonatomic,retain)XSSmallLayout *smallLayout;
@property (nonatomic,retain)XSLagerLayout *largerLayout;
@property (nonatomic,retain)NSArray *images;

@end

NSString *ItemIdentifier = @"ToogleIdentifier";

@implementation ToogleCollectionViewController

#pragma mark -
#pragma mark Init
- (id)init
{
    self = [super init];
    if (self)
    {
        self.smallLayout = [[[XSSmallLayout alloc] init] autorelease];
        self.largerLayout = [[[XSLagerLayout alloc] init] autorelease];
        
        self.collectionView = [[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.smallLayout] autorelease];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        self.collectionView.backgroundColor = [UIColor underPageBackgroundColor];
        
        [self.collectionView registerClass:[ToogleLayoutCell class] forCellWithReuseIdentifier:ItemIdentifier];
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Small", @"Large"]];
        segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        segmentedControl.selectedSegmentIndex = 0;
        [segmentedControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
        segmentedControl.frame = CGRectMake(0, 0, 100, 44);
        self.navigationItem.titleView = segmentedControl;
        [segmentedControl release];

    }
    return self;
}

- (void)dealloc
{
    self.smallLayout = nil;
    self.largerLayout = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Small", @"Large"]];
    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.frame = CGRectMake(0, 0, 100, 44);
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl release];
//    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:@"Toogle Layout"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark Methods
-(void)segmentedControlValueDidChange:(id)sender
{
    if (self.collectionView.collectionViewLayout == self.smallLayout)
    {
        [self.largerLayout invalidateLayout];
        [self.collectionView setCollectionViewLayout:self.largerLayout animated:YES];
    }
    else
    {
        [self.smallLayout invalidateLayout];
        [self.collectionView setCollectionViewLayout:self.smallLayout animated:YES];
    }
}

#pragma mark -
#pragma mark UICollectionView DataSource & Delegate methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ToogleLayoutCell *cell = (ToogleLayoutCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sampleIamge%d.jpeg", indexPath.item % 4 + 1]];
    
    return cell;
}

@end
