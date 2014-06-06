//
//  IOSJSONViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-11-21.
//
//

#import "IOSJSONViewController.h"

#define kJSON_TO_OBJ @"JsonToObj"
#define kOBJ_TO_JSON @"ObjToJson"
#define kSUCCESS @"Success:"

@interface IOSJSONViewController ()

@property (nonatomic,assign) JSONType type;
@property (nonatomic,strong) UILabel *resultLabel;
@property (nonatomic,strong) NSDictionary *dataSource;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,assign) BOOL isObjToJson;

@end

@implementation IOSJSONViewController

#pragma mark -
#pragma mark Init / Dealloc
- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark Life Cycel
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGFloat yPoint = VIEW_INTERVAL * 7;
	// Do any additional setup after loading the view.
    NSArray *jsonType = [NSArray arrayWithObjects:
                         @"NSJSONSerialization",
                         @"JSONKit",
                         @"SBJSON",
                         @"TouchJson",
                         nil];
    UISegmentedControl *segement = [[UISegmentedControl alloc] initWithItems:jsonType];
    segement.frame = CGRectMake(VIEW_INTERVAL,
                                yPoint,
                                self.view.frame.size.width - VIEW_INTERVAL * 2,
                                VIEW_INTERVAL *2);
    [segement addTarget:self action:@selector(segemetValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segement];
    yPoint += segement.frame.size.height;
    
    yPoint += VIEW_INTERVAL;
    self.resultLabel = [[UILabel alloc] initWithFrame:
    CGRectMake(VIEW_INTERVAL,
               yPoint,
               segement.frame.size.width,
               VIEW_INTERVAL * 4)];
    _resultLabel.textAlignment = UITextAlignmentCenter;
    _resultLabel.backgroundColor = [UIColor grayColor];
    _resultLabel.text = NSLocalizedString(@"Result", @"结果");
    [self.view addSubview:_resultLabel];
    yPoint += _resultLabel.frame.size.height;
    
    yPoint += VIEW_INTERVAL;
    self.typeLabel = [[UILabel alloc] initWithFrame:
    CGRectMake(VIEW_INTERVAL,
               yPoint,
               VIEW_INTERVAL, VIEW_INTERVAL)];
    _typeLabel.backgroundColor = _resultLabel.backgroundColor;
    _typeLabel.text = kOBJ_TO_JSON;
    [_typeLabel sizeToFit];
    [self.view addSubview:_typeLabel];
    self.isObjToJson = YES;
    
    UISwitch *s = [[UISwitch alloc] initWithFrame:CGRectMake(_typeLabel.frame.origin.x + _typeLabel.frame.size.width + VIEW_INTERVAL, yPoint - 5, 10, 10)];
    [s setOn:YES];
    [s addTarget:self action:@selector(switchChanded:) forControlEvents:UIControlEventValueChanged];
    [s sizeToFit];
    [self.view addSubview:s];
    yPoint += _typeLabel.frame.size.height;
    
    yPoint += VIEW_INTERVAL;
    UITableView *tableView = [[UITableView alloc] initWithFrame:
                              CGRectMake(0,
                                         yPoint,
                                         self.view.frame.size.width,
                                         self.view.frame.size.height - yPoint)
                                                          style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:tableView];
    
    NSArray *testArr = [NSArray arrayWithObjects:@"1",@"2",nil];
    NSDictionary *testDic = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"zhangss",@"name",
                             [NSNumber numberWithInteger:20],@"age",
                             nil];
    self.dataSource = [NSDictionary dictionaryWithObjectsAndKeys:
                   @"123",@"String",
                   [NSNumber numberWithInteger:1],@"Number int",
                   [NSNumber numberWithFloat:1.0],@"Number float",
                   [NSNumber numberWithBool:YES],@"Number Bool",
                   testArr,@"Array",
                   testDic,@"Dictionary",
                   nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Methods

#pragma mark Segement Methods
- (void)segemetValueChanged:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
        {
            _type = JSONTypeiOS;
            break;
        }
        case 1:
        {
            _type = JSONTypeiOS;
            break;
        }
        case 2:
        {
            _type = JSONTypeiOS;
            break;
        }
        case 3:
        {
            _type = JSONTypeiOS;
            break;
        }
        default:
        {
            _type = JSONTypeiOS;
            break;
        }
    }
}

#pragma mark Switch
- (void)switchChanded:(id)sender
{
    UISwitch *s = (UISwitch *)sender;
    self.isObjToJson = s.on;
    _typeLabel.text = _isObjToJson ? kOBJ_TO_JSON : kJSON_TO_OBJ;
}

- (void)objectToString:(id)obj
{
    NSString *jsonString = nil;
    switch (_type) {
        case JSONTypeiOS:
        {
            jsonString = [self iosObjectToJsonString:obj];
            break;
        }
        default:
            break;
    }

    NSString *resultString = jsonString ? [NSString stringWithFormat:@"%@%@",kSUCCESS,jsonString] : @"Failed";
    _resultLabel.text = resultString;
}

