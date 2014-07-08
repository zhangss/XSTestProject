//
//  RunTimeTester.m
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-7-2.
//
//

#import "RunTimeTester.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface SubRunTimeTester : RunTimeTester

- (void)doLoad;

@end

@implementation SubRunTimeTester



@end

@implementation RunTimeTester


#pragma mark -
#pragma mark Init
//此时编译器认为返回值为RunTimeTester *
- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

//此时编译器认为返回值为id
+ (id)sharedInstanceId
{
    return [self init];
}

//此时编译器认为返回值为RunTimeTester *
+ (instancetype)sharedInstance
{
    return [self init];
}

#pragma mark -
#pragma mark id and instancetype
- (void)idAndInstanceTypeTest
{
    /**
     *  错误的调用子类方法
     *  1.id返回的是任意类型实例
     *  2.instancetype返回的必须是当前类型的实例。
     *  3.也就是说对于非New/alloc/init方法初始化对象时使用instancetype比id更保险。但是instancetype只能用作返回值，表示当前类型的实例。
     *  4.[NSArray array]返回的就是instancetype
     */
    //1.这种方式返回的会警告，跑起来依然会崩溃
    [[RunTimeTester sharedInstance] doLoad];
    //2.这种方式不会报警告，但是跑起来会崩溃
    [[RunTimeTester sharedInstanceId] doLoad];
    //3.这样调用肯定不会有问题
    [[SubRunTimeTester sharedInstanceId] doLoad];
    [[SubRunTimeTester sharedInstance] doLoad];
}

#pragma mark -
#pragma mark Dynamic Typing
//动态类型
- (void)runtimeInspectionDynamicTyping
{
    NSString *classString = NSStringFromClass([RunTimeTester class]);
    NSString *methodString = NSStringFromSelector(@selector(doSomethingMethod));
    Class class = NSClassFromString(classString);
//    SEL selector = NSSelectorFromString(methodString);
    NSLog(@"%@,%@,%@",classString,methodString,class);
    
    
    //获取一个id类型的对象
    id obj = [[RunTimeTester alloc] init];
    //使用前检查对象
    if ([obj isKindOfClass:[RunTimeTester class]])
    {
        //强制转换
        RunTimeTester *tester = (RunTimeTester *)obj;
        [tester doSomethingMethod];
    }
    
    /**
     *  isKindOfClass与isMemberOfClass的区别
     *  1.isKindOfClass包含isMessageOfClass
     *  2.isKindOfClass要求对象是该类型或者该类型子类的实例即可。
     *  3.isMemberOfClass要求该对象必须为该类型的实例。
     */
    if ([obj isKindOfClass:[NSObject class]])
    {
        NSLog(@"Object is %@",NSStringFromClass([NSObject class]));
    }
    else
    {
        NSLog(@"Object is not %@",NSStringFromClass([NSObject class]));
    }
    
    if ([obj isKindOfClass:[RunTimeTester class]])
    {
        NSLog(@"Object is %@",NSStringFromClass([RunTimeTester class]));
    }
    else
    {
        NSLog(@"Object is not %@",NSStringFromClass([RunTimeTester class]));
    }

    if ([obj isMemberOfClass:[NSObject class]])
    {
        NSLog(@"Object is %@",NSStringFromClass([NSObject class]));
    }
    else
    {
        NSLog(@"Object is not %@",NSStringFromClass([NSObject class]));
    }

    if ([obj isMemberOfClass:[RunTimeTester class]])
    {
        NSLog(@"Object is %@",NSStringFromClass([RunTimeTester class]));
    }
    else
    {
        NSLog(@"Object is not %@",NSStringFromClass([RunTimeTester class]));
    }
}

#pragma mark 很好地解析实现方法-打破思维困顿
- (void)parseObject:(NSArray *)propertyList
{
    //循环判断的方法
    for (id obj in propertyList)
    {
        if ([obj isKindOfClass:[NSString class]])
        {
            
        }
        else if ([obj isKindOfClass:[NSNumber class]])
        {
        
        }
        else if ([obj isKindOfClass:[NSDictionary class]])
        {
        
        }
    }
    
    //更好的方法
    for (id obj in propertyList)
    {
        NSString *objType = NSStringFromClass(obj);
        SEL selector = NSSelectorFromString([NSString stringWithFormat:@"parse%@",objType]);
        [self performSelector:selector withObject:obj];
    }
}

- (void)parseNSString:(NSString *)string
{

}

- (void)parseNSNumber:(NSNumber *)number
{

}

#pragma mark -
#pragma mark Dynamic Binding
//动态绑定
- (void)runtimeInspectionDynamicBinding
{

}

void dynamicMethodIMP(id self,SEL _cmd)
{
    NSLog(@" >>");
}

