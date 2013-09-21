/*******************************************
 文件名称	:	LocationMsgTypeViewController.h
 文件描述	:	位置分享消息的消息类型控制
 备	注	:	
 作	者	:	sunliang
 时	间	:	20120904
 版	权	:	
 *******************************************/
#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>


@interface LocationMsgTypeViewController : BaseController<UITableViewDelegate,
UITableViewDataSource>
{
	UITableView *m_locationMsgTypeTableView;
	NSIndexPath* m_checkedIndexPath;
}

@property (nonatomic, retain) NSIndexPath* checkedIndexPath;

@end
