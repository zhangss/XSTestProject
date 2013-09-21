//
//  CALayerViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-5-20.
//
//

#import "CALayerViewController.h"


@implementation MyLayerDelegate

//#pragma mark -
//#pragma mark CustomLayer Methods
//static inline double radians (double degrees) { return degrees * M_PI/180; }
//
//void MyDrawColoredPattern (void *info, CGContextRef context) {
//    
//    CGColorRef dotColor = [UIColor colorWithHue:0 saturation:0 brightness:0.07 alpha:1.0].CGColor;
//    CGColorRef shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1].CGColor;
//    
//    CGContextSetFillColorWithColor(context, dotColor);
//    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1, shadowColor);
//    
//    CGContextAddArc(context, 3, 3, 4, 0, radians(360), 0);
//    CGContextFillPath(context);
//    
//    CGContextAddArc(context, 16, 16, 4, 0, radians(360), 0);
//    CGContextFillPath(context);
//}
//
//#pragma mark -
//#pragma mark CALayerDelegate
//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
//    
//    CGColorRef bgColor = [UIColor colorWithHue:0.6 saturation:1.0 brightness:1.0 alpha:1.0].CGColor;
//    CGContextSetFillColorWithColor(context, bgColor);
//    CGContextFillRect(context, layer.bounds);
//    
//    static const CGPatternCallbacks callbacks = { 0, &MyDrawColoredPattern, NULL };
//    
//    CGContextSaveGState(context);
//    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
//    CGContextSetFillColorSpace(context, patternSpace);
//    CGColorSpaceRelease(patternSpace);
//    
//    CGPatternRef pattern = CGPatternCreate(NULL,
//                                           layer.bounds,
//                                           CGAffineTransformIdentity,
//                                           24,
//                                           24,
//                                           kCGPatternTilingConstantSpacing,
//                                           true,
//                                           &callbacks);
//    CGFloat alpha = 1.0;
//    CGContextSetFillPattern(context, pattern, &alpha);
//    CGPatternRelease(pattern);
//    CGContextFillRect(context, layer.bounds);
//    CGContextRestoreGState(context);
//}

@end

@interface CALayerViewController ()

@end

#define kLayerWidth 100

@implementation CALayerViewController

#pragma mark -
#pragma mark Init
- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    [myLayer release];
    [subLayer release];
    
    [pacmanOpenPath release];
    [pacmanClosePath release];
    [pacManLayer release];
    
    //!!!:Layer崩溃问题暂时处理方法
     NSMutableArray *xx = [[NSMutableArray alloc] initWithCapacity:0];
    [[self.view.layer sublayers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [xx addObject:obj];
    }];
    [xx enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (((CALayer *)obj).delegate != nil)
        {
            ((CALayer *)obj).delegate = nil;
        }
        //或者将其移除
//        [(CALayer *)obj removeFromSuperlayer];
    }];

    [super dealloc];
}

#pragma mark -
#pragma mark Life Cycel
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"CALayer", @"")];
    
