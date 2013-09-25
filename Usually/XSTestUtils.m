//
//  XSTestUtils.m
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "XSTestUtils.h"

#import "NSData+Base64.h"

@implementation XSTestUtils

#pragma mark -- 获取document路径
+ (NSString *) documentPath
{
    //获取存档对象的路径
    NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath=[paths objectAtIndex:0];
    return documentPath;
}

#pragma mark -
#pragma mark 获取视频第一帧图片
/*
 获取视频第一帧图片
 需要AVFoundationFramework 和 CoreMediaFramework
 */
+ (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time
{
    AVURLAsset *asset = [[[AVURLAsset alloc] initWithURL:videoURL options:nil] autorelease];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[[AVAssetImageGenerator alloc] initWithAsset:asset] autorelease];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
    {
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    }
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[[UIImage alloc] initWithCGImage:thumbnailImageRef] autorelease] : nil;
    CGImageRelease(thumbnailImageRef);
    return thumbnailImage;
}

#pragma mark -- 获取数据文件路径,即documen路径和数据文件路径的组合
+ (NSString *) dataFilePath:(NSString*)name
{
    return [[XSTestUtils documentPath] stringByAppendingPathComponent:name];
}

#pragma mark -- 应用程序保存媒体文件路径
+ (NSString *) appMediaFilePath
{
    return [[XSTestUtils documentPath] stringByAppendingPathComponent:@"Medias"];
}

#pragma mark -- 获取IM文件保存的目录
+(NSString *)IMMideaFilePath{
	return [[XSTestUtils appMediaFilePath] stringByAppendingPathComponent:@"IM"];
}

#pragma mark -- 根据路径创建对应的目录
+ (BOOL) createPathWithFilePath:(NSString *) filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
	/* 另外一种写法
	BOOL isDirectory = YES;
	if(![fileManager fileExistsAtPath:str isDirectory:&isDirectory])
	{
		DDLogInfo(@"Create SNS HeadImage directory");
		NSError* error = nil;
		[fileManager createDirectoryAtPath:str  withIntermediateDirectories:YES attributes:nil error:&error];
	}*/
	if ([fileManager fileExistsAtPath:filePath]){
		return YES;
	}
    else {//写入文件
		return [fileManager createDirectoryAtPath:filePath 
                      withIntermediateDirectories:YES 
                                       attributes:nil 
                                            error:nil];
	}
}

#pragma mark -- 创建im的多媒体文件存放目录
+(NSString *)createIMMediaFile{
	NSString *imMediaFilePath = [XSTestUtils IMMideaFilePath];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:imMediaFilePath]) {
		return imMediaFilePath;
	}else {
		BOOL isSuccess = [fileManager createDirectoryAtPath:imMediaFilePath withIntermediateDirectories:YES attributes:nil error:nil];
		if (isSuccess) {
			return imMediaFilePath;
		}else {
			return nil;
		}
	}
}

#pragma mark -- 根据媒体文件名称，获取应用程序媒体全路径
+ (NSString *) appMediaFilePathForFileName:(NSString *)fileName
{
    return [[XSTestUtils appMediaFilePath] stringByAppendingPathComponent:fileName];
}

+ (NSString *)fileNameWithExtension:(NSString*)extension {
	return [NSString stringWithFormat:@"%@.%@",
			[XSTestUtils stringDateByFormatString:@"yyyyMMddHHmmssSSS"],
			extension];
}

+ (NSString *)getNewAttachmentFileName:(NSString*)extension
{
	if ([extension length] == 0) {
		extension = @"temp";
	}
	
	NSString* name = [XSTestUtils fileNameWithExtension:extension];
	
	NSString* fileName = [XSTestUtils dataFilePath:[NSString stringWithFormat:@"/attachments/%@" , name]];
	
	return fileName;
}
+ (NSString *)getNewSNSHeadImageFileName:(NSString *)fileName{
	NSString *filePath = [XSTestUtils dataFilePath:[NSString stringWithFormat:@"/SNSHeadImage/%@",fileName]];
	return filePath;
}
+ (NSString *)getNewTempFileName:(NSString*)extension
{
	if ([extension length] == 0) {
		extension = @"temp";
	}
	
	NSString *filename = [NSString stringWithFormat:@"%@.%@", 
						  [XSTestUtils stringDateByFormatString:@"yyyyMMddHHmmssSSS"] , extension];
	NSString *fullPath = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
	
	return fullPath;
}

#pragma mark -- 保存对象到指定文件
+ (void) saveObjectToFile:(id)obj key:(NSString *) fileName
{
    NSMutableData *data=[[NSMutableData alloc] init];//存放对象数据的缓冲
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:data];//用缓冲实例化存档对象
    [archiver encodeObject:obj forKey:fileName];//用存档对象的方法，把对象保存在数据缓冲中
    [archiver finishEncoding];//通知对象保存到缓冲中结束
    [data writeToFile:[XSTestUtils dataFilePath:@"archive"] atomically:YES];//缓冲把对象数据保存到文件中
    
    [archiver release];
    [data release];
}

#pragma mark -- 从对象文件读取数据到对象中
+ (id) loadObjectFromFile:(NSString *) fileName
{
    NSMutableData *data=[[NSMutableData alloc] initWithContentsOfFile:[XSTestUtils dataFilePath:@"archive"]];
    NSKeyedUnarchiver *unArchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id  obj=[unArchiver decodeObjectForKey:fileName];
    [unArchiver finishDecoding];
    
    [unArchiver release];
    [data release];
    
    return obj;
}


#pragma mark -- 保存图片到指定png文件
//返回保存成功的路径
+ (NSString *) saveImageToPNGFile:(UIImage *) image fileName:(NSString *)fileName
{
    NSString * path=[XSTestUtils dataFilePath: fileName];
    if([UIImagePNGRepresentation(image) writeToFile:path atomically:YES])
    {
        return path;
    }
    else 
    {
        return nil;
    }
    
}


//保存图片到指定png文件
#pragma mark -- 返回保存成功的路径
+ (NSString *) saveImageToPNGFileByImage:(UIImage *) image
{
    NSString *filename=[NSString stringWithFormat:@"%@.png",
                        [XSTestUtils stringDateByFormatString:@"yyyyMMddHHmmssSSS"]];
    return [XSTestUtils saveImageToPNGFile:image fileName:filename];
}

+ (NSString *) saveImageToPNGFileToTmpPath:(UIImage*)image {
	
	NSString *fullPath = [XSTestUtils getNewTempFileName:@"png"];
	if ([UIImagePNGRepresentation(image) writeToFile:fullPath atomically:YES]) {
		return fullPath;
	} else {
		return nil;
	}
	
}

