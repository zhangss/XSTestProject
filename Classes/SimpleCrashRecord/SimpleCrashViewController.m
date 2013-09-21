//
//  SimpleCrashViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-7-10.
//
//

#import "SimpleCrashViewController.h"

@interface SimpleCrashViewController ()

@end

@implementation SimpleCrashViewController

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
#pragma mark Life Cycel
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"Carsh Record", @"")];
    
    //增加webView
    [self initWebView];
    
    //String相关API调用错误造成崩溃
    [self stringMethods];
    //NSDictionary相关API调用造成崩溃
    [self dictionaryMethods];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UIMethods
- (void)initWebView
{
    //用网页展示出内容 HTML
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView release];
}

#pragma mark -
#pragma mark Other Methods
- (void)stringMethods
{    
    NSString *aString = nil;
    NSString *bString = nil;
    /*
     !!!:1.stringWithString的参数为Nil崩溃
     *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[NSPlaceholderString initWithString:]: nil argument'
     */
//  bString = [NSString stringWithString:aString];
    /*
     !!!:2.stringWithFormat的参数为Nil是得到的是字符串@"(null)"
     */
    bString = [NSString stringWithFormat:@"%@",aString];
    NSLog(@"stringWithFormat:%@",bString);
    /*
     !!!:3.stringByReplacingCharactersInRange的参数range如果为空会崩溃 需要增加对range的判断
     *** Terminating app due to uncaught exception 'NSRangeException', reason: '-[__NSCFString replaceCharactersInRange:withString:]: Range or index out of bounds'
     */
    NSString *subString = @"abc";
    NSString *targetString = @"1234";
    NSRange range = [targetString rangeOfString:subString];
    if (range.location != NSNotFound)
    {
        bString = [targetString stringByReplacingCharactersInRange:range withString:@""];
    }
    NSLog(@"stringByReplacingCharactersInRange:%@",bString);
}

- (void)dictionaryMethods
{
    NSMutableDictionary *aDictionary = [NSMutableDictionary dictionaryWithCapacity:4];
    NSObject *idObj = nil;
    NSString *aString = nil;
    /*
     !!!:1.Dictionary的Vlaue如果为nil则会该条字段没用成功 加入到词典内
     */
    [aDictionary setValue:idObj forKey:@"123"];
    [aDictionary setValue:@"A" forKey:@"123"];
    NSLog(@"Dictionary Value nil:%@",aDictionary);
    
    /*
     !!!:2.Dictionary的Key如果为空则会崩溃 
     *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** setObjectForKey: key cannot be nil'
     */
//    [aDictionary setValue:@"123" forKey:aString];
    
    /*
     !!!:3.Dictionary初始化是如果出现参数为nil,无论是key/Value都会认为字典内容结束，后面的内容不会被加入到字典中。这个问题应该注意！
     */
    aDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"A",@"1",@"B",@"2",aString,@"3",@"D",@"4", nil];
    NSLog(@"Dictionary alloc With nil:%@",aDictionary);
}


@end
