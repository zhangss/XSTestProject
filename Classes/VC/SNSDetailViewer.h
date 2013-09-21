//
//  SNSDetailViewer.h
//  Megafon
//
//  Created by xiongguofeng on 4/3/12.
//  Copyright (c) 2012 华为技术有限公司. All rights reserved.
//
/*
    文件第一负责人：熊国锋
    文件第二负责人：张松松
 */

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SNSFeedData.h"
#import "SNSDetailViewer.h"
#import "HPGrowingTextView.h"
#import "TopBar.h"
#import "FBComment.h"
#import "SNSDetailFeedWrapper.h"

//界面元素tag标识，以便查找此控件
typedef enum
{
    viewTagProfileButton = 100,
    viewTagCommentBackground,
    viewTagCommentShadow,
    viewTagCommentCellHeadImage,
    viewTagMoreCellIndicator,
    viewTagMoreCellLabel,
    
    DetailViewTagEnd
}SnsDetailViewTags;

typedef enum eMoreCell
{
    SNS_MORE_CELL_READY,
    SNS_MORE_CELL_LOADING,
    SNS_MORE_CELL_FAILED,
    
    SNS_MORE_CELL_END
}SNS_MORE_CELL;

@interface SNSCommentCell : UITableViewCell
{
}
@property (nonatomic, retain)FBComment *comment;
@property (nonatomic, assign)SNS_MORE_CELL status;
@end

@interface SNSDetailViewer : BaseController
<SNSDetailFeedWrapperDelegate, SNSFeedContentViewDelegate, HPGrowingTextViewDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>
{
    //Data
    SNSFeedData *_feedData;
    
    //UIBar items
    NSString    *_backBarButtonText;
    NSString    *_rightBarButtonText;
    TopBar      *_topStatusBar;
    
    //views
    BOOL                    _detailBorder;
    BOOL                    _userDragScroll;
    NSString                *_replyToUserId;
    NSString                *_replyToUserName;
    NSString                *_replyToId;
    SNSDetailFeedWrapper    *_feedWrapper;
    SNSDetailFeedWrapper    *_replyFeedWrapper;
    
    //content
    int             _contentViewHeight;
    int             _imageContentHeight;
    
    //comment
    UITableView     *_commentTable;
    NSMutableArray  *_commentCellList;
    id              _commentRequestView;

    //main contentview
    UIImageView     *_contentView;
    BOOL            viewLoadFinished;
    MKMapView       *m_mapView;
    
    //comment bar
    int                 _commentBarHeight;
    UIView              *_commentBar;
    HPGrowingTextView   *_textEditView;
    UIImageView         *_textEditBackground;
    UIButton            *_commentSendButton;
    CGSize              _keyBoardSize;
    BOOL                bNextPage;
    SNSCommentCell      *_moreCell;
    NSString            *commentNextPage;
    NSInteger           observerCount;
    CGRect              _contentViewOldRect;
    CGRect              _commentTableOldRect;
    BOOL                isSNSPortrait;
    
}
@property(nonatomic, retain)NSString *_backBarButtonText;
@property(nonatomic, retain)NSString *_rightBarButtonText;
@property(nonatomic, retain)SNSFeedData *_feedData;
@property(nonatomic, assign)int _contentViewHeight;
@property(nonatomic, retain)NSMutableArray *_commentCellList;
@property(nonatomic, assign)int _commentBarHeight;
@property(nonatomic, retain)UIView *_commentBar;
@property(nonatomic, retain)TopBar *_topStatusBar;
@property(nonatomic, retain)NSString *commentNextPage;
@property(nonatomic, retain)NSString *commentFeedId;


- (SNSDetailViewer *)initWithFeed:(SNSFeedData *)feed backBarBtnText:(NSString *)backBarBtnText;
- (void)requestFeedComment;
- (void)requestMoreComment:(NSString *)urlNextPage;
- (SNSCommentCell *)mallocCommentCell:(FBComment *)comment;
- (void)addCommentCells:(NSArray*)data;
- (void)changeCommentCellFrame:(NSArray *)cellArr isPortrait:(BOOL)isPortrait;
- (void)putCommentCellShadow;
- (void)refreshViewFrame:(BOOL)isEdit;
- (void)CreateTopBar;
- (void)FinishTopBar:(BOOL)bResult;
- (void)CancelTopBar;
- (void)updateButtonAndMiscInfo;
- (void)initNotificationObserver;
- (void)setNeedAdjustFeedWrapperLayout:(SNSDetailFeedWrapper *)view;
- (void)adjustLayout;
- (void)profileButtonPressed:(SNSFeedData *)feed;
- (BOOL)CheckCommentTextValid;
- (void)updateTextEditAndSendButton;
- (void)insertNewPostedComment:(NSString *)commentID;
- (void)enableAllResponders:(BOOL)enabled;
- (void)changeMoreCell:(SNS_MORE_CELL)status;
//横竖屏切换
- (void)changeSelfFrame:(BOOL)isPortrait;
- (void)changeCellFrame:(BOOL)isPortrait theCell:(SNSCommentCell *)commentCell;
@end