#pragma mark -- 移出本地缓存图片
+(BOOL)deleteImageFileByPath:(NSString*)path{
    BOOL issuccess=[[NSFileManager defaultManager] removeItemAtPath:path error:nil];
	
	return issuccess;
}


+ (UIImage *)scaleImage:(UIImage*)image withMaxArea:(float)area {
	UIImage *newImage = image;
	
	//原Image的Szie
	CGSize size = image.size;
	float imageArea = size.width * size.height;
	if (imageArea > area) {
		//求平方根
		float scale =  sqrt(area / imageArea);		//use the sqrt(),may be other method
		CGSize newSize = { size.width * scale , size.height * scale };
		UIGraphicsBeginImageContext(newSize);
		[image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
		newImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	}
	
	return newImage;
}

#pragma mark --保存图片到指定png文件
//返回文件名
+ (NSString *) saveImageToPNGFileByImageExt:(UIImage *) image
{
    NSString *newfilename=[NSString stringWithFormat:@"%@.png",
						   [XSTestUtils stringDateByFormatString:@"yyyyMMddHHmmssSSS"]];
    [XSTestUtils saveImageToPNGFile:image fileName:newfilename];
    return newfilename;
}
#pragma mark -- 根据时间获取相应的日期字符串(今天,昨天,星期XXX)
+(NSString *)weekStringByUTCDate:(NSDate *)aDate{
    if (aDate == nil) {
		return nil;
	}
	NSMutableString *retStr = [[[NSMutableString alloc] init] autorelease];
	NSString *strFormat = NSLocalizedString(@"yyyy-MM-dd",nil);
	NSString *strFormat2 = NSLocalizedString(@"yyyy-MM-dd HH:mm:ss",nil);
	
	NSString *dateYMD = [self stringDateByFormatString:strFormat withDate:aDate];
	
	NSString *todayYMD = [self stringDateByFormatString:strFormat withDate:[NSDate date]];
	if ([dateYMD isEqualToString:todayYMD]) {//是今天 begin [AR-FUNC 今天时间不要显示today]zhengxiaohe 2012/2/13
		//		[retStr appendString:@"Today"];
        //end
		[retStr appendFormat:@"%@",[self stringDateByFormatString:strFormat withDate:aDate]];
		[retStr appendFormat:@" %@",[self stringDateByFormatString:@"HH:mm" withDate:aDate]];
		return retStr;
	}
	//begin added by chenfeng at 2012 2 11 转换成本地时区  
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:strFormat2];
    NSDate *todayZero = [formatter dateFromString:[NSString stringWithFormat:@"%@ 00:00:00",todayYMD]];
    [formatter release];
	//end added
	//NSDate *todayZero = [self dateFromString:[NSString stringWithFormat:@"%@ 00:00:00",todayYMD] withFormatString:strFormat2];
	//yesterday is leak: find_ leak
	NSDate *yesterday = [[[NSDate alloc] initWithTimeInterval:-24*3600 sinceDate:todayZero] autorelease];
	NSString *yesterdayYMD = [self stringDateByFormatString:strFormat withDate:yesterday];
	if ([dateYMD isEqualToString:yesterdayYMD]) {//是昨天 begin [AR-FUNC 只显示日期年月日几时几刻]zhengxiaohe 2012/2/14 add
		[retStr appendFormat:@"%@",[self stringDateByFormatString:strFormat withDate:aDate]];
		//		[retStr appendString:@"Yesterday"];
        //end
		[retStr appendFormat:@" %@",[self stringDateByFormatString:@"HH:mm" withDate:aDate]];
		return retStr;
	}
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	[calendar setFirstWeekday:2];
	NSInteger week = [calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:[NSDate date]];
	NSDate *weekZero = [[[NSDate alloc] initWithTimeInterval:(week -1)*24*(-3600) sinceDate:todayZero] autorelease];
	
	NSTimeInterval regin = [aDate timeIntervalSinceDate:weekZero];
	if (regin >= 0) {//本周内  begin [AR-FUNC 只显示日期年月日几时几刻]zhengxiaohe 2012/2/14 modify
		switch ((int)((regin/86400)+ 1)) {
				//			case 1:
				//				[retStr appendString:@"Mon"];
				//				break;
				//			case 2:
				//				[retStr appendString:@"Tue"];
				//				break;
				//			case 3:
				//				[retStr appendString:@"Wed"];
				//				break;
				//			case 4:
				//				[retStr appendString:@"Thu"];
				//				break;
				//			case 5:
				//				[retStr appendString:@"Fri"];
				//				break;
				//			case 6:
				//				[retStr appendString:@"Sat"];
				//				break;
				//			case 7:
				//				[retStr appendString:@"Sun"];
				//				break;
				//			default:
				//				break;
		}
        [retStr appendFormat:@"%@",[self stringDateByFormatString:strFormat withDate:aDate]];
		[retStr appendFormat:@" %@",[self stringDateByFormatString:@"HH:mm" withDate:aDate]];
		return retStr;
        //end
	}
    else{
        
		[retStr appendFormat:@"%@",[self stringDateByFormatString:strFormat withDate:aDate]];
        // begin [AR-FUNC 只显示日期年月日几时几刻]zhengxiaohe 2012/2/14 add
        [retStr appendFormat:@" %@",[self stringDateByFormatString:@"HH:mm" withDate:aDate]];
        //end
    }
	
	return retStr;
}