#pragma mark -
#pragma mark Layer 例子1
    //(100,100)位置的参照物
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLayerWidth, kLayerWidth)];
    aView.layer.borderWidth = 3.0;
    aView.layer.borderColor = [UIColor blueColor].CGColor;
    [self.view addSubview:aView];
    [aView release];
    
    /*
     Layer的anchorPoint称为定位点，它决定着layer的那个点会在layer的position'位置上，它的xy取值范围0~1。默认为(0.5,0.5). 动画变形时的变型原点
     */
    myLayer = [[CALayer layer] retain];
    
    //此处的bounds的坐标无法控制其位置, 只能用锚点控制  此处仅仅控制其大小
    myLayer.bounds = CGRectMake(0, 0, kLayerWidth, kLayerWidth);
    
    myLayer.position = CGPointMake(kLayerWidth, kLayerWidth);
    
    myLayer.backgroundColor = [UIColor redColor].CGColor;
    
    /*
     A Boolean indicating whether the layer contents must be updated when its bounds rectangle changes.
     When this property is set to YES, the layer automatically calls its setNeedsDisplay method whenever its bounds property changes. The default value of this property is NO.
     当Layer的大小发生变化时 是否自动调整其显示.
     setNeedsDisplay会调用Layer的display方法。
     setNeedsLayout 会调用Layer的LayoutsubLayers方法；
     */
    myLayer.needsDisplayOnBoundsChange = YES;

    
    [self.view.layer addSublayer:myLayer];
    /*
    [ˈæŋkər]
     anchorPoint为默认值，本例的最终效果为layer的中间点在父层得(100,100位置)
     */

    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 20, 20)];
    aLabel.backgroundColor = [UIColor clearColor];
    aLabel.text = NSLocalizedString(@"AnchorX", @"Layer的锚点的X值");
    [aLabel labelWithType:kLabelName1];
    aLabel.frame = [XSTestUtils getControlSizeWithControl:aLabel andIsWidthKnown:NO];
    [self.view addSubview:aLabel];
    UISlider *xValueSlider = [[UISlider alloc] initWithFrame:CGRectZero];
    xValueSlider.minimumValue = 0.0;
    xValueSlider.maximumValue = 1.0;
    xValueSlider.value = 0.5;
    xValueSlider.frame = CGRectMake(aLabel.frame.origin.x + aLabel.frame.size.width + VIEW_INTERVAL, aLabel.frame.origin.y + aLabel.frame.size.height / 2, 100, 10);
    [xValueSlider addTarget:self action:@selector(anchorPointXValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:xValueSlider];
    [xValueSlider release];
    
    UILabel *bLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, aLabel.frame.origin.y + aLabel.frame.size.height + VIEW_INTERVAL, 20, 20)];
    bLabel.backgroundColor = [UIColor clearColor];
    bLabel.text = NSLocalizedString(@"AnchorY", @"Layer的锚点的Y值");
    [bLabel labelWithType:kLabelName1];
    bLabel.frame = [XSTestUtils getControlSizeWithControl:bLabel andIsWidthKnown:NO];
    [self.view addSubview:bLabel];
    UISlider *yValueSlider = [[UISlider alloc] initWithFrame:CGRectZero];
    yValueSlider.minimumValue = 0.0;
    yValueSlider.maximumValue = 1.0;
    yValueSlider.value = 0.5;
    yValueSlider.frame = CGRectMake(bLabel.frame.origin.x + bLabel.frame.size.width + VIEW_INTERVAL, bLabel.frame.origin.y + bLabel.frame.size.height / 2, 100, 10);
    [yValueSlider addTarget:self action:@selector(anchorPointYValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:yValueSlider];
    [yValueSlider release];
    
    UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, bLabel.frame.origin.y + bLabel.frame.size.height + VIEW_INTERVAL, 20, 20)];
    cLabel.backgroundColor = [UIColor clearColor];
    cLabel.text = NSLocalizedString(@"Layer Size", @"Layer的大小");
    [cLabel labelWithType:kLabelName1];
    cLabel.frame = [XSTestUtils getControlSizeWithControl:cLabel andIsWidthKnown:NO];
    [self.view addSubview:cLabel];
    UISlider *zValueSlider = [[UISlider alloc] initWithFrame:CGRectZero];
    zValueSlider.minimumValue = 0.0;
    zValueSlider.maximumValue = 1.0;
    zValueSlider.value = 1.0;
    zValueSlider.frame = CGRectMake(cLabel.frame.origin.x + cLabel.frame.size.width + VIEW_INTERVAL, cLabel.frame.origin.y + cLabel.frame.size.height / 2, 100, 10);
    [zValueSlider addTarget:self action:@selector(layerSizeValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:zValueSlider];
    [zValueSlider release];
    
    [aLabel release];
    [bLabel release];
    [cLabel release];
    
    
#pragma mark -
#pragma mark Layer 例子2
    self.view.layer.backgroundColor = [UIColor orangeColor].CGColor;
    self.view.layer.cornerRadius = 20.0;
    self.view.layer.frame = CGRectInset(self.view.layer.frame, 20, 20);
    
    subLayer = [[CALayer layer] retain];
    subLayer.backgroundColor = [UIColor blueColor].CGColor;
    subLayer.shadowOffset = CGSizeMake(0, 3);           //阴影偏移量
    subLayer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    subLayer.shadowRadius = 5.0;                        //阴影半径
    subLayer.shadowOpacity = 0.8;                       //阴影透明度
    subLayer.frame = CGRectMake(200, 10, 100, 100);
    
    /*
     layer的圆角跟阴影效果不可兼得
          如果想要兼得 只能做两个层 把layer内容层做圆角
     */
    CALayer *imageLayer = [CALayer layer];
    
    /*
     layer赋内容3种方式
     1.contents
     2.子类 重写drawInContext方法 定制自己的layer
     3.delegate 实现 - (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context;方法
     
     在Layer里面绘图与添加一个子Layer不一样
     如果绘图大于layerbounds则不会被现实
     如果是子Layer则可以设置是否需要显示超过bounds的部分
     */
    imageLayer.contents = (id)[UIImage imageNamed:@"MM.jpg"].CGImage; //Layer内容
//    [imageLayer drawInContext:<#(CGContextRef)#>];
    
    /*
     contestsGravity [ˈɡrævəti]重力重量引力
     A string defining how the contents of the layer is mapped into its
     bounds rect. Options are `center', `top', `bottom', `left',
     `right', `topLeft', `topRight', `bottomLeft', `bottomRight',
     `resize', `resizeAspect', `resizeAspectFill'. The default value is
     `resize'. Note that "bottom" always means "Minimum Y" and "top"
     always means "Maximum Y".
     */
    imageLayer.contentsGravity = kCAGravityCenter;
    imageLayer.contentsGravity = kCAGravityResize; //默认值
    imageLayer.contentsGravity = kCAGravityResizeAspect;
    imageLayer.contentsGravity = kCAGravityResizeAspectFill;

    imageLayer.borderWidth = 2.0;                          //边框
    imageLayer.borderColor = [UIColor blackColor].CGColor; //边框颜色
    
    //???:绘图时的画框 border在内path的中间划线，也就是内外各占一半的border宽度。
    CGRect borderRect = CGRectInset(imageLayer.bounds, imageLayer.borderWidth/2, imageLayer.borderWidth/2);
    NSLog(@"BorderRect:%@",NSStringFromCGRect(borderRect));
    imageLayer.cornerRadius = 5.0;                         //圆角半径
    
    /*
     A Boolean indicating whether sublayers are clipped超出越过 to the layer’s bounds. Animatable.
     When the value of this property is YES, Core Animation creates an implicit clipping mask that matches the bounds of the layer and includes any corner radius effects. If a value for the mask property is also specified, the two masks are multiplied to get the final mask value.
     The default value of this property is NO.
     如果subLayer越界是否裁剪subLayers 
     */
    imageLayer.masksToBounds = YES;                        //隐藏边界
    imageLayer.frame = subLayer.bounds;
//    imageLayer.frame = CGRectInset(subLayer.bounds,0,0);
    [subLayer addSublayer:imageLayer];
    [self.view.layer addSublayer:subLayer];
    
    /*
     自定义layer
     */
    CALayer *customDrawn = [CALayer layer];
    /*
     In iOS, if the layer is associated with a UIView object, this property must be set to the view that owns the layer.
     */
//    customDrawn.delegate = self.view.layer; //这样做的话 delegate不会被调用
//    customDrawn.delegate = self.view;       //这样View Did Load就会崩溃
    customDrawn.delegate = self;            /*这样的话 self dealloc的时候会崩溃 但是在dealloc中移除layer或者将layer的delegate置空 就不会崩溃了*/
    
    //???:貌似标准的写法 但是这样初始化的delegate不需要释放？！！
    //customDrawn.delegate = [[MyLayerDelegate alloc] init];
    
    customDrawn.backgroundColor = [UIColor greenColor].CGColor;
    customDrawn.frame = CGRectMake(200, 150, 100, 40);
    customDrawn.shadowOffset = CGSizeMake(0, 3);
    customDrawn.shadowRadius = 5.0;
    customDrawn.shadowColor = [UIColor blackColor].CGColor;
    customDrawn.shadowOpacity = 0.8;
    customDrawn.cornerRadius = 10.0;
    customDrawn.borderColor = [UIColor blackColor].CGColor;
    customDrawn.borderWidth = 2.0;
    customDrawn.masksToBounds = YES;
    [self.view.layer addSublayer:customDrawn];
    [customDrawn setNeedsDisplay];
    
    /*
     superLayer:父Layer readOnly
     subLayers:子Layer 数组
     Add:增加子Layer到父Layer的SubLayers中
     Insert:插入
     Remove:移出
     Replace:替换
     
     CALayer *aLyer = self.view.layer.superlayer;
     [self.view.layer sublayers];
     [self.view.layer addSublayer:customDrawn];
     [self.view.layer insertSublayer:<#(CALayer *)#> above:<#(CALayer *)#>];
     [self.view.layer insertSublayer:<#(CALayer *)#> atIndex:<#(unsigned int)#>];
     [self.view.layer insertSublayer:<#(CALayer *)#> below:<#(CALayer *)#>];
     [self.view.layer removeFromSuperlayer];  //Detaches分离拆开析出 the layer from its parent layer.
     [self.view.layer replaceSublayer:<#(CALayer *)#> with:<#(CALayer *)#>];
     */
    
    /*
     苹果提供了修改子Layer的默认动画方法
     actions: A dictionary containing layer actions. The default value of this property is nil. You can use this dictionary to store custom actions for your layer. The contents of this dictionary searched as part of the standard implementation of the actionForKey: method.
     
     NSMutableDictionary *cAAction = [NSMutableDictionary dictionaryWithDictionary:[self.view.layer actions]];
     [cAAction setObject:[NSNull null] forKey:@"subLayers"];
     self.view.layer.actions = cAAction;
     
     */

    /*
     触发runActionForKey
     
     subLayer.actions = [NSDictionary dictionaryWithObject:@"一个自定义动画类CAAnimation" forKey:@"test"];
     [subLayer setValue:@"参数" forKey:@"test"];
     */
#pragma mark -
#pragma mark 例子三
    UIButton *animBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [animBtn setTitle:NSLocalizedString(@"移动并缩小图像", nil) forState:UIControlStateNormal];
    [animBtn addTarget:self action:@selector(moveAndMakeImageSmall) forControlEvents:UIControlEventTouchUpInside];
    animBtn.frame = CGRectMake(VIEW_INTERVAL, cLabel.frame.size.height + cLabel.frame.origin.y + VIEW_INTERVAL, 10, 10);
    [animBtn sizeToFit];
    [self.view addSubview:animBtn];
    
    UIButton *animBtnB = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [animBtnB setTitle:NSLocalizedString(@"旋转并右移图像", nil) forState:UIControlStateNormal];
    [animBtnB addTarget:self action:@selector(spinAndMoveImage) forControlEvents:UIControlEventTouchUpInside];
    animBtnB.frame = CGRectMake(VIEW_INTERVAL, animBtn.frame.size.height + animBtn.frame.origin.y + VIEW_INTERVAL, 10, 10);
    [animBtnB sizeToFit];
    [self.view addSubview:animBtnB];
    
    UIButton *animBtnC = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [animBtnC setTitle:NSLocalizedString(@"旋转并消除图像锯齿", nil) forState:UIControlStateNormal];
    [animBtnC addTarget:self action:@selector(spinAndAntialiasing) forControlEvents:UIControlEventTouchUpInside];
    animBtnC.frame = CGRectMake(VIEW_INTERVAL + animBtn.frame.size.width + animBtn.frame.origin.x, animBtn.frame.origin.y, 10, 10);
    [animBtnC sizeToFit];
    [self.view addSubview:animBtnC];
    
    [self pacManAnimationInit];
    
    UIButton *animBtnD = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [animBtnD setTitle:NSLocalizedString(@"开始吃人豆动画", nil) forState:UIControlStateNormal];
    [animBtnD addTarget:self action:@selector(startPacMan) forControlEvents:UIControlEventTouchUpInside];
    animBtnD.frame = CGRectMake(VIEW_INTERVAL + animBtnB.frame.size.width + animBtnB.frame.origin.x, animBtnB.frame.origin.y, 10, 10);
    [animBtnD sizeToFit];
    [self.view addSubview:animBtnD];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Methods
- (void)anchorPointXValueChanged:(id)sender
{
    UISlider *aSlider = (UISlider *)sender;
    CGPoint anchorPoint = myLayer.anchorPoint;
    anchorPoint.x = aSlider.value;
    myLayer.anchorPoint = anchorPoint;
//    NSLog(@"%@",NSStringFromCGPoint(myLayer.anchorPoint));
}

- (void)anchorPointYValueChanged:(id)sender
{
    UISlider *aSlider = (UISlider *)sender;
    CGPoint anchorPoint = myLayer.anchorPoint;
    anchorPoint.y = aSlider.value;
    myLayer.anchorPoint = anchorPoint;
//    NSLog(@"%@",NSStringFromCGPoint(myLayer.anchorPoint));
}

- (void)layerSizeValueChanged:(id)sender
{
    UISlider *aSlider = (UISlider *)sender;
    CGRect layerRect = myLayer.frame;
    layerRect.size = CGSizeMake(kLayerWidth * aSlider.value, kLayerWidth * aSlider.value);
    myLayer.frame = layerRect;
    //    NSLog(@"%@",NSStringFromCGPoint(myLayer.anchorPoint));
}

#pragma mark -
#pragma mark CustomLayer Methods
static inline double radians (double degrees) { return degrees * M_PI/180; }

void MyDrawColoredPattern (void *info, CGContextRef context) {
    
    CGColorRef dotColor = [UIColor colorWithHue:0 saturation:0 brightness:0.07 alpha:1.0].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1].CGColor;
    
    CGContextSetFillColorWithColor(context, dotColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1, shadowColor);
    
    CGContextAddArc(context, 3, 3, 4, 0, radians(360), 0);
    CGContextFillPath(context);
    
    CGContextAddArc(context, 16, 16, 4, 0, radians(360), 0);
    CGContextFillPath(context);
}

