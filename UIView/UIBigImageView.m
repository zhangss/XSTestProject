    //
//  UIBigImageView.m
//  XSTestProject
//
//  Created by 张永亮 on 12-11-26.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UIBigImageView.h"

#define kImageViewTag 100
#define kScrollViewTag 1000
#define kCacheImageCount 3

@implementation UIBigImageView
@synthesize delegate;
@synthesize image;
@synthesize aViewController;
@synthesize isDrag;

#pragma mark -
#pragma mark Init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //记录原来的位置
        originRect = frame;
        imageViewArr = [[NSMutableArray alloc] init];
        self.frame = CGRectMake(0, 0, 320, 480);
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor blackColor];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
        [self addSubview:scrollView];
        
        toolBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height - 50, frame.size.width, 50)];
        toolBar.alpha = 0.0;
        toolBar.image = [UIImage imageNamed:@"ico_showbigphoto_toolbar"];
        toolBar.userInteractionEnabled = YES;
        toolBar.backgroundColor = [UIColor clearColor];
        
        backButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        //backButton.hidden = YES;
        [backButton setImage:[UIImage imageNamed:@"ico_showbigphoto_back"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"ico_showbigphoto_back_sel"] forState:UIControlStateHighlighted];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(10, 9, 10, 9);
        [backButton addTarget:self action:@selector(singleTap) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:backButton];
        
        saveButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        //saveButton.hidden = YES;
        saveButton.imageEdgeInsets = UIEdgeInsetsMake(10, 9, 10, 9);
        [saveButton setImage:[UIImage imageNamed:@"ico_showbigphoto_save"] forState:UIControlStateNormal];
        [saveButton setImage:[UIImage imageNamed:@"ico_showbigphoto_save_sel"] forState:UIControlStateHighlighted];
        [saveButton addTarget:self action:@selector(saveImageToLocal) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:saveButton];
        [self addSubview:toolBar];
#if SHOW_BINIMAGE_ANIMATION_VIEW
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];  
        [center addObserver:self selector:@selector(doRotate:) name:UIDeviceOrientationDidChangeNotification object:nil]; 
#else
#endif
    }
    return self;
}

