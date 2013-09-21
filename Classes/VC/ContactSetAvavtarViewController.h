//
//  ContactSetAvavtarViewController.h
//  Megafon
//
//  Created by cuishulin on 12-7-18.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseController.h"
#import "Contact.h"


@interface ContactSetAvavtarViewController : BaseController
<UITableViewDelegate,  UITableViewDataSource>
{
	NSMutableArray  *portraitTypeArray;
	Contact			*aContact;
	NSIndexPath *lastIndexPath;
}
@property (nonatomic, retain)NSIndexPath *lastIndexPath;
@property (nonatomic,retain) NSMutableArray  *portraitTypeArray;
@property (nonatomic,retain) Contact		 *aContact;
- (void)initContact:(Contact *)contactIn;
@end
