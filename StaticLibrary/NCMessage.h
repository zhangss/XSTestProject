//
//  NCMessage.h
//  Nigra-Collector-IOS
//
//  Created by SAIC_Zhangss on 14-4-11.
//  Copyright (c) 2014年 Saike. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,MessageCollectType)
{
    MessageCollectTypePage = 0,      //页面跳转
    MessageCollectTypeOperation = 1, //按钮操作
    MessageCollectTypeError = 2,     //错误信息
    MessageCollectTypeException = 3, //异常发成
    MessageCollectTypeOther
};

@interface NCMessage : NSObject

@property (nonatomic,strong) NSString *screenName;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,assign) MessageCollectType action;

+ (NCMessage *)messageWithCode:(NSString *)code type:(MessageCollectType)type andDesc:(NSString *)desc;

+ (NSString *)getTypeDesc:(MessageCollectType)type;

@end