- (void)dealloc 
{
    NSLog(@"Dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [scrollView release];
    [backButton release];
    [saveButton release];
    [toolBar release];
    [super dealloc];
}

NSInteger sortWithFrame(UIScrollView *v1,UIScrollView *v2,void *context)
{	
    if (v1.frame.origin.x < v2.frame.origin.x)
    {
        return NSOrderedAscending;
    }
    else if (v1.frame.origin.x == v2.frame.origin.x)
    {
        return NSOrderedSame;
    }
    else 
    {
        return NSOrderedDescending;
    }
}

#pragma mark -
#pragma mark dataSourceMethods
//序列的映射
- (NSInteger)imageViewindex:(NSInteger)index withPage:(NSInteger)page
{
    NSInteger imageViewIndex = 0;
    if ([imageArr count] <= 3)
    {
        imageViewIndex = index;
    }
    else
    {
        if (index == 0)
        {
            //第一个ImageView
            if (page == 0)
            {
                imageViewIndex = page;
            }
            else if (page == [imageArr count] - 1)
            {
                imageViewIndex = page - 2;
            }
            else
            {
                imageViewIndex = page - 1;
            }
        }
        else if (index == 1)
        {
            if (curPage == 0)
            {
                imageViewIndex = page + 1;
            }
            else if (page == [imageArr count] - 1)
            {
                imageViewIndex = page - 1;
            }
            else 
            {
                imageViewIndex = page;
            }
        }
        else
        {
            if (page == 0)
            {
                imageViewIndex = page + 2;
            }
            else if (page == [imageArr count] - 1)
            {
                imageViewIndex = page;
            }
            else 
            {
                imageViewIndex = page + 1;
            }
        }
    }
    return imageViewIndex;
}

- (void)creatImageView:(NSInteger)imageViewCount
{
    for (int i = 0; i < imageViewCount; i++)
    {
        UIScrollView *photoScrollView = nil;
        NSInteger curIndex = [self imageViewindex:i withPage:curPage];
        photoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(curIndex * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        photoScrollView.minimumZoomScale = 1.0;
        photoScrollView.maximumZoomScale = 2.0;
        photoScrollView.zoomScale = 1.0;
        photoScrollView.delegate = self;
        photoScrollView.tag = kScrollViewTag + i;
        photoScrollView.backgroundColor = [UIColor clearColor];
        photoScrollView.contentMode = UIViewContentModeCenter;
//        if (i == 0)
//        {
//            photoScrollView.backgroundColor = [UIColor redColor];
//        }
//        else if (i == 1)
//        {
//            photoScrollView.backgroundColor = [UIColor greenColor];
//        }
//        else 
//        {
//            photoScrollView.backgroundColor = [UIColor blueColor];
//        }

        UIImageViewForTouch *photoImageView = nil;
        photoImageView = [[UIImageViewForTouch alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        photoImageView.delegate = self;
        photoImageView.tag = kImageViewTag + i;
        photoImageView.backgroundColor = [UIColor clearColor];
        photoImageView.userInteractionEnabled = YES;
        [imageViewArr addObject:photoScrollView];
        
#if DOUBLE_CLICK
        
#else
        UITapGestureRecognizer *tapDoubleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGesture:)];
        tapDoubleGesture.numberOfTapsRequired = 2;
        tapDoubleGesture.delegate = self;
        [photoScrollView addGestureRecognizer:tapDoubleGesture];

        UITapGestureRecognizer *tapSingleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
        tapSingleGesture.numberOfTapsRequired = 1;
        tapSingleGesture.delegate = self;
        [tapSingleGesture requireGestureRecognizerToFail:tapDoubleGesture]; 
        [photoScrollView addGestureRecognizer:tapSingleGesture];
        [tapDoubleGesture release];
        [tapSingleGesture release]; 
#endif
        
        [photoScrollView addSubview:photoImageView];
        [scrollView addSubview:photoScrollView];
        [photoImageView release];
        [photoScrollView release];
    }
}

- (void)getCurrentImageVIndex
{
    if (curPage == 0)
    {
        curImageV = 0;
    }
    else if (curPage == [imageArr count] - 1)
    {
        curImageV = [imageViewArr count] - 1;
    }
    else 
    {
        curImageV = 1;
    }
}

- (void)setImageArr:(NSArray *)imageArray andSelIndex:(NSInteger)index
{
    //1.获取数据
    imageArr = [[NSArray arrayWithArray:imageArray] retain];
    curPage = index;     //滚动到的page
    [self getCurrentImageVIndex];
    
    //2.初始化ScrollViewFrame  滚动到选中的Page
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imageArr count], scrollView.frame.size.height);
    scrollView.contentOffset = CGPointMake(scrollView.frame.size.width * curPage, 0);
    
    //初始化第一个ImageView
    NSInteger imageViewCount = 0.0;
    if ([imageArr count] > kCacheImageCount)
    {
        imageViewCount = kCacheImageCount;
    }
    else
    {
        imageViewCount = [imageArr count];
    }
    [self creatImageView:imageViewCount];
}

#pragma mark -
#pragma mark Get View
- (UIScrollView *)getCurrentScrollView:(NSInteger)viewIndex
{
    UIScrollView *scrollV = nil;
    if (viewIndex >= 0 && viewIndex <= [imageViewArr count] - 1)
    {
        scrollV = [imageViewArr objectAtIndex:viewIndex];
    }
    return scrollV;
}

- (UIImageViewForTouch *)getCurrentImageView:(NSInteger)viewIndex
{
    UIImageViewForTouch *imageV = nil;
    if (viewIndex >= 0 && viewIndex <= [imageViewArr count] - 1)
    {
        UIScrollView *scrollV = [self getCurrentScrollView:viewIndex];
        if (scrollV)
        {
            for (UIView *aView in scrollV.subviews)
            {
                if ([aView isKindOfClass:[UIImageViewForTouch class]])
                {
                    imageV = (UIImageViewForTouch *)aView;
                }
            }
        }
        
    }
    return imageV;
}

