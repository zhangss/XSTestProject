//
//  NSData+Base64.h
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

/*
 数据的Base64加密
 */

#import <Foundation/Foundation.h>


void *NewBase64Decode(
					  const char *inputBuffer,
					  size_t length,
					  size_t *outputLength);

char *NewBase64Encode(
					  const void *inputBuffer,
					  size_t length,
					  bool separateLines,
					  size_t *outputLength);

@interface NSData (Base64)

+ (NSData *)dataFromBase64String:(NSString *)aString;
- (NSString *)base64EncodedString;

@end
