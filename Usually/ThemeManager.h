//
//  ThemeManager.h
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

/*2012-2-27 UIUE问题要能够适应需求的迅速变更
 *此处规定整个工程中的主体部分的图片,背景,cell规格等*
 0.主体部分.导航栏.工具栏.定义好这个部分的图片名称不能更改,统一放在工程的某一个文件夹下
 1.在本地建立Image文件夹,存放所有的图片,把它关联到工程中去.
 2.在工程中建立各个模块的文件夹,不要在本地创建目录,方便替换图片.(前提是文件名定义好,不做变动)
 3.一些各个模块均要使用的图片可以作统一的文件夹存放,如第三方Icon.checkBox等.
 4.
 5.
 **
 */

//通过通知换肤 触发换肤时发一个通知出来 全部的界面实现换肤方法或者创建一个baseController

#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject {
	
	NSDictionary    *themeDictionary;
	NSString        *currentTheme;
	NSInteger        currentThemeIndex;
}

@property (nonatomic, retain) NSDictionary *themeDictionary;
@property (nonatomic, copy)   NSString     *currentTheme;
@property (assign)            NSInteger     currentThemeIndex;

+ (ThemeManager *)sharedInstance;
- (NSArray *)getThemeList;
- (void)setTheme:(NSString *)theme;
- (UIImage *)getImage:(NSString *)imageName;
- (NSDictionary *)getThemeContent:(NSString *)themeName;

//联系人简介信息 cell 的高度
- (NSInteger)getCellHeight;   

//联系人列表显示的cell的高度 线条颜色
- (NSInteger)getContactCellHeight;
- (UIColor *)getCellSeparatorColor;

- (UIImageView *)getCellSelectedBackground;
- (UIImageView *)getCellSelectedBackgroundGroupDefault;
- (UIImageView *)getCellSelectedBackgroundGroup;

@end
