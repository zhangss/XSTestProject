    //
//  UIImageViewInfoViewController.m
//  XSTestProject
//
//  Created by 张永亮 on 12-11-26.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UIImageViewInfoViewController.h"
#import "UIBigImageView.h"
#import "BigImageViewController.h"

#define kImageOriginTag 1000
#define kImageOriginBtnTag 101

@implementation UIImageViewInfoViewController

#pragma mark -
#pragma mark Init
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
//- (id)init
//{
//    self = [super init];
//    if (self)
//    {
//        
//    }
//    return self;
//}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
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


- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark View
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    imageArr = [[NSMutableArray array] retain];
    UIImage *image1 = [UIImage imageNamed:@"sampleIamge1.jpeg"];
    UIImage *image2 = [UIImage imageNamed:@"sampleIamge.jpeg"];
    UIImage *image3 = [UIImage imageNamed:@"sampleIamge2.jpg"];
    UIImage *image4 = [UIImage imageNamed:@"sampleIamge3.jpeg"];
    UIImage *image5 = [UIImage imageNamed:@"sampleIamge4.jpeg"];
    
    [imageArr addObject:image1];
    [imageArr addObject:image2];
    [imageArr addObject:image3];
    [imageArr addObject:image4];
    [imageArr addObject:image5];
    
    CGFloat width = 300.0 / [imageArr count]; 
    CGFloat mix = 20.0 / [imageArr count];
    
    for (int i = 0; i < [imageArr count]; i++)
    {
        //0 创建展示小图View
        UIImage *sampleIamge = [imageArr objectAtIndex:i];
        
        UIImageView *bigImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        bigImageView.image = sampleIamge;
        bigImageView.tag = kImageOriginTag + i;
        //ImageView必须按照图片的比例显示图片 否则影响动画效果
        CGFloat height = width * sampleIamge.size.height / sampleIamge.size.width;
        bigImageView.frame = CGRectMake(width * i + mix * i , 300, width, height);
        
        [self.view addSubview:bigImageView];
        [bigImageView release];
        
        //ImageView上添加一个Btn 用于起始动画 可以用UIGesture实现
        UIButton *bigImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bigImageBtn.frame = bigImageView.frame;
        bigImageBtn.center = bigImageView.center;
        bigImageBtn.tag = kImageOriginBtnTag + i;
        [bigImageBtn addTarget:self action:@selector(imageViewTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bigImageBtn];
    }
}


- (void)imageViewTap:(id)sender
{
    UIButton *abtn = (UIButton *)sender;
    NSInteger btnTag = abtn.tag;
    NSLog(@"%d",btnTag - kImageOriginBtnTag);
    UIImageView *bigImageView = (UIImageView *)[self.view viewWithTag:kImageOriginTag + (btnTag - kImageOriginBtnTag)];
    CGRect rect = [bigImageView.superview convertRect:bigImageView.frame toView:[UIApplication sharedApplication].keyWindow];
    
#if SHOW_BINIMAGE_ANIMATION_VIEW
    UIBigImageView *bigImageV = [[[UIBigImageView alloc] initWithFrame:rect] autorelease];
    [bigImageV setImageArr:imageArr andSelIndex:(btnTag - kImageOriginBtnTag)];
    bigImageV.aViewController = self;
    [bigImageV beginAnimation];
#else
    BigImageViewController *bigImageV = [[[BigImageViewController alloc] initWithFrame:rect andVC:self andImageArr:imageArr andIndex:(btnTag - kImageOriginBtnTag)] autorelease
                                         ];
    [self presentModalViewController:bigImageV animated:NO];    
#endif
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    
//    UIImageView *bigImageView = (UIImageView *)[self.view viewWithTag:kImageOriginTag];
//    
//    [UIView animateWithDuration:3
//                          delay:0.0
//                        options:UIViewAnimationOptionTransitionNone
//                     animations:^{
//                         UIDevice *myDevice = [UIDevice currentDevice];  
//                         UIDeviceOrientation deviceOrientation = [myDevice orientation];
//                         if (deviceOrientation == UIDeviceOrientationPortrait)
//                         {
//                             NSLog(@"UIDeviceOrientationPortrait");
//                             bigImageView.transform = CGAffineTransformMakeRotation(0);
//                         }
//                         else if (deviceOrientation == UIDeviceOrientationPortraitUpsideDown)
//                         {
//                             NSLog(@"UIDeviceOrientationPortraitUpsideDown");
//                             bigImageView.transform = CGAffineTransformMakeRotation(M_PI);
//                         }
//                         else if (deviceOrientation == UIDeviceOrientationLandscapeRight)
//                         {
//                             NSLog(@"UIDeviceOrientationLandscapeRight");
//                             bigImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
//                         }
//                         else if (deviceOrientation == UIDeviceOrientationLandscapeLeft)
//                         {
//                             NSLog(@"UIDeviceOrientationLandscapeLeft");
//                             bigImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
//                         }
//                     } completion:^(BOOL finished){
//
//                     }];
//    [[UIApplication sharedApplication] setStatusBarOrientation:interfaceOrientation animated:YES];
//    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft
//        || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
//    {
//        [self.view setFrame:CGRectMake(0, 0, 480, 320)];
//    }
//    else if (interfaceOrientation == UIInterfaceOrientationPortrait || 
//             interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
//    {
//        [self.view setFrame:CGRectMake(0, 0, 320, 480)];
//    } 
    return (interfaceOrientation == UIInterfaceOrientationPortrait 
//            || 
//            interfaceOrientation == UIInterfaceOrientationLandscapeRight || 
//            interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
//            interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown
            );
}


#pragma mark -
#pragma mark UIBigImageViewDelegate
- (void)disMissBigImageView
{
    NSLog(@"大图消失");
}

@end
