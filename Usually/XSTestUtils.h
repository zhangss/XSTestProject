//
//  XSTestUtils.h
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


/*统一的常用方法函数 工程中常用的方法或者其他通用方法
 ‘+’是类方法 要通过XSTestUtils调用
 1.文件读写操作方法
 2.时间格式转换方法
 3.图片处理方法
 */

@interface XSTestUtils : NSObject {
	
}

#pragma mark -
#pragma mark 1.1文件及路径操作--沙盒

//获取document路径
+ (NSString *) documentPath;

//获取数据文件路径,即documen路径和数据文件路径的组合
+ (NSString *) dataFilePath:(NSString*)name;

#pragma mark -
#pragma mark 1.2文件及路径操作--Resources目录下

#pragma mark -
#pragma mark 获取视频第一帧图片
+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;


//应用程序保存媒体文件路径
+ (NSString *) appMediaFilePath;

#pragma mark 获取IM文件保存的目录
+(NSString *)IMMideaFilePath;

#pragma mark 根据路径创建对应的目录
+ (BOOL) createPathWithFilePath:(NSString *) filePath;

#pragma mark 创建im的多媒体文件存放目录
+(NSString *)createIMMediaFile;

#pragma mark -- 根据文件扩展名生成一个新文件名
+ (NSString *)fileNameWithExtension:(NSString*)extension;

+ (NSString *)getNewAttachmentFileName:(NSString*)extension;
#pragma mark -- 在SNS目录下放一个头像图片
+ (NSString *)getNewSNSHeadImageFileName:(NSString *)fileName;

+ (NSString *)getNewTempFileName:(NSString*)extension;

#pragma mark -- 根据媒体文件名称，获取应用程序媒体全路径
+ (NSString *) appMediaFilePathForFileName:(NSString *)fileName;

#pragma mark -- 保存对象到指定文件
+ (void) saveObjectToFile:(id)obj key:(NSString *) fileName;

#pragma mark -- 从对象文件读取数据到对象中
+ (id) loadObjectFromFile:(NSString *) fileName;

#pragma mark -- 保存图片到指定png文件
//返回保存成功的路径
+ (NSString *) saveImageToPNGFile:(UIImage *) image fileName:(NSString *)fileName;

//保存图片到指定png文件
//返回保存成功的路径
+ (NSString *) saveImageToPNGFileByImage:(UIImage *) image;
+ (NSString *) saveImageToPNGFileToTmpPath:(UIImage *)image;

#pragma mark -- 移出本地缓存图片
+(BOOL)deleteImageFileByPath:(NSString*)path;

//保存图片到指定png文件
//返回文件名
+ (NSString *) saveImageToPNGFileByImageExt:(UIImage *) image;

#pragma mark -
#pragma mark 2.时间装换操作
#pragma mark -- 根据时间获取相应的日期字符串(今天,昨天,星期XXX)
+(NSString *)weekStringByUTCDate:(NSDate *)aDate;

#pragma mark -- 根据时间获取相应的日期字符串(今天,昨天,星期XXX) 没有今天的格式
+(NSString *)weekStringByUTCDateWithoutToday:(NSDate *)aDate;

#pragma mark --根据时间获取相应的日期字符串
+(NSString *)getDateWithWeekFormatSinceNow:(NSDate *)date;

#pragma mark -- 获取系统当前时间的字符串格式 格式例如yyyy-MM-dd HH:mm:ss:SSS
+ (NSString *) stringDateByFormatString:(NSString *) formatString;

#pragma mark -- 根据指定时间的字符串格式和时间 格式例如yyyy-MM-dd HH:mm:ss:SSS
+ (NSString *) stringDateByFormatString:(NSString *) formatString withDate:(NSDate *)date;

//把格式化字符串"Mon, 20 Feb 2012 15:14:13 GMT"转换成对应的日期
+ (NSDate*)dateWithGMTString:(NSString*)aGMTString;

#pragma mark -- 通过用户状态获取状态
//+ (NSString *) statusFileNameWithUserStatus:(UserStatus) userStatus;

#pragma mark -- 根据用户状态获状态实体
//+ (StatusModel *) statusModelWithUserStatus:(UserStatus) userStatus;

#pragma mark -- 字符串转换成日期
+ (NSDate *)dateFromString:(NSString *)datestring withFormatString:(NSString *)formatString;

#pragma mark -- 把UTC时间转换成本地时间
//+ (NSDate *)localDateFromUTCStr:(NSString *)UTCStr andFormatString:(NSString *)format;

#pragma mark -- 显示同步错误结果框
//+ (void) showSyncErrorResultMessage:(ReturnCodeModel *)rcm;

#pragma mark -- 根据文本消息获取html格式的表情文本
+(NSString *) htmlFaceMessageStringWithMessage:(NSString *)msg withSize:(CGSize)divSize;

#pragma mark -- 根据文件路径获取html格式的图片
+ (NSString *) htmlImageMessageStringWithFileUrl:(NSString *)fileUrl withSize:(CGSize)imageSize;

#pragma mark -- 根据文件路径获取html格式的视频
+ (NSString *) htmlVideoMessageStringWithFileUrl:(NSString *)fileUrl withSize:(CGSize)videoSize;

#pragma mark -- 获取转义符字典
+ (NSDictionary*)GetChatFaceDic;
#pragma mark -- 获取转义符对应名称的字典
+ (NSDictionary*)GetChatFaceFileNameDic;

