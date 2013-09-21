//
//  SNSFriendsViewController.h
//  Megafon
//
//  Created by 王超 on 12-3-21.
//  Copyright (c) 2012年 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNSFriendsCustomCell.h"

typedef enum
{
    tw_followers = 1,
    tw_following = 2,
    
    tw_friend_end
}TWITTER_FRIEND_TYPE;

@interface SNSFriendsViewController : BaseController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *friendsTable;
    NSMutableArray *friendsArray;
    NSInteger      f_type;
    TWITTER_FRIEND_TYPE t_type;
    
    BOOL            bNextPage;
    NSString        *strMoreCell;
    UIImageView     *bgofCell;
    
    UIImage         *facebookImage;
    UIImage         *twitterImag;
    UIImage         *vk_snsImag;
    UIImage         *od_imImag;
}

@property(nonatomic,retain)NSMutableArray *friendsArray;
@property(nonatomic,assign)NSInteger      f_type;
@property(nonatomic,assign)TWITTER_FRIEND_TYPE t_type;
@property(nonatomic,assign)BOOL           bNextPage;
@property(nonatomic,retain)NSString       *strMoreCell;

- (void)copyDataArray:(NSArray *)dataArray;

@end
