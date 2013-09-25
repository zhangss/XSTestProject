    //
//  DateFormatViewController.m
//  XSTestProject
//
//  Created by 张永亮 on 12-10-8.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DateFormatViewController.h"

#define kNSDateLog @"NSDate:"
#define kNSDateTimeInterval 30 
#define kNSLocaleLog @"NSLocale:"

@implementation DateFormatViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"Other",@"")];
    
    //现在的时间格式
    UILabel *timeNowLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)] autorelease];
    timeNowLabel.backgroundColor = [UIColor grayColor];
    timeNowLabel.textColor = [UIColor blackColor];
    timeNowLabel.textAlignment = UITextAlignmentCenter;
    timeNowLabel.text = [[NSDate date] description];
    timeNowLabel.layer.cornerRadius = 5.0;
    [self.view addSubview:timeNowLabel];
    
    //NSDate
    [self logNSDate];
    
    //NSLocale
    [self logNSLocaleValue:nil];
    

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark -
#pragma mark Methods


#pragma mark -
#pragma mark NSDate
- (void)notifySystemClockDidChange:(NSNotification *)noti
{
    NSLog(@"%@",noti);
}

- (void)logNSDate
{
    /*1.???:不清楚触发方法
     Posted whenever the system clock is changed. 
     This can be initiated by a call to settimeofday() or the user changing values in the Date and Time Preference panel. 
     The notification object is null. 
     This notification does not contain a userInfo dictionary.
     10_6, 4_0
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifySystemClockDidChange:) name:NSSystemClockDidChangeNotification object:nil];
    
    /*
     2.+ (id)date: 
     - (id)init;
     Creates and returns a new date set to the current date and time.
     3.- (NSString *)description;
     A string representation of the receiver in the international format YYYY-MM-DD HH:MM:SS ±HHMM, where ±HHMM represents the time zone offset in hours and minutes from GMT (for example, “2001-03-24 10:45:32 +0600”).
     
     4.- (NSString *)descriptionWithLocale:(id)locale
     A string representation of the receiver, using the given locale, or if the locale argument is nil, in the international format YYYY-MM-DD HH:MM:SS ±HHMM, where ±HHMM represents the time zone offset in hours and minutes from GMT (for example, “2001-03-24 10:45:32 +0600”)
     
     locale
     An NSLocale object.
     If you pass nil, NSDate formats the date in the same way as the description method.
     On Mac OS X v10.4 and earlier, this parameter was an NSDictionary object. If you pass in an NSDictionary object on Mac OS X v10.5, NSDate uses the default user locale—the same as if you passed in [NSLocale currentLocale].
     
     On Mac OS X v10.4 and earlier, localeDictionary is an NSDictionary object containing locale data. To use the user's preferences, you can use [[NSUserDefaults standardUserDefaults] dictionaryRepresentation].
     
     */
    //获取当前时间
    NSDate *date = [NSDate date];
    NSLog(@"%@ + (id)date:%@",kNSDateLog,date);
    
    //获取当前时间
    NSDate *dateInit = [[[NSDate alloc] init] autorelease];
    NSLog(@"%@ - (id)init:%@",kNSDateLog,dateInit);
    
    //时间的描述 String类型 当前Locale
    NSString *dateDescription = [dateInit description];
    NSLog(@"%@ - (NSString *)description:%@",kNSDateLog,dateDescription);
    
    //某个Locale下的时间描述
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *dateDescriptionWithLocale = [dateInit descriptionWithLocale:currentLocale];
    NSLog(@"%@ - (NSString *)descriptionWithLocale:%@ withLocale:%@",kNSDateLog,dateDescriptionWithLocale,currentLocale);
    
    /*
     4.+ (id)dateWithTimeInterval:(NSTimeInterval)seconds sinceDate:(NSDate *)date
       - (id)initWithTimeInterval:(NSTimeInterval)seconds sinceDate:(NSDate *)refDate
     Creates and returns an NSDate object set to a given number of seconds from the specified date.
     
     5.+ (id)dateWithTimeIntervalSince1970:(NSTimeInterval)seconds
       - (id)initWithTimeIntervalSince1970:(NSTimeInterval)seconds
     Creates and returns an NSDate object set to the given number of seconds from the first instant of 1 January 1970, GMT.
     
     This method is useful for creating NSDate objects from time_t values returned by BSD system functions.
     
     6.+ (id)dateWithTimeIntervalSinceNow:(NSTimeInterval)seconds
       - (id)initWithTimeIntervalSinceNow:(NSTimeInterval)seconds
     Creates and returns an NSDate object set to a given number of seconds from the current date and time.
     
     7.+ (id)dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)seconds
       - (id)initWithTimeIntervalSinceReferenceDate:(NSTimeInterval)seconds
     Creates and returns an NSDate object set to a given number of seconds from the first instant of 1 January 2001, GMT.
        
     */
    
    //从某个时间后的若干时间 创建
    NSDate *dateWithTimeInterval = [NSDate dateWithTimeInterval:kNSDateTimeInterval sinceDate:[NSDate date]];
    NSLog(@"%@ + (id)dateWithTimeInterval:%@ withTimeInterval:%d ",kNSDateLog,dateWithTimeInterval,kNSDateTimeInterval);
    
    //从1970年开始后的若干时间 创建
    NSDate *dateWithTimeIntervalSince1970 = [NSDate dateWithTimeIntervalSince1970:kNSDateTimeInterval];
    NSLog(@"%@ + (id)dateWithTimeIntervalSince1970:%@ withTimeInterval:%d",kNSDateLog,dateWithTimeIntervalSince1970,kNSDateTimeInterval);
    
    //从现在开始后的若干时间 创建
    NSDate *dateWithTimeIntervalSinceNow = [NSDate dateWithTimeIntervalSinceNow:kNSDateTimeInterval];
    NSLog(@"%@ + (id)dateWithTimeIntervalSinceNow:%@ withTimeInterval:%d",kNSDateLog,dateWithTimeIntervalSinceNow,kNSDateTimeInterval);
    
    //从参考日期（2001-1-1） 后的若干时间 开始 创建一个date 
    NSDate *dateWithTimeIntervalSinceReferenceDate = [NSDate dateWithTimeIntervalSinceReferenceDate:kNSDateTimeInterval];
    NSLog(@"%@ + (id)dateWithTimeIntervalSinceReferenceDate:%@ WithTimeIntervak:%d",kNSDateLog,dateWithTimeIntervalSinceReferenceDate,kNSDateTimeInterval);
    
    /*
     8.+ (id)distantFuture
     Creates and returns an NSDate object representing a date in the distant future.
     
     You can pass this value when an NSDate object is required to have the date argument essentially ignored. For example, the NSWindow method nextEventMatchingMask:untilDate:inMode:dequeue: returns nil if an event specified in the event mask does not happen before the specified date. You can use the object returned by distantFuture as the date argument to wait indefinitely for the event to occur.
     
     myEvent = [myWindow nextEventMatchingMask:myEventMask untilDate:[NSDate distantFuture] inMode:NSDefaultRunLoopMode dequeue:YES];
     
     9.+ (id)distantPast
     Creates and returns an NSDate object representing a date in the distant past.
     
     You can use this object as a control date, a guaranteed temporal boundary.
     
     10.- (id)dateByAddingTimeInterval:(NSTimeInterval)seconds
     Returns a new NSDate object that is set to a given number of seconds relative to the receiver.
     
     A new NSDate object that is set to seconds seconds relative to the receiver. The date returned might have a representation different from the receiver’s.
     */
    
    //最大的时间 遥远的未来
    NSDate *dateDistantFuture = [NSDate distantFuture];
    NSLog(@"%@ + (id)distantFuture:%@",kNSDateLog,dateDistantFuture);
    
    //最小的时间 
    NSDate *dateDistantPast = [NSDate distantPast];
    NSLog(@"%@ + (id)distantPast:%@",kNSDateLog,dateDistantPast);
    
    //从指定时间开始 添加若干时间 创建date
    NSDate *dateByAddingTimeInterval = [[NSDate date] dateByAddingTimeInterval:kNSDateTimeInterval];
    NSLog(@"%@ - (id)dateByAddingTimeInterval:%@ WithTimeInterval:%d",kNSDateLog,dateByAddingTimeInterval,kNSDateTimeInterval);
    
    /*
     11.+ (NSTimeInterval)timeIntervalSinceReferenceDate
        - (NSTimeInterval)timeIntervalSinceReferenceDate
     Returns the interval between the first instant of 1 January 2001, GMT and the current date and time.
     
     This method is the primitive method for NSDate. If you subclass NSDate, you must override this method with your own implementation for it.
     
     12.- (NSTimeInterval)timeIntervalSince1970
     Returns the interval between the receiver and the first instant of 1 January 1970, GMT.
     
     The interval between the receiver and the reference date, 1 January 1970, GMT. If the receiver is earlier than the reference date, the value is negative.
     
     13.- (NSTimeInterval)timeIntervalSinceDate:(NSDate *)anotherDate
     Returns the interval between the receiver and another given date.
     
     The interval between the receiver and anotherDate. If the receiver is earlier than anotherDate, the return value is negative.
     
     14.- (NSTimeInterval)timeIntervalSinceNow
     Returns the interval between the receiver and the current date and time.
     */
    
    //从系统绝对参考时间到现在的时间间隔
    NSTimeInterval timeIntervalSinceReferenceDate = [NSDate timeIntervalSinceReferenceDate];
    NSLog(@"%@ + (NSTimeInterval)timeIntervalSinceReferenceDate:%f",kNSDateLog,timeIntervalSinceReferenceDate);
    
    //从1970-01-01-0000 到现在的时间间隔
    NSTimeInterval timeIntervalSince1970 = [[NSDate date] timeIntervalSince1970];
    NSLog(@"%@ - (NSTimeInterval)timeIntervalSince1970:%f",kNSDateLog,timeIntervalSince1970);
    
    //从现在到现在的时间间隔
    NSTimeInterval timeIntervalSinceNow = [[NSDate date] timeIntervalSinceNow];
    NSLog(@"%@ - (NSTimeInterval)timeIntervalSinceNow:%f",kNSDateLog,timeIntervalSinceNow);
    
    //从莫个时间到现在的时间间隔
    NSTimeInterval timeIntervalSinceAnotherDate = [[NSDate date] timeIntervalSinceDate:[NSDate date]];
    NSLog(@"%@ - (NSTimeInterval)timeIntervalSinceDate:Now %f",kNSDateLog,timeIntervalSinceAnotherDate);
        
    //NSTimeInterval timeInter
    
    /*
     11.- (NSComparisonResult)compare:(NSDate *)anotherDate
     Returns an NSComparisonResult value that indicates the temporal ordering of the receiver and another given date.
     
     anotherDate
     The date with which to compare the receiver.
     This value must not be nil. If the value is nil, the behavior is undefined and may change in future versions of Mac OS X.
     
     The receiver and anotherDate are exactly equal to each other, NSOrderedSame
     The receiver is later in time than anotherDate, NSOrderedDescending
     The receiver is earlier in time than anotherDate, NSOrderedAscending.
     
     This method detects sub-second differences between dates. If you want to compare dates with a less fine granularity, use timeIntervalSinceDate: to compare the two dates.
     
     12.- (NSDate *)earlierDate:(NSDate *)anotherDate
     Returns the earlier of the receiver and another given date.
     
     The earlier of the receiver and anotherDate, determined using timeIntervalSinceDate:. If the receiver and anotherDate represent the same date, returns the receiver.
     
     13.- (BOOL)isEqualToDate:(NSDate *)anotherDate
     Returns a Boolean value that indicates whether a given object is an NSDate object and exactly equal the receiver.
     
     This method detects sub-second differences between dates. If you want to compare dates with a less fine granularity, use timeIntervalSinceDate: to compare the two dates.
     
     14.- (NSDate *)laterDate:(NSDate *)anotherDate
     Returns the later of the receiver and another given date.
     */
    
    /*
     Constants
     #define NSTimeIntervalSince1970  978307200.0
     
     NSDate provides a constant that specifies the number of seconds from 1 January 1970 to the reference date, 1 January 2001.
     */
}

