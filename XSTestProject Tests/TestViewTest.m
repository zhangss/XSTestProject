//
//  TestViewTest.m
//  XSTestProject
//
//  Created by 张松松 on 13-11-21.
//
//

#import <XCTest/XCTest.h>
#import "TestView.h"

@interface TestViewTest : XCTestCase

@end

@implementation TestViewTest

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

- (void)testView
{
    
    TestView *view = [[TestView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    XCTAssertEqual(view.frame.origin, CGPointZero, @"View Location Success!");
    XCTAssertEqual(view.frame.size, CGSizeZero, @"View Size Success!");
}


@end
