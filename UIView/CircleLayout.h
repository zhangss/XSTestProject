
/*
     File: CircleLayout.h
 Abstract: 
 
  Version: 1.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2012 Apple Inc. All Rights Reserved.
 
 
 WWDC 2012 License
 
 NOTE: This Apple Software was supplied by Apple as part of a WWDC 2012
 Session. Please refer to the applicable WWDC 2012 Session for further
 information.
 
 IMPORTANT: This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a non-exclusive license, under
 Apple's copyrights in this original Apple software (the "Apple
 Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 */

/*
 CircleLayout的例子稍微复杂一些，cell分布在圆周上，点击cell的话会将其从collectionView中移出，点击空白处会加入一个cell，加入和移出都有动画效果
 通过CircleLayout的实现，可以完整地看到自定义的layout的编写流程，非常具有学习和借鉴的意义。
 */

#import <UIKit/UIKit.h>

@interface CircleLayout : UICollectionViewLayout

@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger cellCount;

/*
 CircleLayout介绍【在UICollectionView中，Layout非常重要】
 
 CircleLayout继承自UICollectionViewLayout，在这里先简单介绍一下UICollectionViewLayout
 UICollectionViewLayout类是一个抽象基类，通过继承它以生成collection view的layout信息。layout对象的职责就是
 决定collection view中cells，supplementary views和decoration views的位置，当collection view请求这些信
 息时，layout对象会提供给collection view。collection view就使用laout对象提供的信息把相关的view显示在屏幕
 上。
 
 注意：要使用UICollectionViewLayout必须先子类化它
 
 子类化时需要注意的事项：
 layout对象不负责创建views，它只提供layout（布局），view的创建是在collection view的data source中。layout
 对象定义了view的位置和size等布局属性。
 
 collection view有三种可视元素需要layout：
 Cells：cells是layout管理的主要元素。每一个cell代表了collection view中的单个数据item。一个collection view
 可以把cell放到一个section中，也可以把cell分为多个section。layout的主要职责就是组织collection view的
 cells。
 
 Supplementary([ˌsʌpləˈment(ə)ri]增补的,追加的) views：supplementary view也显示数据，但是与cells不同。
 并不像cell，supplementary view不可以被用户选择。相反，可以使用supplementary view来给一个section实现类似页
 眉和页脚，当然不仅仅是section，也可以是整个collection view。supplementary view是可选的，并且他们的使用和位
 置是由layout对象定义的。
 
 Decoration([ˌdekəˈreɪʃ(ə)n]装饰) views：decoration view是用于装饰的，不可以被用户选择，并且它的相关数据没
 有与collection view绑定。decoration view是另外一种supplementary view。类似supplementary view，
 decoration view也是可选的，并且他们的使用和位置是由layout对象定义的。
 
 collection view会在许多不同时间里面，请求这些元素的layout对象以获得相关 layout信息。每一个出现在屏幕中的cell
 和view的位置是有layout对象提供的。类似的，每次从collection view中插入或者删除item，相应的layout也会被添加或
 者移除。当然，collection view总是会限制layout对象数目：即只针对屏幕的可视范围。
 
 需要重载的方法
 每个layout对象都需要实现下面的方法：
 collectionViewContentSize
 shouldInvalidateLayoutForBoundsChange:
 layoutAttributesForElementsInRect:
 layoutAttributesForItemAtIndexPath:
 layoutAttributesForSupplementaryViewOfKind:atIndexPath: (如果layout 支持 supplementary views)
 layoutAttributesForDecorationViewWithReuseIdentifier:atIndexPath: (如果layout 支持 decoration views)
 
 这些方法具体作用，可以查阅相关的sdk即可知晓。
 当collection view中的数据发生了改变，如插入或删除item，那么collection view会请求这些item的layout对象，以更
 新layout信息。特别是，任意的item被移动，添加或者删除了，必须要有它相关的layout信息来更新相关的新位置。对于移动一
 个items，collection view会使用标准的方法来检索item的layout属性。对于item的插入和删除，collection view会调
 用一些不同的方法，你应该重载这些方法，以提供相关的layout信息：
 initialLayoutAttributesForInsertedItemAtIndexPath:
 initialLayoutAttributesForInsertedSupplementaryElementOfKind:atIndexPath:
 finalLayoutAttributesForDeletedItemAtIndexPath:
 finalLayoutAttributesForDeletedSupplementaryElementOfKind:atIndexPath:
 
 下面的代码中就是使用到了item的插入和删除。所以重载了下面两个方法：
 initialLayoutAttributesForInsertedItemAtIndexPath:
 finalLayoutAttributesForDeletedItemAtIndexPath:
 
 对于layout在collection view中的作用非常重大，你的画面显示什么效果就看你如何定义layout了。更多相关信息还请阅读相关sdk中的内容。在此不再进行详细的讲解。
 */

@end