#pragma mark -
#pragma mark CALayerDelegate
/*
 Allows the delegate to customize the action for a layer.
 
 If defined, called by the default implementation of the 
 -actionForKey: method. Should return an object implementating the
 CAAction protocol. May return 'nil' if the delegate doesn't specify
 a behavior for the current event. Returning the null object (i.e.
 '[NSNull null]') explicitly forces no further search. (I.e. the
 +defaultActionForKey: method will not be called.)
 
 当Layer的动画属性发生变化时会调用此方法 
 */
- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    CATransition *anim = nil;
    if ([event isEqualToString:@"frame"])
    {
        anim = [CATransition animation];
        anim.duration = 2;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.type = @"cube";
        anim.subtype = kCATransitionFromRight;
    }
    return anim;
}

/*
 Allows the delegate to override the display implementation.
 
 与下面的函数二者只能选其一 
 */
//- (void)displayLayer:(CALayer *)layer
//{
//
//}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    
    CGColorRef bgColor = [UIColor colorWithHue:0.6 saturation:1.0 brightness:1.0 alpha:1.0].CGColor;
    CGContextSetFillColorWithColor(context, bgColor);
    CGContextFillRect(context, layer.bounds);
    
    static const CGPatternCallbacks callbacks = { 0, &MyDrawColoredPattern, NULL };
    
    CGContextSaveGState(context);
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, patternSpace);
    CGColorSpaceRelease(patternSpace);
    
    CGPatternRef pattern = CGPatternCreate(NULL,
                                           layer.bounds,
                                           CGAffineTransformIdentity,
                                           24,
                                           24,
                                           kCGPatternTilingConstantSpacing,
                                           true,
                                           &callbacks);
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextFillRect(context, layer.bounds);
    CGContextRestoreGState(context);
}

