//
//  XSTestProject_Tests.m
//  XSTestProject Tests
//
//  Created by 张松松 on 13-11-21.
//
//

#import <XCTest/XCTest.h>

@interface XSTestProject_Tests : XCTestCase

@end

@implementation XSTestProject_Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample2
{
    XCTAssertTrue(1==1, @"Just Test For Success!");
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
