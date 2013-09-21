//
//  LocalSettings.m
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalSettings.h"

#define KEY_VOICETIPS           @"VoiceTips"
#define KEY_SHOCKTIPS           @"ShockTips"
#define KEY_CALL_ALERT_VIBRATE  @"Call_Alert_Vibrate"
#define KEY_THEME_NAME          @"ThemeName"
#define DEFAULT_THEME_NAME      NSLocalizedString(@"Business", nil)
#define KEY_ONLINE_REMIND		@"onlineRemind"

static LocalSettings *localInstance = nil;

@implementation LocalSettings

@synthesize currentTheme;
@synthesize isFirstInstallApp;

#pragma mark -
#pragma mark 单例模式
+ (LocalSettings *)sharedInstance {
	@synchronized(self) {
		if (localInstance == nil) {
			localInstance = [[LocalSettings alloc] init];
		}
	}
	return localInstance;
}

#pragma mark -
#pragma mark 获取本地设置信息
- (id)init {
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	isVoiceOpen = [userDefault boolForKey:KEY_VOICETIPS];
	if ([userDefault stringForKey:KEY_VOICETIPS] == nil) {
		isVoiceOpen = YES;
	}
	
	isShockOpen = [userDefault boolForKey:KEY_SHOCKTIPS];
	if ([userDefault stringForKey:KEY_SHOCKTIPS] == nil) {
		isShockOpen = YES;
	}
	
	onlineRemind = [userDefault boolForKey:KEY_ONLINE_REMIND];
	
	NSString *temp = [userDefault stringForKey:KEY_THEME_NAME];
	if (temp == nil) {
		self.currentTheme = DEFAULT_THEME_NAME;// default theme
	}
	else {
		self.currentTheme = temp;
	}
	[userDefault setObject:self.currentTheme forKey:KEY_THEME_NAME];
	[userDefault synchronize];
	return self;
}

//App是否是第一次运行
- (BOOL)isNotFirstRun {
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	if ([userDefault boolForKey:@"isFirstRun"] == NO) {
		[userDefault setBool:YES forKey:@"isFirstRun"];
		[userDefault synchronize];
		isFirstInstallApp = YES;
		return NO;
	}
	else {
		[userDefault setBool:YES forKey:@"isFirstRun"];
		[userDefault synchronize];
		isFirstInstallApp = NO;
		return YES;
	}
}


#pragma mark -
#pragma mark VoiceTips
- (void)setVoiceTips:(BOOL)aBool {
	isVoiceOpen = aBool;
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	[userDefault setBool:isVoiceOpen forKey:KEY_VOICETIPS];
	[userDefault synchronize];
}

- (BOOL)getVoiceTips {
	return isVoiceOpen;
}

#pragma mark -
#pragma mark ShockTips
- (void)setShockTips:(BOOL)aBool {
	isShockOpen = aBool;
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	[userDefault setBool:isShockOpen forKey:KEY_SHOCKTIPS];
	[userDefault synchronize];
}

- (BOOL)getShockTips {
	return isShockOpen;
}

#pragma mark -
#pragma mark CallAlertVibrate
- (void)setCallAlertVibrate:(BOOL)aBool {
	callAlertVibrate = aBool;
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	[userDefault setBool:callAlertVibrate forKey:KEY_CALL_ALERT_VIBRATE];
	[userDefault synchronize];
}

- (BOOL)getCallAlertVibrate {
	return callAlertVibrate;
}

#pragma mark -
#pragma mark Theme
- (void)setThemeToLocal:(NSString *)aTheme {
	self.currentTheme = aTheme;
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	[userDefault setObject:self.currentTheme forKey:KEY_THEME_NAME];
	[userDefault synchronize];
}

- (NSString *)getThemeFromLocal {
	return self.currentTheme;
}

- (void)setOnlineRemind:(BOOL)aBool {
	onlineRemind = aBool;
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	[userDefault setBool:onlineRemind forKey:KEY_ONLINE_REMIND];
	[userDefault synchronize];
	
}
- (BOOL)getOnlineRemind {
	return onlineRemind;
}

- (void)dealloc {
	[currentTheme release];
	[super dealloc];
}

@end