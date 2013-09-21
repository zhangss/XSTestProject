//
//  SharedLocationDetailViewCtl.h
//  Megafon
//
//  Created by  dengyafeng on 12-5-7.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

typedef enum{
	MyLocation,
	OtherLocation,
	BothLocation
}ShowLocation;


@class SessionMessage;
@interface SharedLocationDetailViewCtl : BaseController 
<MKMapViewDelegate,CLLocationManagerDelegate,UIActionSheetDelegate>
{
	SessionMessage *_sessionMessage;
	ShowLocation _showLocation;
	NSMutableDictionary *mapAnnotations;
	
	UIButton *leftButton;
	UIButton *rightButton;
	
	MKMapView *m_mapView;
	CLLocationManager *locationManager;
	CLLocationCoordinate2D mySelfCoordinate;
	CLLocationCoordinate2D chatObjectCoordinate;
	
	NSString *backTitle;
}
@property (nonatomic ,retain) UIButton *leftButton;
@property (nonatomic ,retain) UIButton *rightButton;
@property (nonatomic ,retain) NSMutableDictionary *mapAnnotations;
@property (nonatomic, copy) NSString *backTitle;
- (void)initToolBarView;
- (id)initWithSessionMessage:(SessionMessage *)message;

- (void)showMyLocation;
- (void)showOtherLocation;
- (void)showBothLocation;
- (void)initNavigationBackBar;
@end
