    //
//  PNGViewController.m
//  XSTestProject
//
//  Created by 张永亮 on 12-11-14.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PNGViewController.h"


@implementation PNGViewController

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
    
//    UIImage *pngImage   = [UIImage imageNamed:@""];
//    UIImage *pngImage2x = [UIImage imageNamed:@""];
//    UIImage *jpgImage   = [UIImage imageNamed:@""];
//    UIImage *jpgImage2x = [UIImage imageNamed:@""];
//    
//    //点击按钮 旋转展示
//    UIButton *buttonPNG = [UIButton buttonWithType:UIButtonTypeCustom];
//    [buttonPNG setBackgroundImage:pngImage forState:UIControlStateNormal];
    
    /*
     只有一个@2x.jpg
     1.bg_image、bg_image@2x 不带后缀 不会默认识别JPG图片
     2.bg_image.jpg bg_image@2x.jpg 文件名加后缀 可以适配设备
     3.bg_image.png bg_image@@2x.png 无法识别文件
     */
    
    /*
     只有一个.jpg
     1.bg_image、bg_image@2x 不带后缀 不会默认识别JPG图片
     2.bg_image.jpg  可以使用
     3.bg_image@2x.jpg 不可以识别
     4.bg_image.png bg_image@@2x.png 无法识别文件
     */
    
    /*
     只有一个@2x.png
     1.bg_image、bg_image@2x 会默认识别PNG图片
     2.bg_image.jpg bg_image@2x.jpg 不可以使用
     3.bg_image@2x.jpg 不可以识别
     4.bg_image.png bg_image@2x.png 可以识别识别文件 可以适配
     */
    
    /*
     只有一个.png
     1.bg_image 可以使用
     2.bg_image@2x 不可以使用
     2.bg_image.jpg bg_image@2x.jpg 不可以使用
     3.bg_image@2x.jpg 不可以识别
     4.bg_image.png bg_image@2x.png 可以识别识别文件 可以适配
     */
    
    /*
     只有一个.png 和 @2x.png
     1.3GS上 什么名称显示什么图片
     2.4以上 不管全称简称 都是用@2x图片
     3.读取图片时不会适配，显示图片时才会
     */

//      UIImage *image = [UIImage imageNamed:@"bg_image"];   //320*640   
//      UIImage *image = [UIImage imageNamed:@"bg_image@2x"];    //清晰度 一般
        UIImage *image = [UIImage imageNamed:@"bg_image.jpg"];
//      UIImage *image = [UIImage imageNamed:@"bg_image@2x.jpg"];
//    UIImage *image = [UIImage imageNamed:@"bg_image.png"];
//    UIImage *image = [UIImage imageNamed:@"bg_image@2x.png"];
    
    NSLog(@"Before:%f,%f",image.size.width,image.size.height);
    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(image,1.0)];
    UIImage *imageAfter = [UIImage imageWithData:imageData];
    
    NSLog(@"After:%f,%f",imageAfter.size.width,imageAfter.size.height);
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollview.backgroundColor = [UIColor clearColor];
        
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:scrollview.bounds];
    imageV.backgroundColor = [UIColor clearColor];
    imageV.frame = CGRectMake(0, 0, 320, 480);
    imageV.image = imageAfter;
    
    scrollview.contentSize = CGSizeMake(imageV.frame.size.width, imageV.frame.size.height);
    [scrollview addSubview:imageV];
    [self.view addSubview:scrollview];
    [imageV release];
    [scrollview release];
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


- (void)dealloc {
    [super dealloc];
}


@end
