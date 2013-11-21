//
//  GZipUtil.h
//  XSTestProject
//
//  Created by 张松松 on 13-11-21.
//
//

#import <Foundation/Foundation.h>

@interface GZipUtil : NSObject

/***************************************************************************/
/*
 原文网址:http://www.clintharris.net/2009/how-to-gzip-data-in-memory-using-objective-c/
 Note: The code in this file has been commented so as to be compatible with
Doxygen, a tool for automatically generating HTML-based documentation from
source code. See http://www.doxygen.org for more info.
*/
/**
    Uses zlib to compress the given data. Note that gzip headers will be added so that the data can be easily decompressed using a tool like WinZip, gunzip, etc.
    Note: Special thanks to Robbie Hanson of Deusty Designs for sharing sample code showing how deflateInit2() can be used to make zlib generate a compressed file with gzip headers:http://deusty.blogspot.com/2007/07/gzip-compressiondecompression.html
    @param pUncompressedData memory buffer of bytes to compress
    @return Compressed data as an NSData object
 **/
+ (NSData *)gzipData:(NSData *)pUncompressedData;

+ (NSData *)uncompressZippedData:(NSData *)compressedData;

/*
 Test:
 - (void)zip
 {
 NSString *string1 = @"{\"UserName\":\"LiYang\",\"Password\":\"123\",\"errorCode\":\"0\"}";
 NSData *data1 = [LFCGzipUtillity gzipData:[string1 dataUsingEncoding:NSUTF8StringEncoding]];
 
 NSData *data2 = [LFCGzipUtillity uncompressZippedData:data1];
 NSString *string2 = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
 textView.text = string2;
 }
 */

@end
