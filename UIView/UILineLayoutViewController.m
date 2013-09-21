//
//  UILineLayoutViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-2-28.
//
//

#import "UILineLayoutViewController.h"
#import "XSLineLayout.h"
#import "SimpleCollectionCell.h"
#import "XSTestUtils.h"

NSString *cellIndentifier = @"MY_Line_CELL";

@interface UILineLayoutViewController ()

@end

@implementation UILineLayoutViewController

#pragma mark -
#pragma mark Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:@"LineLayout"];
    
    //增加一个按钮 切换水平和垂直模式
    
    //1.初始化Layout
    XSLineLayout *aLineLayout = [[XSLineLayout alloc] init];
    
    //初始化collectionView
    UICollectionView *aCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - 44) collectionViewLayout:aLineLayout];
    aCollectionView.delegate = self;
    aCollectionView.dataSource = self;
    aCollectionView.backgroundColor = [UIColor underPageBackgroundColor];
    [aLineLayout release];
    
    [aCollectionView registerClass:[SimpleCollectionCell class] forCellWithReuseIdentifier:cellIndentifier];
    [self.view addSubview:aCollectionView];
    [aCollectionView release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SimpleCollectionCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.item];
    return cell;
}

#pragma mark -
#pragma mark 设备方向
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

@end
