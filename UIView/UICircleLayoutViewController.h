//
//  UICircleLayoutViewController.h
//  XSTestProject
//
//  Created by 张松松 on 13-2-28.
//
//

#import <UIKit/UIKit.h>

@interface UICircleLayoutViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSInteger cellCount;   //记录cell的个数
    UICollectionView *aCollectionView;
}

@end