#pragma mark -
#pragma mark 动画初试状态
- (CGSize)getImageViewSize:(CGSize)imageSize
{
    CGSize resaultSize = CGSizeZero;
    CGFloat percentage = imageSize.width / imageSize.height;
    //    if (imageSize.width < self.frame.size.width && imageSize.height < self.frame.size.height)
    //    {
    //        //小图 不用压缩
    //        resaultSize = imageSize;
    //    }
    //    else if (imageSize.width < self.frame.size.width)
    //    {
    //        resaultSize.width = imageSize.width;
    //        resaultSize.height = imageSize.height * percentage;
    //    }
    //    else if (imageSize.height < self.frame.size.height)
    //    {
    //        resaultSize.width = imageSize.width / percentage;
    //        resaultSize.height = imageSize.height;
    //    }
    //    else
    //    {
    //        //大图
    //        if (percentage >= 1)
    //        {
    //            resaultSize.width = self.frame.size.width;
    //            resaultSize.height = self.frame.size.width / percentage;
    //        }
    //        else
    //        {
    //            resaultSize.height = self.frame.size.height;
    //            resaultSize.width = self.frame.size.height * percentage;
    //        }
    //    }
    
    //大图
//    NSLog(@"Self ==%@",NSStringFromCGRect(self.frame));
    if (scrollView.frame.size.height > scrollView.frame.size.width)
    {
        if (scrollView.frame.size.height * percentage > scrollView.frame.size.width)
        {
            resaultSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.width / percentage);
        }
        else
        {
            resaultSize = CGSizeMake(scrollView.frame.size.height * percentage, scrollView.frame.size.height);
        }
    }
    else 
    {
        if (scrollView.frame.size.width / percentage > scrollView.frame.size.height)
        {
            resaultSize = CGSizeMake(scrollView.frame.size.height * percentage, scrollView.frame.size.height);
        }
        else
        {
            resaultSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.width / percentage);
        }
    }
    return resaultSize;
}

- (void)setCurImageViewFrame:(CGRect)frame
{
    //设置当前ScrollView的Frame
    for (int i = 0; i < [imageViewArr count]; i ++)
    {        
        //赋frame
        UIScrollView *scrollV = [self getCurrentScrollView:i];
        if (scrollV)
        {
            CGRect scrollVRect = scrollV.frame;
            scrollVRect.size = frame.size;
            scrollV.frame = scrollVRect;
        }
        
        UIImageViewForTouch *imageV = [self getCurrentImageView:i];
        if (imageV) 
        {
            imageV.frame = originRect;
        }
    }
}

- (void)setSelfFrame:(CGRect)frame
{
    //1.为自己赋frame
    self.frame = frame;
    
    //scrollView.frame = frame;
    //动画能够更加平滑
    scrollView.frame = CGRectMake(0, 44, self.frame.size.width, self.frame.size.height - 44);
    
    //2.赋ImageView的大小 不能赋Image
    [self setCurImageViewFrame:frame];
    
    //3.处理工具栏
    toolBar.frame = CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50);
    backButton.frame = CGRectMake(30, 5, 40, 40);
    saveButton.frame = CGRectMake(self.frame.size.width - 30 - 40, 5, 40, 40);
}

- (void)resetImageViewFrame:(CGRect)frame
{
    CGRect imageViewRect = frame;
    for (int i = 0; i < [imageViewArr count]; i ++)
    {
        UIImageViewForTouch *imageV = [self getCurrentImageView:i];
        if (imageV) 
        {
            imageV.frame = imageViewRect;
        }
    }
}

#pragma mark -
#pragma mark SetImage
- (void)setCurImage
{
    //获取图片
    for (int i = 0; i < [imageViewArr count]; i ++)
    {
        NSInteger imageVIndex = [self imageViewindex:i withPage:curPage];
        UIImage *aImage = [imageArr objectAtIndex:imageVIndex];
        CGRect imageViewRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        imageViewRect.size = [self getImageViewSize:aImage.size];
        imageViewRect.origin.y = (self.frame.size.height - imageViewRect.size.height)/2;
        imageViewRect.origin.x = (self.frame.size.width - imageViewRect.size.width)/2;
        UIImageViewForTouch *imageV = [self getCurrentImageView:i];
        if (imageV) 
        {
            imageV.image = aImage;
            imageV.frame = imageViewRect;
        }
    }
    scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

#pragma mark -
#pragma mark BeginAnimation
- (void)beginAnimation
{
    //先把背景View处理好
    [self setSelfFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    //重要 防止白条
    [[UIApplication sharedApplication].keyWindow setBackgroundColor:[UIColor blackColor]];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.3 
                          delay:0 
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //3.赋Image
                         [self setCurImage];
                         toolBar.alpha = 1.0;
                     } completion:^(BOOL finished){
                         aViewController.navigationController.navigationBar.alpha = 0.0;
                     }];
    //[aViewController.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade]; 
}

- (void)endAnimation
{
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self resetImageViewFrame:originRect];
                         toolBar.alpha = 0.0;
                     } completion:^(BOOL finished){
#if SHOW_BINIMAGE_ANIMATION_VIEW
                         [self removeFromSuperview];
#else
                         [aViewController dismissModalViewControllerAnimated:NO];
#endif
                         aViewController.navigationController.navigationBar.alpha = 1.0;
                     }];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    //[aViewController.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
