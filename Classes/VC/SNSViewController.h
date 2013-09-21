//
//  SNSViewController.h
//  Megafon
//
//  Created by Miaohz on 11-10-9.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//
//  Management zhangss


#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "SNSDefs.h"
#import "EGORefreshTableHeaderView.h"
#import "SNSListCell.h"

@interface SNSViewController : BaseController 
<UIActionSheetDelegate,SNSListCellDelegate,UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    //-2.MyUpdate -1.All 10.facebook 11.twitter 12.vk 13.od 14.DM
    NSInteger curSNS;         //标识当前要显示的SNS feed信息   
    UIView    *unbindedView;  //未绑定时显示的界面
    
    /*Feed 显示的时间标签*/
    NSDate *alltimemark;
    NSDate *fbtimemark;
    NSDate *twtimemark;
    NSDate *vktimemark;
    NSDate *odtimemark;
    NSDate *uptimemark;
    NSDate *dmtimemark;
    NSDate *allPreTimeMark;
    NSDate *fbPreTimeMark;
    NSDate *twPreTimeMark;
    NSDate *vkPreTimeMark;
    NSDate *odPreTimeMark;
    NSDate *upPreTimeMark;
    
    NSString   *m_BackIndexObjectID; //查看一个Feed之后返回自动滚动到下一个Feed
    NSInteger  lastSelectedType;     //记录上一次点击刷新的第三方类型
    NSString   *m_titleStr;          //Title
    BOOL       isUseTimeMark;        //提示个数的时候是否需要用时间线判断
    BOOL       shouldRefresh;        //切换第三方时时候需要清空缓存
    BOOL       isLoading;            //标识是否正在Loading
        
    UITableView    *tableV;
    BOOL           m_isRefresh; 
    NSMutableArray *listData;        //构造cell的数据源缓存

    EGORefreshTableHeaderView *refreshHeaderView;  //下拉View
    EGORefreshTableHeaderView *refreshFooterView;  //上啦View
    
    NSMutableDictionary       *m_heightDic;
    NSMutableDictionary       *m_urlDic;
    SNSListCell               *snscell;
    NSMutableArray             *m_currentIndexArr;
    UITableViewCell *moreCell;
} 
@property (nonatomic, assign) NSInteger curSNS; 
@property (nonatomic, retain) NSDate* alltimemark;
@property (nonatomic, retain) NSDate* fbtimemark;
@property (nonatomic, retain) NSDate* twtimemark;
@property (nonatomic, retain) NSDate* vktimemark;
@property (nonatomic, retain) NSDate* odtimemark;
@property (nonatomic, retain) NSDate* uptimemark;
@property (nonatomic, retain) NSDate* dmtimemark;
@property (nonatomic, retain) NSDate* allPreTimeMark;
@property (nonatomic, retain) NSDate* fbPreTimeMark;
@property (nonatomic, retain) NSDate* twPreTimeMark;
@property (nonatomic, retain) NSDate* vkPreTimeMark;
@property (nonatomic, retain) NSDate* odPreTimeMark;
@property (nonatomic, retain) NSDate* upPreTimeMark;
@property (nonatomic, retain) NSString *m_BackIndexObjectID;
@property (nonatomic, retain) NSString *m_titleStr;
@property (nonatomic, retain) UITableView *tableV;
@property (nonatomic, retain) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, retain) EGORefreshTableHeaderView *refreshFooterView;
@property (nonatomic, retain) NSMutableArray *listData;
@property (nonatomic) BOOL isLoading;

//外部调用接口
//NewSNSViewController使用
- (void)dismissModalView;

//切换SNS
- (void)switchSNSWithTitleStr:(NSString *)titleStr;
- (void)reloadTableView;
@end
