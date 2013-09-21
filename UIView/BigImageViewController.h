//
//  BigImageViewController.h
//  XSTestProject
//
//  Created by 张永亮 on 12-12-12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BigImageViewController : UIViewController {
    BOOL isViewAlloc;
}

- (id)initWithFrame:(CGRect)frame andVC:(id)viewController andImageArr:(NSArray *)imageArr andIndex:(NSInteger)index;

@end