#pragma mark -
#pragma mark CAProtocol
/* 
 Called to trigger the event named 'path' on the receiver. The object
 (e.g. the layer) on which the event happened is 'anObject'. The
 arguments dictionary may be nil, if non-nil it carries parameters
 associated with the event.
 */
- (void)runActionForKey:(NSString *)event object:(id)anObject
              arguments:(NSDictionary *)dict
{
    NSLog(@"runActionForKey:\"%@\" object:%@ arguments:%@",event,anObject,dict);
    CATransition *anim = nil;
    if ([event isEqualToString:@"test"])
    {
        anim = [CATransition animation];
        anim.duration = 2;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.type = @"cube";
        anim.subtype = kCATransitionFromRight;
    }
    [(CALayer *)anObject addAnimation:anim forKey:@"frame"];
}

#pragma mark - 
#pragma mark Layer Animation
/*
 移动图片位置 并且把图片变小 变透明
 */
- (void)moveAndMakeImageSmall
{
    CGPoint fromPoint = CGPointMake(subLayer.frame.origin.x + subLayer.frame.size.width/2, subLayer.frame.origin.y + subLayer.frame.size.height/2);
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(10, 400);
    [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(300, 200)];
    
    //关键帧
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    //旋转变化/缩放变化
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2, 0.2, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    //透明变化
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    //组合执行
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim, opacityAnim, nil];
    animGroup.duration = 3.0;
    [subLayer addAnimation:animGroup forKey:nil];
    
}