/**************BEGIN*************
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    if (aScrollView == scrollView)
    {
        isDrag = YES;
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView willDecelerate:(BOOL)decelerate
{
	if(!decelerate && aScrollView == scrollView)
	{
		[self scrollingHasEnded];
	}
}

//此方法为滚动结束后调用 可能直接跳页
- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
    if (aScrollView == scrollView)
    {
        [self scrollingHasEnded];
    }
}

- (void)scrollingHasEnded
{    
    CGFloat pageWidth = scrollView.frame.size.width;
    CGFloat pageHeight = scrollView.frame.size.height;
    NSInteger page = floor(scrollView.contentOffset.x / pageWidth);
    //1.检查向左滑动 向右滑动
    BOOL isLeft = NO;
    if (curPage > page)
    {
        isLeft = YES;
    }
    else {
        isLeft = NO;
    }
    
    //2.获取旧的View 重新赋值
    if ([imageArr count] > 3)
    {
        if (curPage != page)
        {
            UIScrollView *scrollV = (UIScrollView *)[imageViewArr objectAtIndex:curImageV];
            [scrollV setZoomScale:scrollV.minimumZoomScale animated:YES];
            NSLog(@"page:%d --- > %d",curPage,page);
            if (isLeft)
            {
                if (curPage == 1 || curPage == [imageArr count] - 1)
                {
                    //无需替换
                    NSLog(@"无需替换ImageV Left");
                }
                else
                {
                    NSLog(@"替换ImageV Left");
                    NSInteger targetIndex = 0;
                    targetIndex = [self imageViewindex:2 withPage:page + 1] - 3;
                    
                    UIScrollView *scrollV = [imageViewArr lastObject];
                    CGRect scrollVFrame = scrollV.frame;
                    scrollVFrame.origin.x = pageWidth * targetIndex;
                    scrollV.frame = scrollVFrame;
                    UIImageViewForTouch *imageV = nil;
                    for (UIView *aView in scrollV.subviews)
                    {
                        if ([aView isKindOfClass:[UIImageViewForTouch class]])
                        {
                            imageV = (UIImageViewForTouch *)aView;
                        }
                    }
                    if (imageV)
                    {
                        CGRect imageViewRect = imageV.frame;
                        UIImage *aImage = [imageArr objectAtIndex:targetIndex];
                        imageViewRect.size = [self getImageViewSize:aImage.size];
                        imageViewRect.origin.y = (pageHeight - imageViewRect.size.height)/2;
                        imageViewRect.origin.x = (pageWidth - imageViewRect.size.width)/2;
                        imageV.frame = imageViewRect;
                        imageV.image = aImage;
                    }
                    
                    [imageViewArr sortUsingFunction:sortWithFrame context:NULL];
                    NSLog(@"%@",imageViewArr);
                }
            }
            else
            {
                if (curPage == 0 || curPage == [imageArr count] - 2)
                {
                    //无需替换
                    NSLog(@"无需替换ImageV Right");
                }
                else
                {
                    NSLog(@"替换ImageV Right");
                    NSInteger targetIndex = 0;
                    targetIndex = [self imageViewindex:0 withPage:page - 1] + 3;
                    
                    UIScrollView *scrollV = [imageViewArr objectAtIndex:0];
                    CGRect scrollVFrame = scrollV.frame;
                    scrollVFrame.origin.x = pageWidth * targetIndex;
                    scrollV.frame = scrollVFrame;
                    UIImageViewForTouch *imageV = nil;
                    for (UIView *aView in scrollV.subviews)
                    {
                        if ([aView isKindOfClass:[UIImageViewForTouch class]])
                        {
                            imageV = (UIImageViewForTouch *)aView;
                        }
                    }
                    if (imageV)
                    {
                        CGRect imageViewRect = imageV.frame;
                        UIImage *aImage = [imageArr objectAtIndex:targetIndex];
                        imageViewRect.size = [self getImageViewSize:aImage.size];
                        imageViewRect.origin.y = (pageHeight - imageViewRect.size.height)/2;
                        imageViewRect.origin.x = (pageWidth - imageViewRect.size.width)/2;
                        imageV.frame = imageViewRect;
                        imageV.image = aImage;
                    }
                    
                    [imageViewArr sortUsingFunction:sortWithFrame context:NULL];
                    NSLog(@"%@",imageViewArr);
                }
            }
        }
    }
    curPage = page;
    [self getCurrentImageVIndex];
}
****************End***************
*/

