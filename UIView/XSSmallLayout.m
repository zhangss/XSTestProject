//
//  XSSmallLayout.m
//  XSTestProject
//
//  Created by 张松松 on 13-2-28.
//
//

#import "XSSmallLayout.h"

@implementation XSSmallLayout

- (id)init
{
    self = [super init];
    if (self)
    {
        self.itemSize = CGSizeMake(30.0, 30.0);
        self.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        self.minimumLineSpacing = 10.0;
        //self.minimumInteritemSpacing = 10.0;
    }
    return self;
}

@end