#pragma mark -
#pragma mark NSLocale
- (void)logNSLocaleValue:(NSLocale *)aLocale
{
    aLocale = [NSLocale currentLocale];
    //怎么生成或者获取local 及 local 合集
    /*
     FOUNDATION_EXPORT NSString * const NSLocaleIdentifier NS_AVAILABLE(10_4, 2_0);		// NSString
     FOUNDATION_EXPORT NSString * const NSLocaleLanguageCode NS_AVAILABLE(10_4, 2_0);	// NSString
     FOUNDATION_EXPORT NSString * const NSLocaleCountryCode NS_AVAILABLE(10_4, 2_0);		// NSString
     FOUNDATION_EXPORT NSString * const NSLocaleScriptCode NS_AVAILABLE(10_4, 2_0);		// NSString
     FOUNDATION_EXPORT NSString * const NSLocaleVariantCode NS_AVAILABLE(10_4, 2_0);		// NSString
     FOUNDATION_EXPORT NSString * const NSLocaleExemplarCharacterSet NS_AVAILABLE(10_4, 2_0);// NSCharacterSet
     FOUNDATION_EXPORT NSString * const NSLocaleCalendar NS_AVAILABLE(10_4, 2_0);		// NSCalendar
     FOUNDATION_EXPORT NSString * const NSLocaleCollationIdentifier NS_AVAILABLE(10_4, 2_0); // NSString
     FOUNDATION_EXPORT NSString * const NSLocaleUsesMetricSystem NS_AVAILABLE(10_4, 2_0);	// NSNumber boolean
     FOUNDATION_EXPORT NSString * const NSLocaleMeasurementSystem NS_AVAILABLE(10_4, 2_0);	// NSString
     FOUNDATION_EXPORT NSString * const NSLocaleDecimalSeparator NS_AVAILABLE(10_4, 2_0);	// NSString
     FOUNDATION_EXPORT NSString * const NSLocaleGroupingSeparator NS_AVAILABLE(10_4, 2_0);	// NSString
     FOUNDATION_EXPORT NSString * const NSLocaleCurrencySymbol NS_AVAILABLE(10_4, 2_0);      // NSString
     FOUNDATION_EXPORT NSString * const NSLocaleCurrencyCode NS_AVAILABLE(10_4, 2_0);	// NSString
     FOUNDATION_EXPORT NSString * const NSLocaleCollatorIdentifier NS_AVAILABLE(10_6, 4_0);  // NSString
     FOUNDATION_EXPORT NSString * const NSLocaleQuotationBeginDelimiterKey NS_AVAILABLE(10_6, 4_0);	// NSString
     FOUNDATION_EXPORT NSString * const NSLocaleQuotationEndDelimiterKey NS_AVAILABLE(10_6, 4_0);	// NSString
     FOUNDATION_EXPORT NSString * const NSLocaleAlternateQuotationBeginDelimiterKey NS_AVAILABLE(10_6, 4_0);	// NSString
     FOUNDATION_EXPORT NSString * const NSLocaleAlternateQuotationEndDelimiterKey NS_AVAILABLE(10_6, 4_0);	// NSString
     
     // Values for NSCalendar identifiers (not the NSLocaleCalendar property key)
     FOUNDATION_EXPORT NSString * const NSGregorianCalendar NS_AVAILABLE(10_4, 2_0);
     FOUNDATION_EXPORT NSString * const NSBuddhistCalendar NS_AVAILABLE(10_4, 2_0);
     FOUNDATION_EXPORT NSString * const NSChineseCalendar NS_AVAILABLE(10_4, 2_0);
     FOUNDATION_EXPORT NSString * const NSHebrewCalendar NS_AVAILABLE(10_4, 2_0);
     FOUNDATION_EXPORT NSString * const NSIslamicCalendar NS_AVAILABLE(10_4, 2_0);
     FOUNDATION_EXPORT NSString * const NSIslamicCivilCalendar NS_AVAILABLE(10_4, 2_0);
     FOUNDATION_EXPORT NSString * const NSJapaneseCalendar NS_AVAILABLE(10_4, 2_0);
     FOUNDATION_EXPORT NSString * const NSRepublicOfChinaCalendar NS_AVAILABLE(10_6, 4_0);
     FOUNDATION_EXPORT NSString * const NSPersianCalendar NS_AVAILABLE(10_6, 4_0);
     FOUNDATION_EXPORT NSString * const NSIndianCalendar NS_AVAILABLE(10_6, 4_0);
     FOUNDATION_EXPORT NSString * const NSISO8601Calendar NS_AVAILABLE(10_6, 4_0);
     */
    
    NSString *localeIdentifier = [aLocale objectForKey:NSLocaleIdentifier];
    NSLog(@"%@ %@",kNSLocaleLog,localeIdentifier);

    NSString *localeLanguageCode = [aLocale objectForKey:NSLocaleLanguageCode];
    NSLog(@"%@ %@",kNSLocaleLog,localeLanguageCode);
    
    NSString *localeCountryCode = [aLocale objectForKey:NSLocaleCountryCode];
    NSLog(@"%@ %@",kNSLocaleLog,localeCountryCode);
    
    NSString *localeScriptCode = [aLocale objectForKey:NSLocaleScriptCode];
    NSLog(@"%@ %@",kNSLocaleLog,localeScriptCode);
    
    NSString *localeVariantCode = [aLocale objectForKey:NSLocaleVariantCode];
    NSLog(@"%@ %@",kNSLocaleLog,localeVariantCode);
    
    NSCharacterSet *localeExemplarCharacterSet = [aLocale objectForKey:NSLocaleExemplarCharacterSet];
    NSLog(@"%@ %@",kNSLocaleLog,localeExemplarCharacterSet);
    
    NSCalendar *localeCalendar = [aLocale objectForKey:NSLocaleCalendar];
    NSLog(@"%@ %@",kNSLocaleLog,localeCalendar);
    
    NSString *localeCollationIdentifier = [aLocale objectForKey:NSLocaleCollationIdentifier];
    NSLog(@"%@ %@",kNSLocaleLog,localeCollationIdentifier);
    
    NSNumber *localeUsesMetricSystem = [aLocale objectForKey:NSLocaleUsesMetricSystem];
    NSLog(@"%@ %@",kNSLocaleLog,localeUsesMetricSystem);
    
    NSString *localeMeasurementSystem = [aLocale objectForKey:NSLocaleMeasurementSystem];
    NSLog(@"%@ %@",kNSLocaleLog,localeMeasurementSystem);
    
    NSString *localeDecimalSeparator = [aLocale objectForKey:NSLocaleDecimalSeparator];
    NSLog(@"%@ %@",kNSLocaleLog,localeDecimalSeparator);
    
    NSString *localeGroupingSeparator = [aLocale objectForKey:NSLocaleGroupingSeparator];
    NSLog(@"%@ %@",kNSLocaleLog,localeGroupingSeparator);
    
    NSString *localeCurrencySymbol = [aLocale objectForKey:NSLocaleCurrencySymbol];
    NSLog(@"%@ %@",kNSLocaleLog,localeCurrencySymbol);
    
    NSString *localeCurrencyCode = [aLocale objectForKey:NSLocaleCurrencyCode];
    NSLog(@"%@ %@",kNSLocaleLog,localeCurrencyCode);
    
    NSString *localeCollatorIdentifier = [aLocale objectForKey:NSLocaleCollatorIdentifier];
    NSLog(@"%@ %@",kNSLocaleLog,localeCollatorIdentifier);
    
    NSString *localeQuotationBeginDelimiterKey = [aLocale objectForKey:NSLocaleQuotationBeginDelimiterKey];
    NSLog(@"%@ %@",kNSLocaleLog,localeQuotationBeginDelimiterKey);
}


@end