- (void)scrollViewWillBeginDragging:(UIScrollView *)aScrollView
{
    if (aScrollView == scrollView)
    {
        NSLog(@"scrollViewWillBeginDragging");
        isDrag = YES;
    }
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"scrollViewDidEndDragging");
//    isDrag = NO;
//}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView 
{
    if (!isDrag)
    {
        return;
    }
    if (aScrollView == scrollView)
    {
        CGFloat pageWidth = aScrollView.frame.size.width;
        CGFloat pageHeight = aScrollView.frame.size.height;
        NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        //1.检查向左滑动 向右滑动
        BOOL isLeft = NO;
        if (scrolloffSet >= scrollView.contentOffset.x)
        {
            isLeft = YES;
        }
        else {
            isLeft = NO;
        }

        //2.获取旧的View 重新赋值
        if ([imageArr count] > 3)
        {
            if (curPage != page)
            {
                UIScrollView *scrollV = (UIScrollView *)[imageViewArr objectAtIndex:curImageV];
                [scrollV setZoomScale:scrollV.minimumZoomScale animated:YES];
                NSLog(@"page:%d --- > %d",curPage,page);
                if (isLeft)
                {
                    if (curPage == 1 || curPage == [imageArr count] - 1)
                    {
                        //无需替换
                        NSLog(@"无需替换ImageV Left");
                    }
                    else
                    {
                        NSLog(@"替换ImageV Left");
                        NSInteger targetIndex = 0;
                        targetIndex = [self imageViewindex:2 withPage:page + 1] - 3;
                        
                        UIScrollView *scrollV = [imageViewArr lastObject];
                        CGRect scrollVFrame = scrollV.frame;
                        scrollVFrame.origin.x = pageWidth * targetIndex;
                        scrollV.frame = scrollVFrame;
                        UIImageViewForTouch *imageV = nil;
                        for (UIView *aView in scrollV.subviews)
                        {
                            if ([aView isKindOfClass:[UIImageViewForTouch class]])
                            {
                                imageV = (UIImageViewForTouch *)aView;
                            }
                        }
                        if (imageV)
                        {
                            CGRect imageViewRect = imageV.frame;
                            UIImage *aImage = [imageArr objectAtIndex:targetIndex];
                            imageViewRect.size = [self getImageViewSize:aImage.size];
                            imageViewRect.origin.y = (pageHeight - imageViewRect.size.height)/2;
                            imageViewRect.origin.x = (pageWidth - imageViewRect.size.width)/2;
                            imageV.frame = imageViewRect;
                            imageV.image = aImage;
                        }
                        
                        [imageViewArr sortUsingFunction:sortWithFrame context:NULL];
                    }
                }
                else
                {
                    if (curPage == 0 || curPage == [imageArr count] - 2)
                    {
                        //无需替换
                        NSLog(@"无需替换ImageV Right");
                    }
                    else
                    {
                        NSLog(@"替换ImageV Right");
                        NSInteger targetIndex = 0;
                        targetIndex = [self imageViewindex:0 withPage:page - 1] + 3;
                        
                        UIScrollView *scrollV = [imageViewArr objectAtIndex:0];
                        CGRect scrollVFrame = scrollV.frame;
                        scrollVFrame.origin.x = pageWidth * targetIndex;
                        scrollV.frame = scrollVFrame;
                        UIImageViewForTouch *imageV = nil;
                        for (UIView *aView in scrollV.subviews)
                        {
                            if ([aView isKindOfClass:[UIImageViewForTouch class]])
                            {
                                imageV = (UIImageViewForTouch *)aView;
                            }
                        }
                        if (imageV)
                        {
                            CGRect imageViewRect = imageV.frame;
                            UIImage *aImage = [imageArr objectAtIndex:targetIndex];
                            imageViewRect.size = [self getImageViewSize:aImage.size];
                            imageViewRect.origin.y = (pageHeight - imageViewRect.size.height)/2;
                            imageViewRect.origin.x = (pageWidth - imageViewRect.size.width)/2;
                            imageV.frame = imageViewRect;
                            imageV.image = aImage;
                        }
                        
                        [imageViewArr sortUsingFunction:sortWithFrame context:NULL];
                    }
                }
            }
        }
        
        curPage = page;
        [self getCurrentImageVIndex];
        scrolloffSet = scrollView.contentOffset.x;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)aScrollView
{
    UIImageViewForTouch *imageV = nil;
    for (UIView *aView in aScrollView.subviews)
    {
        if ([aView isKindOfClass:[UIImageViewForTouch class]])
        {
            imageV = (UIImageViewForTouch *)aView;
        }
    }
    return imageV;
}

#if ZOOM_STYLE
//放大位置不行 点击哪里 放大哪里
- (void)scrollViewDidZoom:(UIScrollView *)aScrollView
{    
    UIImageViewForTouch *photoImageView = nil;
    for (UIView *aView in aScrollView.subviews)
    {
        if ([aView isKindOfClass:[UIImageViewForTouch class]])
        {
            photoImageView = (UIImageViewForTouch *)aView;
        }
    }
    
    CGFloat scale = photoImageView.image.size.width/photoImageView.image.size.height;
    if (460*scale>320)//初始设置宽为320
    {
        if (photoImageView.frame.size.height >= 460)
        {
            CGFloat distance = (460 - 320/scale) / 2.0;
            aScrollView.contentInset = UIEdgeInsetsMake(- distance, 0, distance, 0);
        }
        else
        {
            CGFloat distance = (460 - 320/scale) / 2.0 - (460 - photoImageView.frame.size.height) / 2.0;
            aScrollView.contentInset = UIEdgeInsetsMake(- distance, 0, distance, 0);
        }
    }
    else//初始设置高为460
    {
        if (photoImageView.frame.size.width >= 320)
        {
            CGFloat distance = (320 - 460*scale) / 2.0;
            aScrollView.contentInset = UIEdgeInsetsMake(0, -distance, 0, distance);
        }
        else
        {
            CGFloat distance = (320 - 460*scale) / 2.0 - (320 - photoImageView.frame.size.width) / 2.0;
            aScrollView.contentInset = UIEdgeInsetsMake(0, -distance, 0, distance);
        }
    }
}
#else

#endif

#pragma mark -
#pragma mark Super Delegate 点击事件
- (void)singleTap
{
    if (!isZooming)
    {
        isZooming = NO;
        [self endAnimation];
        if (delegate && [delegate respondsToSelector:@selector(disMissBigImageView)])
        {
            [delegate disMissBigImageView];
        }
    }

}

#if ZOOM_STYLE
- (void)doubleTap:(UIView *)aView;
{
    UIScrollView *photoScrollView = (UIScrollView *)aView.superview;
    if (photoScrollView.zoomScale > photoScrollView.minimumZoomScale)
    {
        isZooming = NO;
        [photoScrollView setZoomScale:photoScrollView.minimumZoomScale animated:YES];
        [UIView animateWithDuration:0.3
                              delay:0.2
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             toolBar.alpha = 1.0;
                         } completion:^(BOOL finished){
                         }];
    }
    else
    {
        isZooming = YES;
        [photoScrollView setZoomScale:2.0f animated:YES];
        [UIView animateWithDuration:0.3
                              delay:0.2
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             toolBar.alpha = 0.0;
                         } completion:^(BOOL finished){
                         }];
    }
}
#else
- (void)doubleTap:(NSArray *)arr;
{
    UIView *aView = [arr objectAtIndex:1];
    
    UITouch *touch = nil;
    NSString *touchString = nil;
    if ([[arr objectAtIndex:0] isKindOfClass:[UITouch class]])
    {
        touch = [arr objectAtIndex:0];
    }
    else if ([[arr objectAtIndex:0] isKindOfClass:[NSString class]])
    {
        touchString = [arr objectAtIndex:0];
    }
    UIScrollView *photoScrollView = (UIScrollView *)aView.superview;
    if (photoScrollView.zoomScale > photoScrollView.minimumZoomScale)
    {
        isZooming = NO;
        [photoScrollView setZoomScale:photoScrollView.minimumZoomScale animated:YES];
        [UIView animateWithDuration:0.3
                              delay:0.2
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             toolBar.alpha = 1.0;
                         } completion:^(BOOL finished){
                         }];
    }
    else
    {
        isZooming = YES;
        
        // define a rect to zoom to.
        CGPoint touchCenter = CGPointZero;
        if (touch)
        {
            touchCenter = [touch locationInView:self];
        }
        else if (touchString)
        {
            touchCenter = CGPointFromString(touchString);
        }

        CGSize zoomRectSize = CGSizeMake(photoScrollView.frame.size.width / photoScrollView.maximumZoomScale, photoScrollView.frame.size.height / photoScrollView.maximumZoomScale );
        CGRect zoomRect = CGRectMake( touchCenter.x - zoomRectSize.width * .5, touchCenter.y - zoomRectSize.height * .5, zoomRectSize.width, zoomRectSize.height );
        
        // correct too far left
        if( zoomRect.origin.x < 0 )
            zoomRect = CGRectMake(0, zoomRect.origin.y, zoomRect.size.width, zoomRect.size.height );
        
        // correct too far up
        if( zoomRect.origin.y < 0 )
            zoomRect = CGRectMake(zoomRect.origin.x, 0, zoomRect.size.width, zoomRect.size.height );
        
        // correct too far right
        if( zoomRect.origin.x + zoomRect.size.width > photoScrollView.frame.size.width )
            zoomRect = CGRectMake(photoScrollView.frame.size.width - zoomRect.size.width, zoomRect.origin.y, zoomRect.size.width, zoomRect.size.height );
        
        // correct too far down
        if( zoomRect.origin.y + zoomRect.size.height > photoScrollView.frame.size.height )
            zoomRect = CGRectMake( zoomRect.origin.x, photoScrollView.frame.size.height - zoomRect.size.height, zoomRect.size.width, zoomRect.size.height );
        
        // zoom to it.
        [photoScrollView zoomToRect:zoomRect animated:YES];
//        [photoScrollView setZoomScale:2.0f animated:YES]
//        UIImageViewForTouch *photoImageView = nil;
//        for (UIView *aView in photoScrollView.subviews)
//        {
//            if ([aView isKindOfClass:[UIImageViewForTouch class]])
//            {
//                photoImageView = (UIImageViewForTouch *)aView;
//            }
//        }
//        photoImageView.center = photoImageView.center;
        
        [UIView animateWithDuration:0.3
                              delay:0.2
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             toolBar.alpha = 0.0;
                         } completion:^(BOOL finished){
                         }];
    }
}
#endif

