//
//  BaseProcessor.h
//  XSTestProject
//
//  Created by zhangss on 13-9-26.
//
//

#import <Foundation/Foundation.h>

@interface BaseProcessor : NSObject

- (ReturnCodeModel *)getReturnCodeFromRequest:(ASIHTTPRequest *)request;

@end
