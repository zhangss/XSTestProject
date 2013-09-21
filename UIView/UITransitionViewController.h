//
//  UITransitionViewController.h
//  XSTestProject
//
//  Created by 张松松 on 13-3-1.
//
//

#import <UIKit/UIKit.h>

@interface UITransitionViewController : UIViewController
{
    UIViewController *currentViewController;
}

/*
 ViewController之间的切换
 
 IOS5新增方法
 在iOS5中，ViewController中新添加了下面几个方法：
 addChildViewController:
 removeFromParentViewController
 transitionFromViewController:toViewController:duration:options:animations:completion:
 willMoveToParentViewController:
 didMoveToParentViewController:
 下面详细介绍一下addChildViewController，一个ViewController可以添加多个子ViewController，但是这些子ViewController只有一个是显示到父视图中的，可以通过transitionFromViewController:toViewController:duration:options:animations:completion:这个方法转换显示的子视图。同时加入相应的动画。
 
 IOS5更新的原因
 原来的问题
 这些新增的方法和属性用于改进我们的编程方式。那么让我们先看看以前的对于UIViewController的使用有什么潜在的问题，认清问题，我们才能理解苹果改变的意义。
 在以前，一个UIViewController的View可能有很多小的子view。这些子view很多时候被盖在最后，我们在最外层ViewController的viewDidLoad方法中，用addSubview增加了大量的子view。这些子view大多数不会一直处于界面上，只是在某些情况下才会出现，例如登陆失败的提示view，上传附件成功的提示view，网络失败的提示view等。但是虽然这些view很少出现，但是我们却常常一直把它们放在内存中。另外，当收到内存警告时，我们只能自己手工把这些view从super view中去掉。
 
 改变
 苹果新的API增加了addChildViewController方法，并且希望我们在使用addSubview时，同时调用[self addChildViewController:child]方法将sub view对应的viewController也加到当前ViewController的管理中。对于那些当前暂时不需要显示的subview，只通过addChildViewController把subViewController加进去。需要显示时再调用transitionFromViewController:toViewController:duration:options:animations:completion方法。
 
 另外，当收到系统的Memory Warning的时候，系统也会自动把当前没有显示的subview unload掉，以节省内存。
 

 Pay Attention
 
 The addChildViewController: method automatically calls the willMoveToParentViewController: method of the view controller to be added as a child before adding it, but it does not call the didMoveToParentViewController: method. Your container view controller class must call the didMoveToParentViewController: of the child view controller after the transition to the new child is complete or, if there is no transition, immediately after calling the addChildViewController: method.
 
 Likewise, the container view controller must call the willMoveToParentViewController: method before calling the removeFromParentViewController method. The removeFromParentViewController method automatically calls the didMoveToParentViewController: method of the child view controller.
 
 苹果对UIViewController以及其使用有着非常详细的文档 UIViewController Reference , ViewController Programming Guide 。
 
 一.UIViewController
 作为iOS开发, 经常会和UIViewController打交道，从类名便可知道UIViewController属于MVC模型中的C(Controller)，说的更具体点它是一个视图控制器,管理着一个视图(view)。
 
 UIViewController的view是lazy loading的,当你访问其view属性的时候，它会从xib文件载入或者通过代码创建(覆盖loadView方法,自定义其view hierarchy),并返回view对象,如果要判断一个View Controller的view是否已经被加载需要通过其提供的isViewLoaded方法来判断。
 view加载后viewDidLoad会被调用，这里可以进行一些数据的请求或加载，用来更新你的界面。
 当view将被加入view hierarchy中的时候viewWillAppear会被调用,view完成加入的时候viewDidAppear会被调用，同样当view将要从view hierarchy中移除的时候viewWillDisappear会被调用，完成移除的时候viewDidDisappear会被调用。
 当内存紧张的时候，所有的UIViewController对象的didReceiveMemoryWarning会被调用,其默认实现是 如果当前viewController的view的superview是nil的话，则将view释放且viewDidUnload会被调用,viewDidUnload中你可以进行后继的内存清理工作(主要是界面元素的释放，当再次加载的时候需要重建)。
 
 如果想要展示一个View Controller,一般有如下一种途径
 
 设置成UIWindow的rootViewController(iOS 4.0之前UIWindow并没有rootViewController属性，只能通过addSubview的方式添加一个View Controller的view)
 使用某个已经存在的Container来展示，比如使用UINavigationController来展示某个View Controller [navigationController pushViewController:vc animated:YES];
 以模态界面的方式展现出来 presentModalViewController
 以addSubview的方式将使其view作为另一个View Controller的view的subView
 直接使用4种方法是比较危险的,上一级 View Controller并不能对当前View Controller的 生命周期相关的函数进行调用，以及旋转事件的传递等。
 
 二.Container
 一个iOS的app很少只由一个ViewController组成，除非这个app极其简单。 当有多个View Controller的时候，我们就需要对这些View Controller进行管理。 那些负责一个或者多个View Controller的展示并对其视图生命周期进行管理的对象，称之为容器，大部分容器本身也是一个View Controller，这样的容器可以称之为Container View Controller，有个别容器不是View Controller，比如UIPopoverController其继承于NSObject。 我们常用的容器有 UINavigationController,UITabbarController等，一般容器有一些共同的特征:
 
 提供对Child View Controller进行管理的接口，比如添加Child View Controller,切换Child View Controller的显示,移除Child View Controller 等
 容器“拥有”所有的Child View Controller
 容器需要负责 Child View Controller的appearance callback的调用(viewWillAppear,viewDidAppear,viewWillDisaapper,viewDidDisappear),以及旋转事件的传递
 保证view hierarchy 和 view controller hierarchy 层级关系一致,通过parent view controller将child view controller和容器进行关联
 从上面可以看出来,实现一个Container View Controller并不是一个简单的事情,好在iPhone的界面大小有限，一般情况下一个View Controller的view都是充满界面或者系统自带容器的，我们无需自己创建额外的容器。
 
 在iPhone上由于界面本身比较小，一般View Controller的view都是填充满的，所以系统自带的容器就够用了。但是在iPad中情况就不同了。
 
 三.Custom Container View Controller
 在iOS 5之前框架并不支持自定义 Container View Controller, iOS 5开始开放了一些新的接口来支持支持自定义容器
 
 addChildViewController:
 removeFromParentViewController
 transitionFromViewController:toViewController:duration:options:animations:completion:
 willMoveToParentViewController:
 didMoveToParentViewController:
 有点意外的是，在不做任何额外设置的情况下进行如下操作
 
 [viewController.view addSubview:otherViewController.view]
 iOS 5中otherViewController是可以立刻收到viewWillAppear和viewDidAppear的调用。
 
 至于旋转事件的传递以及其他时机viewWillAppear viewDidAppear的调用是需要建立在 [viewController addChildViewController:otherViewController]基础上的。
 
 当我们需要在iOS 4上实现自定义容器，或者有时候我们不想让viewWillAppear这类方法被自动调用，而是想自己来控制，这个时候我们就得需要手动来调用这些方法，而不是由框架去自动调用。 iOS 5中可以很方便的禁用掉自动调用的特性，覆盖automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers返回NO
 
 但是单单覆盖这个方法在iOS5下还是有问题的，
 
 [viewController.view addSubview:otherViewController.view]
 otherViewController还是是可以立刻收到viewWillAppear和viewDidAppear的调用。
 解决这一问题的方法就是在iOS5的时候调用[viewController.view addSubview:otherViewController.view]之前 进行如下操作
 
 [viewController addChildViewController:otherViewController]
 实现兼容iOS 4和iOS 5的容器还是有不少问题和注意点的
 
 view加入view层级前后分别调用viewWillAppear和viewDidAppear;容器的viewWillAppear，viewDidAppear,viewWillDisappear,viewDidDisappear中需要对当前显示的Child View Controller调用相同的方法
 容器的shouldAutorotateToInterfaceOrientation中需要检测每一个Child View Controller的shouldAutorotateToInterfaceOrientation如果一个不支持，则看做不支持
 容器的willRotateToInterfaceOrientation，didRotateFromInterfaceOrientation，willAnimateRotationToInterfaceOrientation方法中需要将事件传递给所有的Child View Controller
 由于UIViewController的parentViewController属性为只读，且iOS4中没有提供容器支持的接口（iOS 5中容器支持的接口会间接的维护这个属性），所以为了使得childViewController和容器得以关联，我们可以顶一个View Controller的基类，添加一个比如叫做superController的属性用来指定对应的parentViewController
 由于UIViewController的interfaceOrientation为只读属性，且iOS5中没有提供容器接口，所以UIViewController的这个interfaceOrientation变的不可性，为了取得当前UIViewController的orientation我们可以用UIWindow下的rootViewController的interfaceOrientation的值
 容器的viewDidUnload方法中需要对view未释放的childViewController的view进行释放，且调用其viewDidUnload方法
 */

@end
