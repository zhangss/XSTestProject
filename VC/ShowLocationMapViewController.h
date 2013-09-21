//
//  ShowLocationMapViewController.h
//  Megafon
//
//  Created by zhangss on 12-5-22.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <MapKit/MapKit.h>

@interface ShowLocationMapViewController : BaseController <MKMapViewDelegate>
{
	MKMapView  *myMapView;
	NSNumber   *myLatitude;   //纬度
	NSNumber   *myLongitude;  //经度
	NSString   *myPlaceName;  //位置名称
}

@property (nonatomic,retain) MKMapView *myMapView;
@property (nonatomic,retain) NSNumber  *myLatitude;
@property (nonatomic,retain) NSNumber  *myLongitude;
@property (nonatomic,retain) NSString  *myPlaceName;

@end
