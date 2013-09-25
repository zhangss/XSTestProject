//
//  IOSExceptionViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-7-1.
//
//

#import "IOSExceptionViewController.h"

@interface IOSExceptionViewController ()

@end

@implementation IOSExceptionViewController

#pragma mark -
#pragma mark IOS Exception
void UncaughtExceptionHandler(NSException *exception)
{
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *urlStr = [NSString stringWithFormat:@"mailto:dengyf@easier.cn,zhousl@easier.cn,quanhongwei@126.com?subject=Megafon_db Bug Report &body=Thanks for your coorperation!<br><br><br>"
                        "AppName:Megafon<br>"\
                        "Version:%@<br>"\
                        "Build:%@<br>"\
                        "Details:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@",
                        RCS_VERSION,RCS_BUILD,
                        name,reason,[arr componentsJoinedByString:@"<br>"]];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

void SignalHandler(int sig)
{
    NSArray *arr = [NSThread callStackSymbols];
    NSString *reason = [NSString stringWithFormat:@"SignalHandler: %d", sig];
    NSString *name = [[NSThread currentThread] name];
    NSString *urlStr = [NSString stringWithFormat:@"mailto:dengyf@easier.cn,zhousl@easier.cn,quanhongwei@126.com?subject=Megafon_db Bug Report &body=Thanks for your coorperation!<br><br><br>"
                        "AppName:Megafon<br>"\
                        "Version:%@<br>"\
                        "Build:%@<br>"\
                        "Details:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@",
                        RCS_VERSION,RCS_BUILD,
                        name,reason,[arr componentsJoinedByString:@"<br>"]];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

static void handleRootException( NSException* exception )
{
    NSString* name = [ exception name ];
    NSString* reason = [ exception reason ];
    NSArray* symbols = [ exception callStackSymbols ]; // 异常发生时的调用栈
    NSMutableString* strSymbols = [ [ NSMutableString alloc ] init ]; // 将调用栈拼成输出日志的字符串
    for ( NSString* item in symbols )
    {
        [ strSymbols appendString: item ];
        [ strSymbols appendString: @"\r\n" ];
    }
    
    // 写日志，级别为ERROR
    NSLog(@"Funcction:%s,[ Uncaught Exception ]\r\nName: %@, Reason: %@\r\n[ Fe Symbols Start ]\r\n%@[ Fe Symbols End ]",__FUNCTION__, name, reason, strSymbols );
    [ strSymbols release ];
        
    // 写一个文件，记录此时此刻发生了异常。这个挺有用的哦
    NSDictionary* dict = [ NSDictionary dictionaryWithObjectsAndKeys:
                          [XSTestUtils dataFilePath:@"Log"], @"LogFileName", // 当前日志文件名称
                          [XSTestUtils documentPath], @"LogFileFullPath",    // 当前日志文件全路径
                          [ NSDate date ], @"TimeStamp",                     // 异常发生的时刻
                          nil ];
    NSString* path = [ NSString stringWithFormat: @"%@/Documents/", NSHomeDirectory() ];
    NSString* lastExceptionLog = [ NSString stringWithFormat: @"%@LastExceptionLog.txt", path ];
    [ dict writeToFile: lastExceptionLog atomically: YES ];
}

#pragma mark -
#pragma mark Life Cycel

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
        NSSetUncaughtExceptionHandler(&handleRootException);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

//    NSString *aString = [[[NSString alloc] initWithFormat:@"%@ and %@",@"a",@"b"] autorelease];
    @try
    {
//        [aString release];
//        array = [ executeFetchRequest:request error:&tmpErr];

    }
    @catch (NSException *exception)
    {
//        NSLog(@"%@",exception);
    }
    @finally
    {
//        NSLog(@"aString:%@",aString);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark Other Methods

@end