#pragma mark -
#pragma mark UIImageViewForTouchDelegate
/*
 !!!:响应双击事件原理:1
 记录一个时间 在该时间内的点击点击次数为单击双击判断依据
 改时间内如果发生第二次点击 则为双击 取消单击响应
 
 2.手势
 */
#if DOUBLE_CLICK
- (void)touches:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSTimeInterval delaytime = 0.4;//自己根据需要调整
    UITouch *touch = [[event allTouches] anyObject];
    UIImageViewForTouch *view = (UIImageViewForTouch *)touch.view;
    switch (touch.tapCount)
    {
        case 1:
            //[self performSelector:@selector(singleTap) withObject:nil afterDelay:delaytime];
            break;
        case 2:
        {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTap) object:nil];
#if ZOOM_STYLE
            [self performSelector:@selector(doubleTap:) withObject:view afterDelay:0];
#else
            NSArray *arr = [NSArray arrayWithObjects:touch,view,nil];
            [self performSelector:@selector(doubleTap:) withObject:arr afterDelay:0];
#endif
        }
            break;
        default:
            break;
    }
}
#else

#pragma mark -
#pragma mark UIGestureRecognizer Methods

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    NSLog(@"gestureRecognizerShouldBegin:\n %@",gestureRecognizer);
//    return YES;
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    NSLog(@"gestureRecognizer:\n %@ and: %@",gestureRecognizer,otherGestureRecognizer);
//    return YES;
//}

