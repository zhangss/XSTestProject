//
//  BaseProcessor.m
//  XSTestProject
//
//  Created by zhangss on 13-9-26.
//
//

#import "BaseProcessor.h"

@implementation BaseProcessor

- (id)init
{
    self = [super init];
    if (self)
    {
        //初始化解析器 JSON/XML
    }
    return self;
}

#pragma mark -
#pragma mark Common Methods
- (ReturnCodeModel *)getReturnCodeFromRequest:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSInteger resultCode = 0;
    NSString  *codeDesc = nil;
    if (error)
    {
        //HTTP返回Error 可以继续细分
        ZSLog(@"Failed %@ with code %d and with userInfo %@",
              [error domain],
              [error code],
              [error userInfo]);
    }
    else
    {
        //结果返回错误
        NSString *responseString = [request responseString];
        ZSLog(@"%@",responseString);
    }
    ReturnCodeModel *returnCodeModel = [[ReturnCodeModel alloc] initWithCode:resultCode andDesc:codeDesc];
    return returnCodeModel;
}

@end
