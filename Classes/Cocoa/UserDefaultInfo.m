//
//  UserDefaultInfo.m
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-5-26.
//
//

#import "UserDefaultInfo.h"


NSString * const UserDefaultKey = @"123";

@implementation UserDefaultInfo

- (NSUserDefaults *)getUserDefault
{
    return [NSUserDefaults standardUserDefaults];
}

@end
