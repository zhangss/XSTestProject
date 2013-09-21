//
//  UILineLayoutViewController.h
//  XSTestProject
//
//  Created by 张松松 on 13-2-28.
//
//

#import <UIKit/UIKit.h>

/*
 1.苹果把PSCollectionView剽窃了一回
 */

/*
 初始化一个layout 然后初始化collectionViewController
 LineLayout* lineLayout = [[LineLayout alloc] init];
 self.viewController = [[ViewController alloc] initWithCollectionViewLayout:lineLayout];
 */

@interface UILineLayoutViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>


@end
