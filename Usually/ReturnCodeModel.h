//
//  ReturnCodeModel.h
//  XSTestProject
//
//  Created by zhangss on 13-9-26.
//
//

#import <Foundation/Foundation.h>

@interface ReturnCodeModel : NSObject

//返回的错误码及错误码描述信息
@property (nonatomic,assign)NSInteger code;
@property (nonatomic,strong)NSString  *codeDesc;

- (id)initWithCode:(NSInteger)code andDesc:(NSString *)desc;

@end
