//
//  UICircleLayoutViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-2-28.
//
//

#import "UICircleLayoutViewController.h"
#import "XSCircleLayout.h"
#import "CircleLayoutCell.h"

NSString *cellIndentifierCircle = @"MY_Circle_CELL";


@interface UICircleLayoutViewController ()

@end

@implementation UICircleLayoutViewController

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
    [aCollectionView release];
    [super dealloc];
}

#pragma mark -
#pragma mark Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:@"CircleLayout"];
    
    //增加一个按钮 切换水平和垂直模式
    
    //1.初始化Layout
    XSCircleLayout *aCircleLayout = [[XSCircleLayout alloc] init];
    
    //初始化collectionView
    /*
     //此处的ViewController是继承自UICollectionViewController，在此需要给ViewController传递一个Layout，此处传递了CircleLayout的一个对象实例。这是layout对象是与collection view相关的，layout控制了collection view如何显示它里面的cells和supplementary views。
     */
    aCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - 44) collectionViewLayout:aCircleLayout];
    aCollectionView.delegate = self;
    aCollectionView.dataSource = self;
    aCollectionView.backgroundColor = [UIColor underPageBackgroundColor];
    [aCircleLayout release];
    
    //cell默认个数 20
    cellCount = 10;
    
    //增加手势
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [aCollectionView addGestureRecognizer:tapRecognizer];
    [aCollectionView registerClass:[CircleLayoutCell class] forCellWithReuseIdentifier:cellIndentifierCircle];
//    [aCollectionView reloadData];
    aCollectionView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.view addSubview:aCollectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark Other Methods
- (void)handleTapGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        //获取点击处的cell的indexPath
        CGPoint initialPinchPoint = [sender locationInView:aCollectionView];
        NSIndexPath* tappedCellPath = [aCollectionView indexPathForItemAtPoint:initialPinchPoint];
        if (tappedCellPath!=nil)
        {
            //点击处没有cell
            cellCount = cellCount - 1;
            [aCollectionView performBatchUpdates:^{
                [aCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:tappedCellPath]];
                
            } completion:nil];
        }
        else
        {
            cellCount = cellCount + 1;
            [aCollectionView performBatchUpdates:^{
                [aCollectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
            } completion:nil];
        }
    }
}

#pragma mark -
#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CircleLayoutCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellIndentifierCircle forIndexPath:indexPath];
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