//实例方法决议-替换实现方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    IMP dynamicMethodIMP = imp_implementationWithBlock(^(id self,NSString *msg){
        NSLog(@"Bolck：%@",msg);
    });
    
    if (sel == @selector(missMethod))
    {
        //当实例调用missMethod时，动态的为实例添加实现方法
        class_addMethod(self, sel, (IMP)dynamicMethodIMP, "");
        
        //之后会调用forwardingTargetForSelector
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

//类方法决议
+ (BOOL)resolveClassMethod:(SEL)sel
{
    return [super resolveClassMethod:sel];
}

/**
 *  动态增加实现方法实现。Method Swizzling
 *
 *  @return 是否成功
 */
- (BOOL)exchangeMethods
{
    Method methodOld = class_getInstanceMethod([self class], @selector(doSomethingMethod));
    if (!methodOld)
    {
        return NO;
    }
    
    Method methodNew = class_getInstanceMethod([self class], @selector(doSomethingExchangeMethod));
    if (!methodNew)
    {
        return NO;
    }
    
    //可以再拓展类方法之后 使用原来的类方法。
    method_exchangeImplementations(methodOld, methodNew);
    
    return YES;
}

#pragma mark -
#pragma mark Dynamic Loading
//动态加载
- (void)runtimeInspectionDynamicLoading
{
    //@2x的使用
}

#pragma mark -
#pragma mark 参数
- (void)runtimeParamterTest
{
    //实例方法：从NSString的Class结构中的methodLists中查找方法
    NSString *test;
    [test uppercaseString];
    //类方法：从NSString的metaClass结构中的methodLists中查找方法
    test = [NSString stringWithFormat:@"%@",@"test"];
    
    /**
     *  获取类的名称：name
     */
    objc_getClass("NSString");
    objc_getMetaClass("NSString");
    
    /**
     *  获取及设置类的版本号，默认为0：version
     */
    class_getVersion([NSString class]);
    class_setVersion([NSString class], 1);
    
    /*
     info：供运行期使用的一些位标识。有如下一些位掩码：
     
     CLS_CLASS (0x1L) 表示该类为普通 class ，其中包含实例方法和变量；
     CLS_META (0x2L) 表示该类为 metaclass，其中包含类方法；
     CLS_INITIALIZED (0x4L) 表示该类已经被运行期初始化了，这个标识位只被 objc_addClass 所设置；
     CLS_POSING (0x8L) 表示该类被 pose 成其他的类；（poseclass 在ObjC 2.0中被废弃了）；
     CLS_MAPPED (0x10L) 为ObjC运行期所使用
     CLS_FLUSH_CACHE (0x20L) 为ObjC运行期所使用
     CLS_GROW_CACHE (0x40L) 为ObjC运行期所使用
     CLS_NEED_BIND (0x80L) 为ObjC运行期所使用
     CLS_METHOD_ARRAY (0x100L) 该标志位指示 methodlists 是指向一个 objc_method_list 还是一个包含 objc_method_list 指针的数组；
     */
    
    /*
     instance_size:实例变量的大小
     ivars:存储每个实例变量的地址，如果没有则为NULL
     methodsLists:与info的一些标志位有关，CLS_METHOD_ARRAY标识位决定其指向的东西（是指向单个 objc_method_list还是一个objc_method_list指针数组），如果info设置了CLS_CLASS则 objc_method_list存储实例方法，如果设置的是CLS_META则存储类方法；
     cache:缓存最近使用的方法，以提升效率。
     protocol:存储该类遵循的协议列表。
     */
    
    /**
     *  根据是否存在NSRegularExpression类来判断iOS系统是否大于4
     *  运行时如果不存在该类的话会返回nil
     */
    if (NSClassFromString(@"NSRegularExpression")){
        NSLog(@"iOS 4++");
    }
    else {
        NSLog(@"iOS 4--");
    }
}

#pragma mark -
#pragma mark Message Dispatch
//消息分发机制
- (void)runtimeMesageDispatch
{
    //利用消息分发机制调用方法
    [self doSomethingMethod];
    objc_msgSend(self, @selector(doSomethingExchangeMethod));
}

/**
 *  重写方法以修改响应某个方法的对象
 *
 *  @param aSelector
 *
 *  @return 相应对象
 */
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    id obj;
    if ([obj respondsToSelector:aSelector])
    {
        return obj;
    }
    else
    {
        return [super forwardingTargetForSelector:aSelector];
    }
}

/**
 *  重写方法以修改消息
 *
 *  @param anInvocation
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    //把消息转发给某个对象
    id obj;
    if ([obj respondsToSelector:@selector(doSomethingMethod)])
    {
        [anInvocation setSelector:@selector(doSomethingMethod)];
        [anInvocation invokeWithTarget:obj];
    }
    else
    {
        [super forwardInvocation:anInvocation];
        
    }
}

#pragma mark -
#pragma mark Other
- (void)doSomethingMethod
{
    NSLog(@"%@",NSStringFromClass([self class]));
}

- (void)doSomethingExchangeMethod
{
    NSLog(@"Exchange %@",NSStringFromClass([self class]));
}

@end