- (void)spinAndMoveImage
{
    CGPoint fromPoint = CGPointMake(subLayer.frame.origin.x + subLayer.frame.size.width/2, subLayer.frame.origin.y + subLayer.frame.size.height/2);
    
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(fromPoint.x, fromPoint.y + 100);
    [movePath addLineToPoint:toPoint];
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    
    CABasicAnimation *transformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //分别绕着Z Y X 轴旋转
    transformAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
//    transformAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1, 0)];
//    transformAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 0, 0)];

    transformAnim.cumulative = YES;
    transformAnim.duration = 3;
    transformAnim.repeatCount = 2;
    transformAnim.removedOnCompletion = YES;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, transformAnim, nil];
    animGroup.duration = 6;
    
    /*
     动画停止时layer的位置
     */
    CGRect selfRect = subLayer.frame;
    selfRect.origin = CGPointMake(toPoint.x - selfRect.size.width/2, toPoint.y - selfRect.size.height/2);
    subLayer.frame = selfRect;

    [subLayer addAnimation:animGroup forKey:nil];
}

//Anti-aliasing 消除锯齿
- (void)spinAndAntialiasing
{
    //图片旋转360度
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //围绕Z轴旋转 垂直与屏幕
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1.0)];
    animation.duration = 3.0;
    //旋转效果累计 先转180 然后在转180实现 360
    animation.cumulative = YES;
    animation.repeatCount = 2;
    
    //单独旋转时 图片周围会出锯齿