#pragma mark -- 根据SIPURL 获取好友帐号
+ (NSString *) accountStringFromSIPURL:(NSString * )sipUrl;

//add by zuodd 2011/10/3 begine
#pragma mark -- 根据JIDURL 获取好友帐号
+ (NSString *) accountStringFromJIDURL:(NSString * )jidUrl;
#pragma mark -- 根据JIDURL 获得IM类型
//+ (IMType)imTypeFromJIDURL:(NSString*)jidUrl;
#pragma mark -- 根据RCSAccount生成jidString
+ (NSString *)jidStringFromRCSAccount:(NSString*)account;

//end

#pragma mark -- 根据文件路径获取文件的大小
+ (NSInteger) fileLengthWithFilePath:(NSString *) filepath;


#pragma mark -- 根据扩展名检查文件类型
//+ (MultiMediaType)checkMediaType:(NSString*)fileExtension;

#pragma mark -- 根据httm标志字符串获取文件类型 image/png video unknown 
//+ (MultiMediaType)mediaTypeWithFileTypeString:(NSString*)fileType;


#pragma mark -- asset-library://， 把照片库里面的文件保存到特定目录下,返回完整路径，包括文件名
//+ (NSString*)writeMediaInAssetLibrary:(NSString*)assetPath toDest:(NSString*)destDirectory;


#pragma mark -- 把图片，视频存入照片库，assetLibPath为存入后得到的路径 assets-library://...
//+ (void)saveMediaToAssetLibrary:(NSString*)mediaFilePath assetLibPath:(NSString**)assetLibPath;

#pragma mark -- 根据会话功能类型获取会话ID
//+ (NSString *) sessionIDStringWithMSRPSessionType:(MSRPSessionType)type;

#pragma mark -- 根据会话ID获取此会话的功能类型
//+ (MSRPSessionType) sessionTypeWithSessionIDString:(NSString *)sessionID;

#pragma mark -- 等比例压缩图片
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

#pragma mark -- 获取系统默认的头像图片
+ (UIImage *) defaultPortraitImage;

#pragma mark --获取UMS默认的头像图片
+ (UIImage *)defaultMixUMSImage;

#pragma mark --获取白名单通知默认的头像图片
+ (UIImage *)defaultMixMailImage;

#pragma mark --获取小秘书默认的头像图片
+ (UIImage *)defaultMixAssistantImage;

+ (UIImage *)samlpeImage;

#pragma mark -- HTTP操作是否成功
+ (BOOL)isSuccessHttpReturnCode:(NSInteger)retCode;

#pragma mark -- 填充导航栏标题
+ (UILabel *)navigationTitleWithString:(NSString *)title;

#pragma mark -
#pragma mark 3.图片相关的处理
//
+ (UIImage *)scaleImage:(UIImage*)image withMaxArea:(float)area ;
+ (UIImage *)scaleFromImage:(UIImage *)image toSize:(CGSize)size;

+ (UILabel *)cellPreString:(NSString *)str;
+ (UILabel *)cellPreStringOnebox:(NSString *)str;
+ (UILabel *)cellPreString:(NSString *)str withCellHeight:(float)height;
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

#pragma mark -- Base64编码字符串
+ (NSString *)base64Encode:(NSString *)plainText;

#pragma mark -- 解码Base64字符串
+ (NSString *)base64Decode:(NSString *)base64String;

#pragma mark -- 获取当前语言
+(NSString *)getCurrentLanguage;
#pragma mark -- 邮件最大内容长度和主题长度
+(NSInteger)email_Max_Content;
+(NSInteger)email_Max_Subject;
#pragma mark -- 彩信最大内容长度和主题长度
+(NSInteger)mms_Max_Content;
+(NSInteger)mms_Max_Subject;
#pragma mark -- 短信最大内容长度和主题长度
+(NSInteger)sms_Max_Content;
+(NSInteger)sms_Max_Subject;

#pragma mark -- 获取签名长度(最大值)
+(NSInteger)maxLengthOfSignature;
#pragma mark -- 获取自动回复长度(最大值)
+(NSInteger)maxLengthOfAutoReply;

+ (NSString*)stringValueWithString:(NSString*)content name:(NSString*)name;

#pragma mark -- 当进行网络操作的时候在Window上呈现的"菊花"
+(UIView *)showIndicatorWhenOperateNetwork;

#pragma mark -- 判断snsfeeddata数据中的时间离当前时间的差值
+(NSString*)showTimeIntervalSinceNow:(NSDate*)curdate;

#pragma mark -- 过滤html标签
+ (NSString *)flattenHTML:(NSString *)info;

#pragma mark -- 创建向sessionModelManager类抛出的消息的info
+(NSDictionary *)dictionaryForSessionModelManagerWithMsgBody:(NSString *)msgBody 
											  attachmentPath:(NSString *)attachmentPath 
													 msgFrom:(NSString *)msgFrom 
													  imType:(NSNumber*)imType
												 msgBodyType:(NSNumber*)msgBodyType
													 msgType:(NSNumber*)msgType
													 msgTime:(NSDate *)aMsgTime;


//
//move文件到IMMedia目录下
+(NSString *)moveFileToImMediaFile:(NSString *)fromPath;


//把时间转换为本地时间
+ (NSDate *) toLocalTime:(NSDate * )aDate;

//把时间转换为标准时间
+ (NSDate *) toGlobalTime:(NSDate * )aDate;

+ (CGRect)getControlSizeWithControl:(UIView *)aView andIsWidthKnown:(BOOL)isWithKnown;

@end
