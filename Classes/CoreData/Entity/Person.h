//
//  Person.h
//  XSTestProject
//
//  Created by 张松松 on 13-7-4.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Name, PhoneNumber;

@interface Person : NSManagedObject

@property (nonatomic, retain) Name *personName;
@property (nonatomic, retain) PhoneNumber *personNumber;

@end
