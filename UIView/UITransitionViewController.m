//
//  UITransitionViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-3-1.
//
//

#import "UITransitionViewController.h"

#import "XSTestUtils.h"
#import "TransitionFirstViewController.h"
#import "TransitionSecondViewController.h"
#import "TransitionThirdViewController.h"

@interface UITransitionViewController ()

@end

@implementation UITransitionViewController

#pragma mark -
#pragma mark Init
- (void)dealloc
{
    [super dealloc];
}

#pragma mark - 
#pragma mark Life Cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*

 If this view controller is a child of a containing view controller (e.g. a navigation controller or tab bar
 controller,) this is the containing view controller.  Note that as of 5.0 this no longer will return the
 presenting view controller.
 
@property(nonatomic,readonly) UIViewController *parentViewController;

// This property has been replaced by presentedViewController.
@property(nonatomic,readonly) UIViewController *modalViewController NS_DEPRECATED_IOS(2_0, 6_0);

// The view controller that was presented by this view controller or its nearest ancestor.
@property(nonatomic,readonly) UIViewController *presentedViewController  NS_AVAILABLE_IOS(5_0);

// The view controller that presented this view controller (or its farthest ancestor.)
@property(nonatomic,readonly) UIViewController *presentingViewController NS_AVAILABLE_IOS(5_0);


 Determines which parent view controller's view should be presented over for presentations of type
 UIModalPresentationCurrentContext.  If no ancestor view controller has this flag set, then the presenter
 will be the root view controller.
 
@property(nonatomic,assign) BOOL definesPresentationContext NS_AVAILABLE_IOS(5_0);

// A controller that defines the presentation context can also specify the modal transition style if this property is true.
@property(nonatomic,assign) BOOL providesPresentationContextTransitionStyle NS_AVAILABLE_IOS(5_0);


 These four methods can be used in a view controller's appearance callbacks to determine if it is being
 presented, dismissed, or added or removed as a child view controller. For example, a view controller can
 check if it is disappearing because it was dismissed or popped by asking itself in its viewWillDisappear:
 method by checking the expression ([self isDismissing] || [self isMovingFromParentViewController]).
 

- (BOOL)isBeingPresented NS_AVAILABLE_IOS(5_0);
- (BOOL)isBeingDismissed NS_AVAILABLE_IOS(5_0);

- (BOOL)isMovingToParentViewController NS_AVAILABLE_IOS(5_0);
- (BOOL)isMovingFromParentViewController NS_AVAILABLE_IOS(5_0);


 The next two methods are replacements for presentModalViewController:animated and
 dismissModalViewControllerAnimated: The completion handler, if provided, will be invoked after the presented
 controllers viewDidAppear: callback is invoked.
 
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion NS_AVAILABLE_IOS(5_0);
// The completion handler, if provided, will be invoked after the dismissed controller's viewDidDisappear: callback is invoked.
- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion NS_AVAILABLE_IOS(5_0);

The methods in the UIContainerViewControllerProtectedMethods and the UIContainerViewControllerCallbacks
categories typically should only be called by subclasses which are implementing new container view
controllers. They may be overridden but must call super.

@interface UIViewController (UIContainerViewControllerProtectedMethods)

// An array of children view controllers. This array does not include any presented view controllers.
@property(nonatomic,readonly) NSArray *childViewControllers NS_AVAILABLE_IOS(5_0);


 If the child controller has a different parent controller, it will first be removed from its current parent
 by calling removeFromParentViewController. If this method is overridden then the super implementation must
 be called.
 
- (void)addChildViewController:(UIViewController *)childController NS_AVAILABLE_IOS(5_0);


 Removes the the receiver from its parent's children controllers array. If this method is overridden then
 the super implementation must be called.
 
