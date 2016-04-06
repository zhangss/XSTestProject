//
//  ZipTest.m
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14/10/29.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ZipArchive.h"
#import "GZipUtil.h"

@interface ZipTest : XCTestCase

@end

@implementation ZipTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testGZip {
    UIImage *image = [UIImage imageNamed:@"sampleIamge4@2x.jpeg"];
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSData *zipData = [GZipUtil gzipData:imageData];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath = [paths objectAtIndex:0];
    
    //原图片
    NSString *filePath = [[documentPath stringByAppendingPathComponent:@"ImageData"] stringByAppendingPathExtension:@"png"];
    [imageData writeToFile:filePath atomically:YES];
    
    //压缩之后的图片
    filePath = [[documentPath stringByAppendingPathComponent:@"ZIPImageData"] stringByAppendingPathExtension:@"zip"];
    NSLog(@"%@",filePath);
    BOOL isSuccess = [zipData writeToFile:filePath atomically:YES];
    XCTAssertTrue(isSuccess,"");
}

- (void)testZip {
    ZipArchive *zipper = [[ZipArchive alloc] init];
    NSString *fileOne = [[NSBundle mainBundle] pathForResource:@"sampleIamge4@2x" ofType:@"jpeg"];
    NSString *fileTwo = [[NSBundle mainBundle] pathForResource:@"sampleIamge3@2x" ofType:@"jpeg"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *filePath = [[documentPath stringByAppendingPathComponent:@"test"] stringByAppendingPathExtension:@"zip"];
    [zipper CreateZipFile2:filePath];
    [zipper addFileToZip:fileOne newname:@"1.jpeg"];
    [zipper addFileToZip:fileTwo newname:@"2.jpeg"];
    if (![zipper CloseZipFile2]) {
        filePath = @"";
    }
    NSLog(@"%@",filePath);
    XCTAssertTrue([filePath isEqualToString:@""], @"");
}

@end
