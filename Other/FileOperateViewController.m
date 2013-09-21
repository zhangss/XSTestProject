//
//  FileOperateViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-8-1.
//
//

#import "FileOperateViewController.h"

@interface FileOperateViewController ()

@end

@implementation FileOperateViewController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString *path=@"/Users/zhangss/Desktop/XSTestProject/Classes/VC";

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:60];
    NSArray  *arr = [[NSFileManager defaultManager] directoryContentsAtPath:path];
    for (int i = 1; i<[arr count]; i++)
    {
        NSString *aString = [arr objectAtIndex:i];
        aString = [aString stringByReplacingOccurrencesOfString:@".h" withString:@""];
        [dic setObject:aString forKey:aString];
    }
    NSLog(@"%@",dic);
    NSString *filePath = [XSTestUtils documentPath];
    [dic writeToFile:[filePath stringByAppendingPathComponent:@"VC.plist"] atomically:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