- (void)stringToObject:(NSString *)string
{
    id obj = nil;
    switch (_type) {
        case JSONTypeiOS:
        {
            obj = [self iosJsonStringToObject:string];
            break;
        }
        default:
            break;
    }
    NSString *resultString = obj ? [[[NSString stringWithFormat:@"%@%@",kSUCCESS,obj] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] : @"Failed";
    _resultLabel.text = resultString;
}

#pragma mark -
#pragma mark iOS NSJSONSerialization
//serialize ['sɪriə.laɪz]序列化
/**
 * NSJSONSerialization属于Fundation框架，提供JSON与Foundation对象的互转。
 * 1.可以转换为JSON的对象必须符合如下要求:
 * 1.1对象最外层必须是NSDictionary或者NSArray.
 * 1.2对象中所有元素必须是NSDictionary、NSArray、NSString、NSNumber或者NSNULL.
 * 1.3元素NSDictionary中的key必须是NSString.
 * 1.4元素NSNumber的值必须为非NaN(Not A Number)或者非无穷大数值。
 * 2.API适用于IOS5.0/OX10.7以后。
 * 3.编码推荐是使用UTF-8。
 */
/**
 *  使用iOS自带的Json序列化API,转换基础对象为JSONString
 *
 *  @param obj 需要序列化的对象.
 *  @return NSString Or nil
 */
- (NSString *)iosObjectToJsonString:(id)obj
{
    /**
     * 1.需要JSON校验,参照上述校验规则
     * This exception is thrown prior to parsing and represents a programming error, not an internal error. You should check whether the input will produce valid JSON before calling this method by using isValidJSONObject:.
     * 解析之前需要检查是否是可以转换为JSON格式，如果返回NO，转换API会抛出异常，然后崩溃
     */
    if (![NSJSONSerialization isValidJSONObject:obj])
    {
        NSLog(@"Validate Json obj!");
        return nil;
    }
    NSError *error = nil;
    NSJSONWritingOptions option = 0;
    /*
     * 1.此选项生成的Json使用空格格式化过，便于日志输出查看
     * 2.如果不设置，即传入0，返回的JSON没有格式化。
     * 3.如果解析发生错误，错误传入Error,同时返回nil
     * 4.返回的Data是UTF-8编码的数据。
     * 5.obj不能为空，否则崩溃。obj=nil，通过不了isValidJSONObject校验
     */
//    option = NSJSONWritingPrettyPrinted;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:option
                                                         error:&error];
    /*
     * 1.如果jsonData为空,是否会崩溃?,不会!,无需判空操作
     */
//    jsonData = nil;
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (error)
    {
        NSLog(@"%@",error);
    }
    return jsonString;
}

/**
 *  使用iOS自带的Json序列化API,转换JSONString为基础对象
 *
 *  @param string JSON字符串
 *
 *  @return 基础对象或者nil
 */
- (id)iosJsonStringToObject:(NSString *)string
{
    NSError *error = nil;
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    /**
     *  1.JSON转对象的Data必须使用如下五种编码:
     *    UTF-8,UTF-16LE,UTF-16BE,UTF-32LE,UTF-32BE.推荐使用UTF-8编码最有效率.
     *  2.转换选项NSJSONReadingOptions的值分别意为；
     *  2.1NSJSONReadingMutableContainers生成可变的NSArray或者NSDictionary.
     *  2.2NSJSONReadingMutableLeaves生成可变的NSString.
     *  2.3NSJSONReadingAllowFragments允许生成的JSON最高层非NSArray或者NSDictionary对象.
     */
    NSJSONReadingOptions options = NSJSONReadingAllowFragments;
//    options = NSJSONReadingMutableContainers;
//    options = NSJSONReadingMutableLeaves;
//    options = NSJSONReadingAllowFragments;
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData
                                             options:options
                                               error:&error];
    if (error)
    {
        NSLog(@"%@",error);
    }
    return obj;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_dataSource allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"JsonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *key = [[_dataSource allKeys] objectAtIndex:indexPath.row];
    NSMutableString *string = [NSMutableString stringWithFormat:@"%@",key];
    [string appendString:@":"];
    
    [string appendString:[NSString stringWithFormat:@"%@",[[[[_dataSource valueForKey:key] description] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    cell.textLabel.text = string;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}
#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *key = [[_dataSource allKeys] objectAtIndex:indexPath.row];
    if (_isObjToJson)
    {
        [self objectToString:[_dataSource objectForKey:key]];
    }
    else
    {
        if ([[_dataSource objectForKey:key] isKindOfClass:[NSArray class]] ||
            [[_dataSource objectForKey:key] isKindOfClass:[NSDictionary class]])
        {
            [self objectToString:[_dataSource objectForKey:key]];
            NSString *jsonString = [_resultLabel.text stringByReplacingOccurrencesOfString:kSUCCESS withString:@""];
            [self stringToObject:jsonString];
        }
        else
        {
            [self stringToObject:[[_dataSource objectForKey:key] description]];
        }
    }
}
@end
