//
//  LocalSettings.h
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalSettings : NSObject {
	BOOL         isVoiceOpen;
	BOOL         isShockOpen;
	BOOL         callAlertVibrate; // YES:同震 NO:顺震	
	BOOL		 isFirstInstallApp;	   // YES=第一次运行,NO=不是第一次运行(使用前必须先调用isNotFirstRun)
	
	BOOL		onlineRemind;
	NSString    *currentTheme;
}
@property (nonatomic, copy) NSString *currentTheme;
@property (nonatomic, assign) BOOL isFirstInstallApp;

+ (LocalSettings *)sharedInstance;

- (void)setVoiceTips:(BOOL)aBool;
- (BOOL)getVoiceTips;

- (void)setShockTips:(BOOL)aBool;
- (BOOL)getShockTips;

- (void)setCallAlertVibrate:(BOOL)aBool;
- (BOOL)getCallAlertVibrate;

- (void)setThemeToLocal:(NSString *)aTheme;
- (NSString *)getThemeFromLocal;

- (BOOL)isNotFirstRun;
// NO  :  第一次运行
// YES :  不是第一次运行

- (void)setOnlineRemind:(BOOL)aBool;
- (BOOL)getOnlineRemind;

@end
