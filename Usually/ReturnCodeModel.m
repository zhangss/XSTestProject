//
//  ReturnCodeModel.m
//  XSTestProject
//
//  Created by zhangss on 13-9-26.
//
//

#import "ReturnCodeModel.h"

@implementation ReturnCodeModel

- (id)initWithCode:(NSInteger)code andDesc:(NSString *)desc
{
    self = [super init];
    if (self)
    {
        _code = code;
        _codeDesc = desc;
    }
    return self;
}

@end