#pragma mark -- 根据时间获取相应的日期字符串(今天,昨天,星期XXX) 没有今天的格式
+(NSString *)weekStringByUTCDateWithoutToday:(NSDate *)aDate{
    
	NSMutableString *retStr = [[[NSMutableString alloc] init] autorelease];
	
	NSString *strFormat = NSLocalizedString(@"yyyy-MM-dd",nil);
	NSString *strFormat2 = NSLocalizedString(@"yyyy-MM-dd HH:mm:ss",nil);
	
	NSString *dateYMD = [self stringDateByFormatString:strFormat withDate:aDate];
	
	NSString *todayYMD = [self stringDateByFormatString:strFormat withDate:[NSDate date]];
	if ([dateYMD isEqualToString:todayYMD]) {//是今天 begin [AR-FUNC 今天时间不要显示today]zhengxiaohe 2012/2/13
		//		[retStr appendString:@"Today"];
        //end
		[retStr appendFormat:@" %@",[self stringDateByFormatString:@"HH:mm" withDate:aDate]];
		return retStr;
	}
	//begin added by chenfeng at 2012 2 11 转换成本地时区  
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:strFormat2];
    NSDate *todayZero = [formatter dateFromString:[NSString stringWithFormat:@"%@ 00:00:00",todayYMD]];
    [formatter release];
	//end added
	//NSDate *todayZero = [self dateFromString:[NSString stringWithFormat:@"%@ 00:00:00",todayYMD] withFormatString:strFormat2];
	//yesterday is leak: find_ leak
	NSDate *yesterday = [[[NSDate alloc] initWithTimeInterval:-24*3600 sinceDate:todayZero] autorelease];
	NSString *yesterdayYMD = [self stringDateByFormatString:strFormat withDate:yesterday];
	if ([dateYMD isEqualToString:yesterdayYMD]) {//是昨天
		[retStr appendString:@"Yesterday"]; //显示yesterday
		//[retStr appendFormat:@" %@",[self stringDateByFormatString:@"HH:mm" withDate:aDate]]; //显示具体时间
		return retStr;
	}
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	[calendar setFirstWeekday:2];
	NSInteger week = [calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:[NSDate date]];
	NSDate *weekZero = [[[NSDate alloc] initWithTimeInterval:(week -1)*24*(-3600) sinceDate:todayZero] autorelease];
	
	NSTimeInterval regin = [aDate timeIntervalSinceDate:weekZero];
	if (regin >= 0) {//本周内
		switch ((int)((regin/86400)+ 1)) {
			case 1:
				[retStr appendString:@"Mon"];
				break;
			case 2:
				[retStr appendString:@"Tue"];
				break;
			case 3:
				[retStr appendString:@"Wed"];
				break;
			case 4:
				[retStr appendString:@"Thu"];
				break;
			case 5:
				[retStr appendString:@"Fri"];
				break;
			case 6:
				[retStr appendString:@"Sat"];
				break;
			case 7:
				[retStr appendString:@"Sun"];
				break;
			default:
				break;
		}
		//[retStr appendFormat:@" %@",[self stringDateByFormatString:@"HH:mm" withDate:aDate]];
		return retStr;
	}
    else{
		[retStr appendFormat:@"%@",[self stringDateByFormatString:strFormat withDate:aDate]];
    }
	
	return retStr;
}

#pragma mark --根据时间获取相应的日期字符串
/*
 1:今天的显示为 小时-分钟 22:30
 2:昨天的显示为 Yesterday
 3:最近7天的显示为 周几 如:Mon Tus
 4:超过7天的显示为 年-月-日 如 12-2-22
 */
+(NSString *)getDateWithWeekFormatSinceNow:(NSDate *)date{
	NSDateFormatter *todayFT = [[[NSDateFormatter alloc] init] autorelease];
    [todayFT setDateFormat:@"hh:mm"];
    NSDateFormatter *thisWeekFT = [[[NSDateFormatter alloc] init] autorelease];
    [thisWeekFT setDateFormat:@"EEE"];
    NSDateFormatter *aWeekAgoFT = [[[NSDateFormatter alloc] init] autorelease];
    [aWeekAgoFT setDateFormat:@"yy-M-d"];
	
    NSDate *now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setTimeZone:[NSTimeZone localTimeZone]];
    NSDateComponents *begin = [cal components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:now];
    [begin setHour:0];
    [begin setMinute:0];
    [begin setSecond:0];
    NSDate *dayBegin = [cal dateFromComponents:begin];
    
    NSTimeInterval space = [now timeIntervalSinceDate:dayBegin];//40000
    NSTimeInterval spDate = -[date timeIntervalSinceNow];//120000
    
    NSString *formatStr;
    if (spDate < space) {//today
        formatStr = [todayFT stringFromDate:date];
    }else {
        spDate -= space;
        NSTimeInterval oneDay = 86400;
        if (spDate <= oneDay) {//Yesterday
            formatStr = NSLocalizedString(@"Yesterday",@"");
        }else if(spDate > oneDay && spDate < 6*oneDay){ //7天以内
            formatStr = [thisWeekFT stringFromDate:date];
        }else{//7天以外
            formatStr = [aWeekAgoFT stringFromDate:date];
        }
    }
    return formatStr;
}

#pragma mark --获取系统当前时间的字符串格式 格式例如yyyy-MM-dd HH:mm:ss:SSS
+ (NSString *) stringDateByFormatString:(NSString *) formatString
{
    NSDateFormatter * dateFromatter=[[NSDateFormatter alloc] init];
    //[dateFromatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFromatter setTimeStyle:NSDateFormatterShortStyle];
    if(formatString!=nil)
    {
        [dateFromatter setDateFormat:formatString];
    }
    NSString * strDate=[dateFromatter stringFromDate:[NSDate date]];
    [dateFromatter release];
    return strDate;
}


#pragma mark --根据指定时间的字符串格式和时间 格式例如yyyy-MM-dd HH:mm:ss:SSS
+ (NSString *) stringDateByFormatString:(NSString *) formatString withDate:(NSDate *)date
{
    NSDateFormatter * dateFromatter=[[NSDateFormatter alloc] init];
    //[dateFromatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFromatter setTimeStyle:NSDateFormatterShortStyle];
    if(formatString!=nil)
    {
        [dateFromatter setDateFormat:formatString];
    }
    NSString * strDate=[dateFromatter stringFromDate:date];
    [dateFromatter release];
    return strDate;
}


//把格式化字符串"Mon, 20 Feb 2012 15:14:13 GMT"转换成对应的日期
+ (NSDate*)dateWithGMTString:(NSString*)aGMTString
{
	if (!aGMTString ||[aGMTString length]<=0) {
		return nil;
	}
	NSString *str =[aGMTString stringByReplacingOccurrencesOfString:@"GMT" withString:@""];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];	
    NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    [dateFormatter setLocale:locale];
	[dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
	NSDate *date = [dateFormatter dateFromString:str];
	[dateFormatter release];
	return date;
}