//    myLayer.contents = (id)[UIImage imageNamed:@"MM.jpg"].CGImage;
    
    //在图盘边缘添加一个像素的透明区域 去图片锯齿
    CGRect imageRect = myLayer.bounds;
    UIGraphicsBeginImageContext(imageRect.size);
    [[UIImage imageNamed:@"MM.jpg"] drawInRect:CGRectInset(myLayer.bounds, 1, 1)];
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    myLayer.contents = (id)aImage.CGImage;
    UIGraphicsEndImageContext();
    
    [myLayer addAnimation:animation forKey:nil];
}

#pragma mark -
#pragma mark Pac-Man(吃人豆)

#define DEGREES_TO_RADIANS(x) (3.14159265358979323846 * x / 180.0)

- (void)pacManAnimationInit
{
    CGFloat radius = 30.0f;
    CGFloat diameter = radius * 2;
    CGPoint arcCenter = CGPointMake(radius, radius);
    
    //创建一个吃人豆的打开状态
    pacmanOpenPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                                  radius:radius
                                                              startAngle:DEGREES_TO_RADIANS(35)
                                                                endAngle:DEGREES_TO_RADIANS(315)
                                                               clockwise:YES];
    [pacmanOpenPath addLineToPoint:arcCenter];
    [pacmanOpenPath closePath];
    [pacmanOpenPath retain];
    
    //创建一个吃人豆的关闭状态
    pacmanClosePath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                                   radius:radius
                                                               startAngle:DEGREES_TO_RADIANS(1)
                                                                 endAngle:DEGREES_TO_RADIANS(359)
                                                                clockwise:YES];
    [pacmanClosePath addLineToPoint:arcCenter];
    [pacmanClosePath closePath];
    [pacmanClosePath retain];
    
    //创建吃人豆的身体 黄色
    pacManLayer = [CAShapeLayer layer];
    pacManLayer.fillColor = [UIColor yellowColor].CGColor;
    pacManLayer.path = pacmanClosePath.CGPath;
    pacManLayer.strokeColor = [UIColor grayColor].CGColor;
    pacManLayer.lineWidth = 1.0f;
    pacManLayer.bounds = CGRectMake(0, 0, diameter, diameter);
    pacManLayer.position = CGPointMake(-40, -100);
    [pacManLayer retain];
    [self.view.layer addSublayer:pacManLayer];
    
    SEL startSelector = @selector(startPacMan);
    UIGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:startSelector];
    [self.view addGestureRecognizer:recognizer];
    [recognizer release];
    
}

