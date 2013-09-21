//
//  CALayerViewController.h
//  XSTestProject
//
//  Created by 张松松 on 13-5-20.
//
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface MyLayerDelegate : NSObject

@end

@interface CALayerViewController : BaseController
{
    CALayer *myLayer;
    CALayer *subLayer;
    
    UIBezierPath *pacmanOpenPath;
    UIBezierPath *pacmanClosePath;
    CAShapeLayer *pacManLayer;
}

@end