- (void)doubleTapGesture:(UIGestureRecognizer *)gesture
{
    UIView *scrollV = gesture.view;
    CGPoint touchPoint = [gesture locationInView:self];
    
    UIImageViewForTouch *photoImageView = nil;
    for (UIView *aView in scrollV.subviews)
    {
        if ([aView isKindOfClass:[UIImageViewForTouch class]])
        {
            photoImageView = (UIImageViewForTouch *)aView;
        }
    }
    
    NSString *touchCenter = NSStringFromCGPoint(touchPoint);
#if ZOOM_STYLE
    [self performSelector:@selector(doubleTap:) withObject:photoImageView afterDelay:0];
#else
    NSArray *arr = [NSArray arrayWithObjects:touchCenter,photoImageView,nil];
    [self performSelector:@selector(doubleTap:) withObject:arr afterDelay:0];
#endif
}


#endif

#pragma mark -
#pragma mark Save photo
- (void)saveImageToLocal
{
    NSLog(@"Save");
    UIImage *curImage = [imageArr objectAtIndex:curPage];
    UIImageWriteToSavedPhotosAlbum(curImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{    
    if (error == nil)
    {
        NSLog(@"Save Image Success ");
        //[[BusinessManager sharedManager].snsManager chageUpdateMBMode:NSLocalizedString(@"Success",nil)];
    }
    else
    {
        NSLog(@"Save Image Error %@",error);
        //[[BusinessManager sharedManager].snsManager chageUpdateMBMode:NSLocalizedString(@"Save Failed",nil)];
    }
}

#pragma mark -
#pragma mark 旋转
- (void)resetSelfBounds:(CGRect)aBounds
{
#if SHOW_BINIMAGE_ANIMATION_VIEW
    self.bounds = aBounds;
//    CGRect selfRect = self.frame;
//    selfRect.size = aBounds.size;
//    self.frame = selfRect;
//    self.center = CGPointMake(aBounds.size.width/2, 240);
#else
    self.frame = aBounds;
#endif

    scrollView.frame = aBounds;
    scrollView.contentSize = CGSizeMake(aBounds.size.width * [imageArr count], aBounds.size.height);
    scrollView.contentOffset = CGPointMake(aBounds.size.width*curPage, 0);

    for (int i = 0; i < [imageViewArr count]; i++)
    {
        UIScrollView *scrollV = (UIScrollView *)[imageViewArr objectAtIndex:i];
        [scrollV setZoomScale:scrollV.minimumZoomScale animated:YES];
        CGRect scrollRect = scrollV.frame;
        scrollRect.origin.x = scrollV.frame.origin.x / scrollV.frame.size.width * aBounds.size.width;
        scrollRect.size = aBounds.size;
        scrollV.frame = scrollRect;
        scrollV.contentSize = CGSizeMake(aBounds.size.width, aBounds.size.height);
        
        UIImageViewForTouch *photoImageView = nil;
        for (UIView *aView in scrollV.subviews)
        {
            if ([aView isKindOfClass:[UIImageViewForTouch class]])
            {
                photoImageView = (UIImageViewForTouch *)aView;
            }
        }
        if (photoImageView) 
        {
            CGRect imageViewRect = photoImageView.frame;
            UIImage *aImage = photoImageView.image;
            imageViewRect.size = [self getImageViewSize:aImage.size];
            imageViewRect.origin.y = (aBounds.size.height - imageViewRect.size.height)/2;
            imageViewRect.origin.x = (aBounds.size.width - imageViewRect.size.width)/2;
            photoImageView.frame = imageViewRect;
        }
//        NSLog(@"%d:==%@ ==%@",scrollV.tag,NSStringFromCGRect(photoImageView.frame),NSStringFromCGRect(scrollV.frame));
    }
    toolBar.frame = CGRectMake(0, aBounds.size.height - 50, aBounds.size.width, 50);
    backButton.frame = CGRectMake(30, 5, 40, 40);
    saveButton.frame = CGRectMake(aBounds.size.width - 30 - 40, 5, 40, 40);
}

- (void)doRotate:(NSNotification *)noti
{
    UIDevice *myDevice = [UIDevice currentDevice];  
    UIDeviceOrientation deviceOrientation = [myDevice orientation];
    CGFloat angle = 0.0;
    if (deviceOrientation == UIDeviceOrientationPortrait)
    {
        NSLog(@"UIDeviceOrientationPortrait");
        [self resetSelfBounds:CGRectMake(0, 0, 320, 480)];
        angle = 0.0;
        self.transform = CGAffineTransformMakeRotation(angle);
    }
    else if (deviceOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        NSLog(@"UIDeviceOrientationPortraitUpsideDown");
        [self resetSelfBounds:CGRectMake(0, 0, 320, 480)];
        angle = M_PI;
        self.transform = CGAffineTransformMakeRotation(angle);
    }
    else if (deviceOrientation == UIDeviceOrientationLandscapeRight)
    {
        NSLog(@"UIDeviceOrientationLandscapeRight");
        [self resetSelfBounds:CGRectMake(0, 0, 480, 320)];
        angle = -M_PI/2;
        self.transform = CGAffineTransformMakeRotation(angle);
    }
    else if (deviceOrientation == UIDeviceOrientationLandscapeLeft)
    {
        NSLog(@"UIDeviceOrientationLandscapeLeft");
        [self resetSelfBounds:CGRectMake(0, 0, 480, 320)];
        angle = M_PI/2;
        self.transform = CGAffineTransformMakeRotation(angle);
    }
    
//    [CATransaction begin];
//    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
//    [CATransaction setValue:[NSNumber numberWithFloat:.3] forKey:kCATransactionAnimationDuration];
//    
//    CABasicAnimation *animation;
//    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    animation.fromValue = [NSNumber numberWithFloat:0.0];
//    animation.toValue = [NSNumber numberWithFloat:angle];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
//    animation.delegate = self;
//    [self.layer addAnimation:animation forKey:@"rotationAnimation"];
//    [scrollView.layer addAnimation:animation forKey:@"rotationAnimation"];
//    [CATransaction commit];
}

@end