/*
static NSArray *statusFileName=nil;

+ (NSString *) statusFileNameWithUserStatus:(UserStatus) userStatus
{
    if(nil==statusFileName)
    {
        statusFileName=[[NSArray alloc] initWithObjects:
                        @"online2828.png",
                        @"busy2828.png",
						@"free2828.png",
                        @"leave2828.png",
                        @"comeback2828.png",
						@"meeting2828.png",
						@"offline2828.png",
						nil];
    }
    return [statusFileName objectAtIndex:(int)userStatus];
}

static NSArray *statusModels=nil;

#pragma mark --根据状态获状态实体
+ (StatusModel *) statusModelWithUserStatus:(UserStatus) userStatus
{
    if(nil==statusModels)
    {		
        statusModels=[[NSArray alloc] initWithObjects:
                      [[[StatusModel alloc] initWithFileName:@"online2828.png" andDisplayName:NSLocalizedString(@"Online",nil)] autorelease],
                      [[[StatusModel alloc] initWithFileName:@"busy2828.png" andDisplayName:NSLocalizedString(@"Busy",nil)] autorelease],
					  [[[StatusModel alloc] initWithFileName:@"free2828.png" andDisplayName:NSLocalizedString(@"Free",nil)] autorelease],
                      [[[StatusModel alloc] initWithFileName:@"leave2828.png" andDisplayName:NSLocalizedString(@"Xa",nil)] autorelease],
					  [[[StatusModel alloc] initWithFileName:@"comeback2828.png" andDisplayName:NSLocalizedString(@"Away",nil)] autorelease],
                      [[[StatusModel alloc] initWithFileName:@"meeting2828.png" andDisplayName:NSLocalizedString(@"OnTheMeeting",nil)] autorelease],
					  [[[StatusModel alloc] initWithFileName:@"offline2828.png" andDisplayName:NSLocalizedString(@"Offline",nil)] autorelease],
					  nil];
    }
    return [statusModels objectAtIndex:(int)userStatus];
}
*/
#pragma mark --字符串转换成日期
+(NSDate *)dateFromString:(NSString *)datestring withFormatString:(NSString *)formatString 
{    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    //#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd'T'HH:mm:ss'Z'")
    [formatter setDateFormat:formatString];
    NSDate *date = [formatter dateFromString:datestring];
    [formatter release];
    return date;
}
//把UTC时间转换成本地时间
//+ (NSDate *)localDateFromUTCStr:(NSString *)UTCStr andFormatString:(NSString *)format{
//	
//	NSDate *UTCDate = [XSTestUtils dateFromString:UTCStr withFormatString:@"yyyy-MM-dd'T'HH:mm:ss"];
//	NSString *localDateStr = [XSTestUtils stringDateByFormatString:@"yyyy-MM-dd HH:mm:ss" withDate:UTCDate];
//	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//	[formatter setTimeZone:[NSTimeZone localTimeZone]];
//	[formatter setDateFormat:format];
//	NSDate *localDate =[formatter dateFromString:localDateStr];
//	[formatter release];
//	return localDate;
//}

/*
#pragma mark --显示同步错误结果框
+ (void) showSyncErrorResultMessage:(ReturnCodeModel *)rcm
{
    UIAlertView *alert=[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
	 message:rcm.desc 
	 delegate:nil
	 cancelButtonTitle:NSLocalizedString(@"OK", nil)
	 otherButtonTitles:nil] autorelease];
	 [alert show];
    DDLogError(@"showSyncErrorResultMessage:%@",rcm);
    return;
}
*/

static NSDictionary *faceDic = nil;
static NSDictionary *faceFileNameDic = nil;

+ (NSDictionary*)GetChatFaceDic {
	if (faceDic == nil) {
		faceDic = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chatface" ofType:@"plist"]];
	}
	return faceDic;
}

+ (NSDictionary*)GetChatFaceFileNameDic {
	if (faceFileNameDic == nil) {   
		faceFileNameDic = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chatfacefilename" ofType:@"plist"]];
	}
	return faceFileNameDic;
}


#pragma mark --根据文本消息获取html格式的文本
+ (NSString *) htmlFaceMessageStringWithMessage:(NSString *)msg withSize:(CGSize)divSize
{
    NSRange range=[msg rangeOfString:@"/"];
    
    if(range.location!=NSNotFound)
    {
        NSDictionary *tmpFaceDic = [XSTestUtils GetChatFaceDic];
        NSDictionary *tmpFaceFileNameDic = [XSTestUtils GetChatFaceFileNameDic];
        int count=[[tmpFaceFileNameDic allKeys] count];
        for (int i = 0; i < count; i++) 
        {
            NSString *iStr = [NSString stringWithFormat:@"%d", i];
            NSString *faceStr = (NSString*)[tmpFaceDic objectForKey:iStr];
            NSString *faceFileNameStr = (NSString*)[tmpFaceFileNameDic objectForKey:iStr];
            NSString *strToReplace = [NSString stringWithFormat:@"<img width=20 height=20 src='%@'>", faceFileNameStr];
            /*NSString *tmp=[msg stringByReplacingOccurrencesOfString:faceStr withString:strToReplace];
			 if(tmp!=msg)
			 {//替换了
			 if(divSize->width+20<150)
			 {
			 divSize->width+=16;
			 }
			 msg=tmp;
			 }*/
            msg = [msg stringByReplacingOccurrencesOfString:faceStr withString:strToReplace];
            
        }
    }
    return [NSString stringWithFormat:@"<html><head></head><body style='background-color:transparent;margin:0;Padding:0;'><p>"\
			@"<div style='width:%dpx; height:%dpx; word-break: break-all;line-height:20px;letter-spacing:0px; font-size:15px;'>"\
			@"%@</div></p></body></html>",(int)divSize.width,(int)divSize.height,msg];
}

#pragma mark --根据文件路径获取html格式的图片
+ (NSString *) htmlImageMessageStringWithFileUrl:(NSString *)fileUrl withSize:(CGSize)imageSize
{
    NSString * imgStr= [NSString stringWithFormat:@"<img width=%d height=%d src='%@' />",(int)imageSize.width,(int)imageSize.height, fileUrl];
    return [NSString stringWithFormat:@"<html><head></head><body style='background-color:transparent;margin:0;Padding:0;'>%@</body></html>",imgStr];
}


#pragma mark --根据文件路径获取html格式的视频
+ (NSString *) htmlVideoMessageStringWithFileUrl:(NSString *)fileUrl withSize:(CGSize)videoSize
{
    NSString * imgStr= [NSString stringWithFormat:@"<embed width=%d height=%d src='%@' autostart=false />",(int)videoSize.width,(int)videoSize.height, fileUrl];
    return [NSString stringWithFormat:@"<html><head></head><body style='background-color:transparent;margin:0;Padding:0;'>%@</body></html>",imgStr];
}

