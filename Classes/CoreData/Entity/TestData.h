//
//  TestData.h
//  XSTestProject
//
//  Created by 张松松 on 13-7-4.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TestData : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subTitle;
@property (nonatomic, retain) NSDate * creatTime;


@end
