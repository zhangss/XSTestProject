//
//  Name.h
//  XSTestProject
//
//  Created by 张松松 on 13-7-4.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Name : NSManagedObject

@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) Person *person;

@end