#pragma mark --根据SIPURL 获取好友帐号
+ (NSString *) accountStringFromSIPURL:(NSString * )sipUrl
{
    NSRange rang1= [sipUrl rangeOfString:@":"];
    NSRange rang2= [sipUrl rangeOfString:@"@"];
    if(rang1.location==NSNotFound || rang2.location==NSNotFound){return nil;}
    NSRange newRange={rang1.location+1,rang2.location-rang1.location-1};
    NSString *ret=[sipUrl substringWithRange:newRange];
    //DDLogVerbose(@"accountStringFromSIPURL:accountString=%@",ret);
    return ret;
}

//add by zuodd 2011/10/7 begine
#pragma mark --根据JIDURL 获取好友帐号
+ (NSString *) accountStringFromJIDURL:(NSString * )jidUrl
{
    NSRange rang2= [jidUrl rangeOfString:@"@"];
    if(rang2.location==NSNotFound){return jidUrl;}
    NSRange newRange={0,rang2.location};
    NSString *ret=[jidUrl substringWithRange:newRange];
    //DDLogVerbose(@"accountStringFromJIDURL:%@",ret);
    return ret;
}

/*
+ (IMType)imTypeFromJIDURL:(NSString*)jidUrl
{
    if ([jidUrl rangeOfString:@"MSN" options:NSCaseInsensitiveSearch].location != NSNotFound) 
    {
        return kIMTypeMSN;
    }
    else if ([jidUrl rangeOfString:@"Google" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        return kIMTypeGtalk;
    }
    else if ([jidUrl rangeOfString:RCS_IM_DOMAIN options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        return kIMTypeXChat;
    }
    else if ([jidUrl rangeOfString:@"msisdn" options:NSCaseInsensitiveSearch].location != NSNotFound ||
             [jidUrl rangeOfString:@"mms" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        return kIMTypeMMS;
    }
	else if ([jidUrl rangeOfString:@"sms" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        return kIMTypeSMS;
    }
	else if ([jidUrl rangeOfString:@"vms" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        return kIMTypeVMS;
    }
	else if ([jidUrl rangeOfString:@"facebook" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        return kIMTypeFacebook;
    }
	else if ([jidUrl rangeOfString:@"vkontakte" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        return kIMTypeVK;
    }
	else if ([jidUrl rangeOfString:@"odnoklassniki" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        return kIMTypeOD;
    }
	else if ([jidUrl rangeOfString:@"mailru" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        return kIMTypeMailru;
    }
	else if ([jidUrl rangeOfString:@"multifon" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        return kIMTypeMultifon;
    }
    else 
    {
        return kIMTypeUndefine;
    }
}
*/

#pragma mark --根据文件路径获取文件的大小
+ (NSInteger) fileLengthWithFilePath:(NSString *) filepath
{
    //文件管理器
    NSFileManager * filemanager = [[[NSFileManager alloc]init] autorelease];
    //根据路径查找文件
    if([filemanager fileExistsAtPath:filepath])
    {
        //获取文件属性
        NSDictionary *attributes = [filemanager attributesOfItemAtPath:filepath error:nil];
        //文件大小
        return [[attributes objectForKey:NSFileSize] intValue];
    }
    return 0;
}

/*
+ (MultiMediaType)checkMediaType:(NSString*)fileExtension {
	fileExtension = [fileExtension uppercaseString];
	static NSSet *photoSet;
	static NSSet *videoSet;
	photoSet = [[NSSet alloc] initWithObjects:@"PNG", @"JPEG", @"GIF", @"BMP", @"JPG",nil];
	videoSet = [[NSSet alloc] initWithObjects:@"MOV", @"MP4", @"M4V", @"AVI", nil];
	
	if ([photoSet containsObject:fileExtension]) {
		return kMultiMediaTypePhoto;
	}
	
	if ([videoSet containsObject:fileExtension]) {
		return kMultiMediaTypeVideo;
	}
	
	return kMultiMediaTypeUnknown;
}

#pragma mark -- 根据httm标志字符串获取文件类型 image/png
+ (MultiMediaType)mediaTypeWithFileTypeString:(NSString*)fileType
{
    if([fileType rangeOfString:@"image" options:NSCaseInsensitiveSearch].location!=NSNotFound)
    {
        return kMultiMediaTypePhoto;
    }
    if([fileType rangeOfString:@"application/octet-stream" options:NSCaseInsensitiveSearch].location!=NSNotFound)
    {
        return kMultiMediaTypeVideo;
    }
    return kMultiMediaTypeUnknown;
}



#pragma mark -- asset-library://， 把照片库里面的文件保存到特定目录下,返回完整路径，包括文件名
+ (NSString*)writeMediaInAssetLibrary:(NSString*)assetPath toDest:(NSString*)destDirectory {
	NSRange range = [assetPath rangeOfString:@"ext="];
	NSString *fileExtension = [assetPath substringFromIndex:range.location+range.length];
	DDLogVerbose(@"%@", fileExtension);
	NSString *destFilePath = [destDirectory stringByAppendingFormat:@"/%@.%@",
							  [XSTestUtils stringDateByFormatString:@"yyyyMMddHHmmssSSS"], fileExtension];
	
	ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
	{
		ALAssetRepresentation *defaultRep = [myasset defaultRepresentation];
		Byte *buffer = (Byte*)malloc(defaultRep.size);
		NSUInteger buffered = [defaultRep getBytes:buffer fromOffset:0.0 length:defaultRep.size error:nil];
		NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
		if ([data writeToFile:destFilePath atomically:YES]) {
			DDLogVerbose(@"%@", @"write media success");
		} else {
			DDLogVerbose(@"%@", @"write media error");
		}
	};
	ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
	{
		DDLogVerbose(@"%@", @"Fail to read image from ALAssetsLibrary");
		
	};
	
	NSURL *assetURL = [NSURL URLWithString:assetPath];
	ALAssetsLibrary* assetslibrary = [[[ALAssetsLibrary alloc] init] autorelease];
	[assetslibrary assetForURL:assetURL 
				   resultBlock:resultblock
				  failureBlock:failureblock];
	return destFilePath;
}
#pragma mark -- 把图片，视频存入照片库，assetLibPath为存入后得到的路径 assets-library://...
+ (void)saveMediaToAssetLibrary:(NSString*)mediaFilePath assetLibPath:(NSString**)assetLibPath {
	ALAssetsLibrary *assetslibrary = [[[ALAssetsLibrary alloc] init] autorelease];
	NSString *fileExtension = [mediaFilePath pathExtension];
	if ([XSTestUtils checkMediaType:fileExtension] == kMultiMediaTypePhoto) {
		//write video
		UIImage *img = [UIImage imageWithContentsOfFile:mediaFilePath];
		[assetslibrary writeImageToSavedPhotosAlbum:img.CGImage 
										orientation:ALAssetOrientationUp 
									completionBlock:^(NSURL *assetURL, NSError *error){
										*assetLibPath = [assetURL description];
										DDLogVerbose(@"assetLibPath %", assetLibPath);
									}];
	} else if ([XSTestUtils checkMediaType:fileExtension] == kMultiMediaTypeVideo) {
		//write image
		NSURL *url = [NSURL URLWithString:mediaFilePath];
		if ([assetslibrary videoAtPathIsCompatibleWithSavedPhotosAlbum:url]) {
			[assetslibrary writeVideoAtPathToSavedPhotosAlbum:url 
											  completionBlock:^(NSURL *assetURL, NSError *error) {
												  *assetLibPath = [assetURL description];
												  DDLogVerbose(@"assetLibPath %", assetLibPath);
											  }];
		}
	} else {
		return;
	}
}


#pragma mark --根据会话功能类型获取会话ID
+ (NSString *) sessionIDStringWithMSRPSessionType:(MSRPSessionType)type
{
    switch(type)
    {
        case kMSRPSessionTypeChatRoom:
        {
            return [NSString stringWithFormat:@"CHATROOM-%@",[XSTestUtils stringDateByFormatString:@"YYYYMMDDHHmmssSSS"]];
        }
        case kMSRPSessionTypeIMFile:
        {
            return [NSString stringWithFormat:@"IMFILE-%@",[XSTestUtils stringDateByFormatString:@"YYYYMMDDHHmmssSSS"]];
        }
        case kMSRPSessionTypeDialFile:
        {
            return [NSString stringWithFormat:@"DIALFILE-%@",[XSTestUtils stringDateByFormatString:@"YYYYMMDDHHmmssSSS"]];
        }
        case kMSRPSessionTypeDialAudio:
        {
            return [NSString stringWithFormat:@"DIALAUDIO-%@",[XSTestUtils stringDateByFormatString:@"YYYYMMDDHHmmssSSS"]];
        }
        case kMSRPSessionTypeDialVideo:
        {
            return [NSString stringWithFormat:@"DIALVIDEO-%@",[XSTestUtils stringDateByFormatString:@"YYYYMMDDHHmmssSSS"]];
        }
    }
    return nil;
}

#pragma mark --根据会话ID获取此会话的功能类型
+ (MSRPSessionType) sessionTypeWithSessionIDString:(NSString *)sessionID
{
    NSRange range=[sessionID rangeOfString:@"CHATROOM-"];
    if(NSNotFound!=range.location)
    {
        return kMSRPSessionTypeChatRoom;
    }
    
    range=[sessionID rangeOfString:@"IMFILE-"];
    if(NSNotFound!=range.location)
    {
        return kMSRPSessionTypeIMFile;
    }
	
    range=[sessionID rangeOfString:@"DIALFILE-"];
    if(NSNotFound!=range.location)
    {
        return kMSRPSessionTypeDialFile;
    }
    
    range=[sessionID rangeOfString:@"DIALAUDIO-"];
    if(NSNotFound!=range.location)
    {
        return kMSRPSessionTypeDialAudio;
    }
    
    range=[sessionID rangeOfString:@"DIALVIDEO-"];
    if(NSNotFound!=range.location)
    {
        return kMSRPSessionTypeDialVideo;
    }
    
    return kMSRPSessionTypeNONE;
    
}
*/
#pragma mark -- 等比例压缩图片
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
	UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
	
    return newImage;
}