- (void) removeFromParentViewController NS_AVAILABLE_IOS(5_0);


 This method can be used to transition between sibling child view controllers. The receiver of this method is
 their common parent view controller. (Use [UIViewController addChildViewController:] to create the
 parent/child relationship.) This method will add the toViewController's view to the superview of the
 fromViewController's view and the fromViewController's view will be removed from its superview after the
 transition completes. It is important to allow this method to add and remove the views. The arguments to
 this method are the same as those defined by UIView's block animation API. This method will fail with an
 NSInvalidArgumentException if the parent view controllers are not the same as the receiver, or if the
 receiver explicitly forwards its appearance and rotation callbacks to its children. Finally, the receiver
 should not be a subclass of an iOS container view controller. Note also that it is possible to use the
 UIView APIs directly. If they are used it is important to ensure that the toViewController's view is added
 to the visible view hierarchy while the fromViewController's view is removed.
 
- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(5_0);

// If a custom container controller manually forwards its appearance callbacks, then rather than calling
// viewWillAppear:, viewDidAppear: viewWillDisappear:, or viewDidDisappear: on the children these methods
// should be used instead. This will ensure that descendent child controllers appearance methods will be
// invoked. It also enables more complex custom transitions to be implemented since the appearance callbacks are
// now tied to the final matching invocation of endAppearanceTransition.
- (void)beginAppearanceTransition:(BOOL)isAppearing animated:(BOOL)animated __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0);
- (void)endAppearanceTransition __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0);
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:@"UIViewTransition"];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"First",@"Second",@"Third",nil]];
    segment.frame = CGRectMake(10, 10, self.view.frame.size.width - 2*10, 44);
    segment.segmentedControlStyle = UISegmentedControlStyleBar;
    [segment addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
    segment.userInteractionEnabled = YES;
    segment.enabled = YES;
    segment.selectedSegmentIndex = 0;
    [self.view addSubview:segment];
    [segment release];

    //增加三个View
    TransitionFirstViewController *firstVC = [[TransitionFirstViewController alloc] init];
    [self addChildViewController:firstVC];
    
    TransitionSecondViewController *secondVC = [[TransitionSecondViewController alloc] init];
    [self addChildViewController:secondVC];
    
    TransitionThirdViewController *thirdVC = [[TransitionThirdViewController alloc] init];
    [self addChildViewController:thirdVC];
    
    //设置默认显示的View
    //???:为什么addsubview一个之后其他的都可以展示
    [self.view addSubview:firstVC.view];
    currentViewController = firstVC;
    [firstVC release];
    [secondVC release];
    [thirdVC release];
    
    [self.view bringSubviewToFront:segment];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Methods
/*
 typedef NS_OPTIONS(NSUInteger, UIViewAnimationOptions) {
 UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
 UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, // turn on user interaction while animating
 UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // start all views from current value, not initial value
 UIViewAnimationOptionRepeat                    = 1 <<  3, // repeat animation indefinitely
 UIViewAnimationOptionAutoreverse               = 1 <<  4, // if repeat, run animation back and forth
 UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // ignore nested duration
 UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested curve
 UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only)
 UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing
 
 UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
 UIViewAnimationOptionCurveEaseIn               = 1 << 16,
 UIViewAnimationOptionCurveEaseOut              = 2 << 16,
 UIViewAnimationOptionCurveLinear               = 3 << 16,
 
 UIViewAnimationOptionTransitionNone            = 0 << 20, // default
 UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
 UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
 UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
 UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
 UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
 UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
 UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
 } NS_ENUM_AVAILABLE_IOS(4_0);
 */
- (void)segmentValueChange:(id)sender
{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    
    UIViewController *selectedVC = [self.childViewControllers objectAtIndex:segment.selectedSegmentIndex];
    [self transitionFromViewController:currentViewController toViewController:selectedVC duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{} completion:^(BOOL finished){
        if (finished)
        {
            currentViewController = selectedVC;
        }
    }];
    [self.view bringSubviewToFront:segment];
}

@end