- (void)startPacMan
{
    //创建吃豆人 咬牙动画 chomp [tʃɑmp] 大声的咀嚼
    CABasicAnimation *chompAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    chompAnimation.duration = .25;
    chompAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    chompAnimation.repeatCount = HUGE_VALF;
    chompAnimation.autoreverses = YES;
    
    //Animate between the two path values
    chompAnimation.fromValue = (id)pacmanClosePath.CGPath;
    chompAnimation.toValue = (id)pacmanOpenPath.CGPath;
    [pacManLayer addAnimation:chompAnimation forKey:@"chomAnimation"];
    
    //Creat digital "2"-shaped path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 100)];
    [path addLineToPoint:CGPointMake(300, 100)];
    [path addLineToPoint:CGPointMake(300, 200)];
    [path addLineToPoint:CGPointMake(0, 200)];
    [path addLineToPoint:CGPointMake(0, 300)];
    [path addLineToPoint:CGPointMake(300, 300)];

    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path = path.CGPath;
    moveAnimation.duration = 8.0f;
    //Setting the rotation mode ensuers Pacman's mouth is always forward.
    //This is a very convenient feature.
    moveAnimation.repeatCount = HUGE_VALF;
    moveAnimation.rotationMode = kCAAnimationRotateAuto;
    [pacManLayer addAnimation:moveAnimation forKey:@"moveAnimation"];
}

@end