static UIImage * portraitImage=nil;
#pragma mark --获取系统默认的头像图片
+ (UIImage *) defaultPortraitImage
{
    if(nil==portraitImage)
    {
        portraitImage=[[UIImage imageNamed:@"onebox_contact_face.png"] retain];
    }
    return portraitImage;
    
}
static UIImage *MixUMSImage = nil;
#pragma mark --获取UMS默认的头像图片
+ (UIImage *)defaultMixUMSImage{
	if (nil == MixUMSImage) {
		MixUMSImage = [[UIImage imageNamed:@"onebox_ums.png"] retain];
	}
	return MixUMSImage;
}
static UIImage *MixMailImage = nil;
#pragma mark --获取白名单通知默认的头像图片
+ (UIImage *)defaultMixMailImage{
	if (nil == MixMailImage) {
		MixMailImage = [[UIImage imageNamed:@"onebox_mail.png"] retain];
	}
	return MixMailImage;
}
static UIImage *MixAssistantImage = nil;
#pragma mark --获取小秘书默认的头像图片
+ (UIImage *)defaultMixAssistantImage{
	if (nil == MixAssistantImage) {
		MixAssistantImage = [[UIImage imageNamed:@"onebox_ic_.png"] retain];
	}
	return MixAssistantImage;
}

static UIImage *sampleImage = nil;
#pragma mark --获取小秘书默认的头像图片
+ (UIImage *)samlpeImage
{
	if (nil == sampleImage)
    {
		sampleImage = [[UIImage imageNamed:@"MM.jpg"] retain];
	}
	return sampleImage;
}

