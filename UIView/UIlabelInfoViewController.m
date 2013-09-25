    //
//  UIlabelInfoViewController.m
//  XSTestProject
//
//  Created by 张永亮 on 12-11-24.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UIlabelInfoViewController.h"

#import "OHAttributedLabel.h"
#import "CoreGraphicView.h"

@implementation UIlabelInfoViewController

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
    
    //self.view == [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    
    /*
     numberOfLines 换行
     this determines the number of lines to draw and what to do when sizeToFit is called. default value is 1 (single line). A value of 0 means no limit
     if the height of the text reaches the # of lines or the height of the view is less than the # of lines allowed, the text will be
     truncated using the line break mode.
     
     numberOfLines
     The maximum number of lines to use for rendering text.
     
     @property(nonatomic) NSInteger numberOfLines
     Discussion
     This property controls the maximum number of lines to use in order to fit the label’s text into its bounding rectangle. The default value for this property is 1. To remove any maximum limit, and use as many lines as needed, set the value of this property to 0.
     
     If you constrain your text using this property, any text that does not fit within the maximum number of lines and inside the bounding rectangle of the label is truncated using the appropriate line break mode.
     
     When the receiver is resized using the sizeToFit method, resizing takes into account the value stored in this property. For example, if this property is set to 3, the sizeToFit method resizes the receiver so that it is big enough to display three lines of text.
     
     Availability
     Available in iOS 2.0 and later.
     
     //写入多少 打印多少 与实际的行数 不一致
     */
    
    NSString *textStr1 = @"abcd";
    NSString *textStr2 = @"打印多少";
    NSString *textStr3 = @"ab打印";
    NSLog(@"Unicode: English:%d China:%d and:%d",[textStr1 length],[textStr2 length],[textStr3 length]);
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSLog(@"English:%d China:%d and:%d",[textStr1 lengthOfBytesUsingEncoding:enc],[textStr2 lengthOfBytesUsingEncoding:enc],[textStr3 lengthOfBytesUsingEncoding:enc]);
    
    //这个Label有缺陷 字体间距与原生不同
    NSString *testText = @"fadfasdfasdfasdfasdfadsfdsafasdfasdbcvcvsdsdgfhngfhnghjyttndgfbnfgdrthrethgbfgbdfgjhjruyituykjtmhnmbncbdghtyrtukruykyilyiol;yk,vnmfhj";
    
    OHAttributedLabel *textLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(10, 10, 300, 200)];
    textLabel.automaticallyAddLinksForType = NSTextCheckingTypeLink;
    textLabel.userInteractionEnabled = YES;
    textLabel.underlineLinks = YES;
    textLabel.linkColor = [UIColor blueColor];
    textLabel.onlyCatchTouchesOnLinks = NO;
    textLabel.numberOfLines   = 0;
    textLabel.backgroundColor = [UIColor redColor];
    textLabel.font            = [UIFont fontWithName:TEXT_FONT_REGULAR size:15];
    textLabel.textColor = [UIColor blueColor];
    textLabel.lineBreakMode   = UILineBreakModeTailTruncation;
    textLabel.text = testText;
    [textLabel sizeToFit];
//    CGSize textSize = [textLabel.text sizeWithFont:textLabel.font constrainedToSize:CGSizeMake(300.0, 200.0) lineBreakMode:UILineBreakModeTailTruncation];
//    CGRect labelFrame = textLabel.frame;
//    labelFrame.size = textSize;
//    textLabel.frame = labelFrame;
//    [textLabel textRectForBounds:CGRectMake(10, 10, 300, 30) limitedToNumberOfLines:2];
    NSLog(@"111%d",textLabel.numberOfLines);
    [self.view addSubview:textLabel];
    [textLabel release];
    
    UILabel *textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 300.0, 0)];
    textLabel1.lineBreakMode   = UILineBreakModeTailTruncation;
    textLabel1.numberOfLines   = 2;
    textLabel1.backgroundColor = [UIColor redColor];
    textLabel1.font            = [UIFont fontWithName:TEXT_FONT_REGULAR size:15];
    textLabel1.textColor = [UIColor blueColor];
    textLabel1.text = testText;
    NSLog(@"2222%d",textLabel1.numberOfLines);
    CGSize textSize1 = [textLabel1.text sizeWithFont:textLabel1.font constrainedToSize:CGSizeMake(300.0, 200.0) lineBreakMode:UILineBreakModeTailTruncation];
    CGRect labelFrame1 = textLabel1.frame;
    labelFrame1.size = textSize1;
    //[textLabel1 textRectForBounds:CGRectMake(10, 10, 300, 30) limitedToNumberOfLines:2];
    textLabel1.frame = labelFrame1;
    [self.view addSubview:textLabel1];
    [textLabel1 release];
    
    /*
     Label换行
     问题:字数大于两行时 字数越多 计算的高度越大与实际2行的高度不符合
     */
//    UILabel *textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 300.0, 0)];
//    textLabel1.lineBreakMode   = UILineBreakModeTailTruncation;
//    textLabel1.numberOfLines   = 2;
//    textLabel1.backgroundColor = [UIColor redColor];
//    textLabel1.font            = [UIFont fontWithName:TEXT_FONT_REGULAR size:15];
//    textLabel1.textColor = [UIColor blueColor];
//    textLabel1.text = testText;
//    CGSize textSize1 = [textLabel1.text sizeWithFont:textLabel1.font constrainedToSize:CGSizeMake(300.0, 200.0) lineBreakMode:UILineBreakModeTailTruncation];
//    CGRect labelFrame1 = textLabel1.frame;
//    labelFrame1.size = textSize1;
//    textLabel1.frame = labelFrame1;
//    [self.view addSubview:textLabel1];
//    [textLabel1 release];
    
    
    //label1.lineBreakMode = UILineBreakModeTailTruncation;
    //截取方式有以下6种
    //typedef enum {       
    //    UILineBreakModeWordWrap = 0,    以空格为边界，保留整个单词         
    //    UILineBreakModeCharacterWrap,   保留整个字符         
    //    UILineBreakModeClip,            到边界为止         
    //    UILineBreakModeHeadTruncation,  省略开始，以……代替       
    //    UILineBreakModeTailTruncation,  省略结尾，以……代替      
    //    UILineBreakModeMiddleTruncation,省略中间，以……代替，多行时作用于最后一行       
    //} UILineBreakMode;
    
    
    CoreGraphicView *tempView = [[CoreGraphicView alloc] initWithFrame:CGRectMake(10, 50, 300, 150)];
    [self.view addSubview:tempView];
    [tempView release];
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
