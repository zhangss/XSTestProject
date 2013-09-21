    //
//  ThemeManager.m
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ThemeManager.h"
#import "LocalSettings.h"

//NSString *const kThemeDidChangeNotification = @"kThemeDidChangeNotification";
static ThemeManager *themeInstance = nil;

@implementation ThemeManager

@synthesize themeDictionary;
@synthesize currentTheme;
@synthesize currentThemeIndex;

+ (ThemeManager *)sharedInstance {
	@synchronized(themeInstance) {
		if (themeInstance == nil) {
			themeInstance = [[ThemeManager alloc] init];
		}
	}
	return themeInstance;
}

- (id)init {
	self = [super init];
	if (self) {     
		// modify by miaohz 更换皮肤
		NSDictionary *business = [[NSDictionary alloc] initWithObjectsAndKeys:
								  @"navigationbarBg03.png",@"navigationBar",
								  [UIColor colorWithRed:0.3 green:0.65 blue:0.21 alpha:0.5],    @"navigationColor",
								  @"setting_background.png",                                               @"background",
								  @"logoRCS03.png",														@"rcsLogo",
								  @"login03.png",													@"commonbutton",
								  @"ipSetting02.png",													@"settingbutton",
								  @"register03.png",												@"fadebutton",
								  @"login_bg03.png",												@"loginbackground",
								  @"imBg02.png",												@"imbackground",
								  @"contact_sort_btn01.png",										@"contact_sort",
								  @"inviteRCSBtnBg02.png", @"inviteImg",
								  @"previousBtn03.png",                                     @"OneBox_previous",
								  @"nextBtn03.png",                                             @"OneBox_next",
								  @"notice_bg03.png",									@"notice_bg",
								  nil];
		
		NSDictionary *life = [[NSDictionary alloc] initWithObjectsAndKeys:
							  @"navigationbarBg02.png",@"navigationBar",
							  [UIColor colorWithRed:0.129 green:0.423 blue:0.701 alpha:0.5],    @"navigationColor",
							  @"setting_bg02.png",                                               @"background",
							  @"logoRCS03.png",														@"rcsLogo",
							  @"login02.png",													@"commonbutton",
							  @"ipSetting02.png",													@"settingbutton",
							  @"register02.png",												@"fadebutton",
							  @"login_bg02.png",												@"loginbackground",
							  @"imBg02.png",												@"imbackground",
							  @"contact_sort_btn02.png",										@"contact_sort",
							  @"inviteRCSBtnBg02.png", @"inviteImg",
							  @"previousBtn2.png",                                     @"OneBox_previous",
							  @"nextBtn02.png",                                             @"OneBox_next",
							  nil];
		
		themeDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
						   business,      NSLocalizedString(@"Business",nil),
						   life,     NSLocalizedString(@"Life",nil),
						   nil];
		[business release];
		[life release];
		
 		self.currentThemeIndex = 0;
		self.currentTheme = [[LocalSettings sharedInstance] getThemeFromLocal]; 
		//DDLogVerbose(@"current theme: %@", self.currentTheme);
	}
	return self;
}

- (NSArray *)getThemeList {
	NSArray *themeArr = [themeDictionary allKeys];
	NSArray *sortedArray = [themeArr sortedArrayUsingComparator: ^(id obj1, id obj2) {
		return [obj1 caseInsensitiveCompare:obj2];
	}];
	return sortedArray;
}

- (void)setTheme:(NSString *)theme {
	if (theme) {
		self.currentTheme = theme;
		[[LocalSettings sharedInstance] setThemeToLocal:self.currentTheme];
		//DDLogVerbose(@"saved theme: %@", self.currentTheme);
	}
}

- (UIImage *)getImage:(NSString *)imageName {
	NSString *themeName = self.currentTheme;
	NSString *themePathTemp = [self.themeDictionary objectForKey:themeName];
	NSString *themePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:themePathTemp];
	UIImage *_image = nil;
	if (themePath) {
		_image = [UIImage imageWithContentsOfFile:[themePath stringByAppendingPathComponent:imageName]];
	}
	return _image;	
}

- (NSDictionary *)getThemeContent:(NSString *)themeName {
	NSDictionary *themeContent = [themeDictionary objectForKey:themeName];
	if (themeContent) {
		return themeContent;
	}
	else {
		return nil;
	}
}

//普通的联系人简介 cell的高度
- (NSInteger)getCellHeight {
	return 44;
}

//联系人列表显示的 cell的高度
- (NSInteger)getContactCellHeight {
	return 60;
}

//TableView PlanStyle
- (UIImageView *)getCellSelectedBackground{
	UIImageView *bgView = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,60)] autorelease];
	bgView.image = [UIImage imageNamed:@"select_bg03.png"];       // modify by miaohz 更换cell选中图片
	return bgView;
}

//TableView Group1
- (UIImageView *)getCellSelectedBackgroundGroup{
	UIImageView *bgView = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,60)] autorelease];
	bgView.image = [UIImage imageNamed:@"SelectedBackViewAll"];       // modify by miaohz 更换cell选中图片
	return bgView;
}

//TableView Group2 图片圆角较大 默认的cell圆角
- (UIImageView *)getCellSelectedBackgroundGroupDefault{
	UIImageView *bgView = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,60)] autorelease];
	bgView.image = [UIImage imageNamed:@"table1_press"];       // modify by miaohz 更换cell选中图片
	return bgView;
}

- (UIColor *)getCellSeparatorColor {
	UIColor *separatorColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
	return separatorColor;
}

-(void)dealloc {   
	[currentTheme release];
	[themeDictionary release];
	[super dealloc];
}

@end
