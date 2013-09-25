//
//  ImageSplitViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-4-12.
//
//

#import "ImageSplitViewController.h"

@interface ImageSplitViewController ()

@end

#define SAWTOOTH_COUNT 10
#define SAWTOOTH_WIDTH_FACTOR 20

@implementation ImageSplitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Split" style:UIBarButtonItemStylePlain target:self action:@selector(splitButtonClicked:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width - 10, self.view.frame.size.height - 10)];
    imageView.image = [UIImage imageNamed:@"sampleIamge2.jpg"];
    [self.view addSubview:imageView];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
    [imageView release];
//    [leftImageView release];
//    [rightImageView release];
}

#pragma mark -
#pragma mark BTN Methos
- (void)splitButtonClicked:(id)sender
{
    NSLog(@"Split");
    
    NSArray *array = [self splitImageIntoTwoParts:imageView.image];
    leftImageView = [[UIImageView alloc] initWithImage:[array objectAtIndex:0]];
    rightImageView = [[UIImageView alloc] initWithImage:[array objectAtIndex:1]];
    [self.view addSubview:leftImageView];
    [self.view addSubview:rightImageView];
    leftImageView.transform = CGAffineTransformIdentity;
    rightImageView.transform = CGAffineTransformIdentity;
    
    [UIView beginAnimations:@"split" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    leftImageView.transform = CGAffineTransformMakeTranslation(-160 ,0);
    rightImageView.transform = CGAffineTransformMakeTranslation(160 ,0);
    [UIView commitAnimations];
}

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"split"] && finished)
    {
        [leftImageView removeFromSuperview];
        [rightImageView removeFromSuperview];
    }
}

#pragma mark - 
#pragma mark Split Methods
- (NSArray *)splitImageIntoTwoParts:(UIImage *)image
{
    /*
     The natural scale factor associated with the screen. (read-only)
     屏幕的比例 是普通(1)还是@2x(2)
     */
    CGFloat scale = [[UIScreen mainScreen] scale];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:2];
    CGFloat width,height,widthgap,heightgap;
    int piceCount = SAWTOOTH_COUNT;
    width = image.size.width;
    height = image.size.height;
    widthgap = width/SAWTOOTH_WIDTH_FACTOR;
    heightgap = height/piceCount;
    //    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextRef context;
    CGImageRef imageMasked;
    UIImage *leftImage,*rightImage;
    
    //part one
    /*
     UIGraphicsBeginImageContext
     
     Creates a bitmap-based graphics context and makes it the current context.
     This function is equivalent to calling the UIGraphicsBeginImageContextWithOptions function with the opaque parameter set to NO and a scale factor of 1.0.
     In iOS 4 and later, you may call this function from any thread of your app.
     
     size
     The size of the new bitmap context. This represents the size of the image returned by the UIGraphicsGetImageFromCurrentImageContext function.
     */
    UIGraphicsBeginImageContext(CGSizeMake(width*scale, height*scale));
    
    /*
     UIGraphicsGetCurrentContext
     
     Returns the current graphics context.
     The current graphics context is nil by default. Prior to calling its drawRect: method, view objects push a valid context onto the stack, making it current. If you are not using a UIView object to do your drawing, however, you must push a valid context onto the stack manually using the UIGraphicsPushContext function.
     In iOS 4 and later, you may call this function from any thread of your app.
     */
    context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, scale, scale);
    CGContextMoveToPoint(context, 0, 0);
    int a=-1;
    for (int i=0; i<piceCount+1; i++) {
        CGContextAddLineToPoint(context, width/2+(widthgap*a), heightgap*i);
        a= a*-1;
    }
    CGContextAddLineToPoint(context, 0, height);
    CGContextClosePath(context);
    CGContextClip(context);
    [image drawAtPoint:CGPointMake(0, 0)];
    imageMasked = CGBitmapContextCreateImage(context);
    leftImage = [UIImage imageWithCGImage:imageMasked scale:scale orientation:UIImageOrientationUp];
    [array addObject:leftImage];
    UIGraphicsEndImageContext();
    
    //part two
    UIGraphicsBeginImageContext(CGSizeMake(width*scale, height*scale));
    context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, scale, scale);
    CGContextMoveToPoint(context, width, 0);
    a=-1;
    for (int i=0; i<piceCount+1; i++) {
        CGContextAddLineToPoint(context, width/2+(widthgap*a), heightgap*i);
        a= a*-1;
    }
    CGContextAddLineToPoint(context, width, height);
    CGContextClosePath(context);
    CGContextClip(context);
    [image drawAtPoint:CGPointMake(0, 0)];
    imageMasked = CGBitmapContextCreateImage(context);
    rightImage = [UIImage imageWithCGImage:imageMasked scale:scale orientation:UIImageOrientationUp];
    [array addObject:rightImage];
    UIGraphicsEndImageContext();
    
    
    return array;
}

@end