#pragma mark -- HTTP操作是否成功
+ (BOOL)isSuccessHttpReturnCode:(NSInteger)retCode {
	if (retCode > 199 && retCode < 300) {
		return YES;
	}
	return NO;
}
#pragma mark -- 填充导航栏标题
+ (UILabel *)navigationTitleWithString:(NSString *)title{
	
	//modify by zhangss 2011-10-21
	//	CGSize newSize = [title sizeWithFont:[UIFont boldSystemFontOfSize:18.0]];
	//	
	//	CGRect newRect;
	//	newRect.size = newSize;
	//	newRect.origin = CGPointMake(0, 0);
	
	UILabel *lab = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
	lab.backgroundColor = [UIColor clearColor];
	lab.text = title;
	[lab labelWithType:kNavigationTitle];
	
	CGSize newSize = [title sizeWithFont:lab.font];
	CGRect newRect;
	newRect.size = newSize;
	newRect.origin = CGPointMake(0, 0);
	lab.frame = newRect;
	
	return lab;
}
+ (UIImage *)scaleFromImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UILabel *)cellPreString:(NSString *)str
{
	//modify by zhangss 2011-10-27 根据字体修改框架
	/*
	 CGRect rect;
	 rect.size = [str sizeWithFont:[UIFont boldSystemFontOfSize:15]];
	 rect.origin = CGPointMake(10, 10);
	 UILabel *lab = [[[UILabel alloc] initWithFrame:rect] autorelease];
	 lab.text = str;
	 lab.backgroundColor = [UIColor clearColor];
	 [lab labelWithType:kLabelName1];
	 */
	
	UILabel *lab = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
	lab.text = str;
	lab.backgroundColor = [UIColor clearColor];
	[lab labelWithType:kLabelName1];
	CGRect rect;
	rect.size = [str sizeWithFont:lab.font];
	rect.origin = CGPointMake(10, 10);
	lab.frame = rect;
	return lab;
}
+ (UILabel *)cellPreStringOnebox:(NSString *)str
{
	//modify by zhangss 2011-10-27 根据字体修改框架
	/*
	 CGRect rect;
	 rect.size = [str sizeWithFont:[UIFont systemFontOfSize:15]];
	 rect.origin = CGPointMake(10, 10);
	 UILabel *lab = [[[UILabel alloc] initWithFrame:rect] autorelease];
	 lab.text = str;
	 lab.backgroundColor = [UIColor clearColor];
	 [lab labelWithType:kDescription];
	 */
	UILabel *lab = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
	lab.text = str;
	lab.backgroundColor = [UIColor clearColor];
	[lab labelWithType:kSectionHeaderTitle];
	CGRect rect;
	rect.size = [str sizeWithFont:lab.font];
	rect.origin = CGPointMake(10, 10);
	lab.frame = rect;
	return lab;
}
+ (UILabel *)cellPreString:(NSString *)str withCellHeight:(float)height
{
	//modify by zhangss 2011-10-27 根据字体修改框架
	/*
	 CGRect rect;
	 rect.size = [str sizeWithFont:[UIFont boldSystemFontOfSize:15]];
	 rect.origin = CGPointMake(10, (height-rect.size.height)/2);
	 UILabel *lab = [[[UILabel alloc] initWithFrame:rect] autorelease];
	 lab.text = str;
	 lab.backgroundColor = [UIColor clearColor];
	 [lab labelWithType:kLabelName1];
	 */
	UILabel *lab = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
	lab.text = str;
	lab.backgroundColor = [UIColor clearColor];
	[lab labelWithType:kLabelName1];
	CGRect rect;
	rect.size = [str sizeWithFont:lab.font];
	rect.origin = CGPointMake(10, (height-rect.size.height)/2);
	lab.frame = rect;
	return lab;
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
	UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
	[image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return scaledImage;
}
#pragma mark -- Base64编码字符串
+ (NSString *)base64Encode:(NSString *)plainText
{
	NSData *plainTextData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
	NSString *base64String = [plainTextData base64EncodedString];
	return base64String;
}
#pragma mark -- 解码Base64字符串
+ (NSString *)base64Decode:(NSString *)base64String
{
	NSData *plainTextData = [NSData dataFromBase64String:base64String];
	NSString *plainText = [[[NSString alloc] initWithData:plainTextData encoding:NSUTF8StringEncoding] autorelease];
	return plainText;
}
#pragma mark -- 获取当前语言
+(NSString *)getCurrentLanguage{
	/*ru:俄文 en:英文 zh-Hans:中文*/
	NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
	NSArray* languages = [defs objectForKey:@"AppleLanguages"];
	return [NSString stringWithFormat:@"%@",[languages objectAtIndex:0]];
}								 
#pragma mark --邮件最大内容长度和主题长度
+(NSInteger)email_Max_Content{
	
	//由于未提出需求  只给出默认值
	return 1000;
}
+(NSInteger)email_Max_Subject{
	
	//由于未提出需求  只给出默认值
	return 80;
}
#pragma mark --彩信最大内容长度和主题长度
+(NSInteger)mms_Max_Content{
	
	//由于未提出需求  只给出默认值
	return 1000;
}
+(NSInteger)mms_Max_Subject{
	
	//由于未提出需求  只给出默认值
	return 80;
}
#pragma mark --短信最大内容长度和主题长度
+(NSInteger)sms_Max_Content{
	
	//要根据语言来判断 长度大小
	NSString *curLanguage = [XSTestUtils getCurrentLanguage];
	if ([curLanguage isEqualToString:@"zh-Hans"]) {
		return 140;
	}
	else if([curLanguage isEqualToString:@"en"]){
		return 280;
	}
	else {
		return 280;
	}
}
+(NSInteger)sms_Max_Subject{
	
	//由于未提出需求  只给出默认值
	return 80;
}

#pragma mark --获取签名长度(最大值)   中文60  英文120  其他120
+(NSInteger)maxLengthOfSignature{
	
	NSString *curLanguage = [XSTestUtils getCurrentLanguage];
	if ([curLanguage isEqualToString:@"zh-Hans"]) {
		return 60;
	}
	else if([curLanguage isEqualToString:@"en"]){
		return 120;
	}
	else {
		return 120;
	}
}

#pragma mark --获取自动回复长度(最大值) 中文70 英文140  其他140
+(NSInteger)maxLengthOfAutoReply{
	
	NSString *curLanguage = [XSTestUtils getCurrentLanguage];
	if ([curLanguage isEqualToString:@"zh-Hans"]) {
		return 70;
	}
	else if([curLanguage isEqualToString:@"en"]){
		return 140;
	}
	else {
		return 140;
	}
}

+ (NSString*)stringValueWithString:(NSString*)content name:(NSString*)name
{
	if ([content length] == 0 || [name length] == 0) {
		return nil;
	}
	
	NSRange range = [content rangeOfString:name options:NSCaseInsensitiveSearch];
	if(range.length == 0)
	{
		return nil;
	}
	
	NSRange rangeStart =  [content rangeOfString:@"\""];
	NSRange rangeEnd =  [content rangeOfString:@"\"" options:NSBackwardsSearch];
	if (rangeStart.length == 0 || NSEqualRanges(rangeStart , rangeEnd)) {
		return nil;
	}
	else {
		return  [content substringWithRange:NSMakeRange(NSMaxRange(rangeStart), rangeEnd.location - NSMaxRange(rangeStart))];
	}
}
#pragma mark --当进行网络操作的时候在Window上呈现的"菊花"
+(UIView *)showIndicatorWhenOperateNetwork
{
	UIView *bgView = [[[UIView alloc]initWithFrame:
					   CGRectMake(0, 0, 320, 460)] autorelease];
	bgView.backgroundColor = [UIColor clearColor];
	//bgView.alpha = 0.6;
	UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:
												  CGRectMake(0, 0, 32, 32)];
	activityIndicator.center = bgView.center;
	[activityIndicator startAnimating];
	[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
	[bgView addSubview:activityIndicator];
	[activityIndicator release];
	return bgView;
}

//add by zuodd 2011/10/3 begine
#pragma mark --根据RCSAccount生成jidString
+ (NSString *)jidStringFromRCSAccount:(NSString*)account
{
    return [NSString stringWithFormat:@"%@@%@", account, RCS_IM_DOMAIN];
}
//end


#pragma mark --判断snsfeeddata数据中的时间离当前时间的差值
+(NSString*)showTimeIntervalSinceNow:(NSDate*)curdate{
	
    
	NSString *intervalSTR=@"";
	
	
	NSTimeInterval Interval=[[NSDate date] timeIntervalSinceDate:curdate];
	
	
	if (Interval/60<1) {
		intervalSTR = [NSString stringWithFormat:@"%.f", Interval/60];
		intervalSTR=[NSString stringWithFormat:@"%@ second ago", intervalSTR];
	}else if (Interval/3600<1) {
        intervalSTR = [NSString stringWithFormat:@"%.f", Interval/3600];
        intervalSTR=[NSString stringWithFormat:@"%@ minutes", intervalSTR];
        
    }else if (Interval/3600>1 && Interval/86400<1) {
        intervalSTR = [NSString stringWithFormat:@"%.f", Interval/3600];
        intervalSTR=[NSString stringWithFormat:@"%@小时前", intervalSTR];
    }else if (Interval/86400>1)
    {
        intervalSTR = [NSString stringWithFormat:@"%.f", Interval/86400];
        intervalSTR=[NSString stringWithFormat:@"%@天前", intervalSTR];
        
    }
	
	return intervalSTR;
}

//过滤html标签
+ (NSString *)flattenHTML:(NSString *)info{
	
    NSScanner *thescanner;
    NSString *text = nil;
	
    thescanner = [NSScanner scannerWithString:info];
	
    while ([thescanner isAtEnd] == NO) {
		
        // find start of tag
        [thescanner scanUpToString:@"<" intoString:NULL] ; 
		
        // find end of tag
        [thescanner scanUpToString:@">" intoString:&text] ;
		
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        info = [info stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "];
		
    } // while //
    
    return info;
	
}


#pragma mark -- 创建向sessionModelManager类抛出的消息的info
//
//创建向sessionModelManager类抛出的消息的info
//imType 为IMType的NSNumber类型的封装,消息的来源类型，gtalk等；
//msgBodyType为消息内容的类型
//msgType为消息的类型：邀请，和普通消息
/*
 typedef enum {
 kSenderTypeByMe = 1,
 kSenderTypeByAnother = 2,
 kSenderTypeBySystem=3
 }SenderType;
 
 typedef enum {
 kMsgBodyTypeString = 1,
 kMsgBodyTypeImage = 2,
 kMsgBodyTypeAudioVideo = 3
 }MsgBodyType;
 
 typedef enum {
 kMsgTypeInvite = 1,
 kMsgTypeMessage = 2
 }MsgType;
 
 //消息发送类型,用于区分IM模块中是直接发送消息，还是发送到对方手机上
 typedef enum {
 kMsgTypeIM = 1,		//发送RSC消息
 kMsgTypeSMS = 2,		//SMS消息
 kMsgTypeMMS = 3       //MMS消息
 }ChatState;					//用于IM和SMS之间的切换
 */
+(NSDictionary *)dictionaryForSessionModelManagerWithMsgBody:(NSString *)msgBody 
											  attachmentPath:(NSString *)attachmentPath 
													 msgFrom:(NSString *)msgFrom 
													  imType:(NSNumber*)imType
												 msgBodyType:(NSNumber*)msgBodyType
													 msgType:(NSNumber*)msgType
                                                     msgTime:(NSDate *)aMsgTime
{
	if (!attachmentPath) {
		attachmentPath = @"";
	}
	if (!msgBody) {
		msgBody = @"";
	}
	if (!msgFrom) {
		msgFrom = @"";
	}
    
	NSDictionary *sessionModelInfo = [[[NSDictionary alloc] initWithObjectsAndKeys:
                                       msgBody,    @"msgBody",
                                       attachmentPath,   @"attachmentPath", //附件信息
                                       msgFrom,    @"msgFrom",
                                       imType,     @"imType",
                                       msgBodyType,@"msgBodyType",
                                       msgType,    @"msgType",
                                       aMsgTime,   @"msgTime",
                                       nil] autorelease];
	return sessionModelInfo;
}


//
//move文件到IMMedia目录下
+(NSString *)moveFileToImMediaFile:(NSString *)fromPath{
	NSString *absoluteFilePath = [[XSTestUtils IMMideaFilePath] stringByAppendingPathComponent:[fromPath lastPathComponent]];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if ([fileManager fileExistsAtPath:fromPath]) {
        if ([fileManager moveItemAtPath:fromPath toPath:absoluteFilePath error:nil]) {
            return absoluteFilePath;
        }else {
            return nil;
        }
        
	}else {
		return nil;
	}	
}


+ (NSDate *) toLocalTime:(NSDate * )aDate
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: aDate];
    return [NSDate dateWithTimeInterval: seconds sinceDate: aDate];
}

