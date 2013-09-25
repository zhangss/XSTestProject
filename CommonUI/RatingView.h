//
//  RatingView.h
//  XSTestProject
//
//  Created by zhangss on 13-9-25.
//
//

#import <UIKit/UIKit.h>

@interface RatingView : UIView
{
    UIImage *_unselectedImage;
    UIImage *_halfSelectedImage;
    UIImage *_fullySelectedImage;
    
    UIImageView *_imageViewOne;
    UIImageView *_imageViewTwo;
    UIImageView *_imageViewThree;
    UIImageView *_imageViewFour;
    UIImageView *_imageViewFive;
    
    CGFloat      _lastRating;
    CGFloat      _newRating;
}

//设置星级
- (void)setRating:(NSNumber *)ratingNumber;

//获取星级
- (NSNumber *)getRating;

@end
