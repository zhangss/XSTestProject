//
//  PhoneNumber.h
//  XSTestProject
//
//  Created by 张松松 on 13-7-4.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface PhoneNumber : NSManagedObject

@property (nonatomic, retain) NSString * cellPhone;
@property (nonatomic, retain) NSString * homePhone;
@property (nonatomic, retain) NSString * workPhone;
@property (nonatomic, retain) Person *person;

@end