+ (NSDate *) toGlobalTime:(NSDate * )aDate
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = -[tz secondsFromGMTForDate: aDate];
    return [NSDate dateWithTimeInterval: seconds sinceDate: aDate];
}

#pragma mark - 
#pragma mark 获取控件大小
/*
 本方法根据View的文字及View的字体大小计算View应有的size
 主要针对UILabel和UITextView.
 */
+ (CGRect)getControlSizeWithControl:(UIView *)aView andIsWidthKnown:(BOOL)isWithKnown
{
    CGRect viewRect = aView.frame;
    if ([aView isKindOfClass:[UILabel class]])
    {
        UILabel *aLabel = (UILabel *)aView;
        if (isWithKnown)
        {
            viewRect.size = [aLabel.text sizeWithFont:aLabel.font forWidth:aLabel.frame.size.width lineBreakMode:aLabel.lineBreakMode];
        }
        else
        {
            viewRect.size = [aLabel.text sizeWithFont:aLabel.font];
        }
    }
    else if ([aView isKindOfClass:[UITextView class]])
    {
        //不知道怎么写了
//        UITextView *aTextView = (UITextView *)aView;
//        if (isWithKnown)
//        {
//            viewSzie = [aTextView.text sizeWithFont:aTextView.font forWidth:aTextView.frame.size.width lineBreakMode:aTextView.];
//        }
//        else
//        {
//            viewSzie = [aTextView.text sizeWithFont:aTextView.font];
//        }
    }
    return  viewRect;
}


@end

