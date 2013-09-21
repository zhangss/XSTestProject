
/*
     File: LineLayout.m
 Abstract: Simple flow layout to lay out items in a line.
 
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

#import "LineLayout.h"


#define ITEM_SIZE 200.0

@implementation LineLayout

#define ACTIVE_DISTANCE 200
#define ZOOM_FACTOR 0.3

/*
 在初始化一个UICollectionViewLayout实例后，会有一系列准备方法被自动调用，以保证layout实例的正确。
 
 首先，-(void)prepareLayout将被调用，默认下该方法什么没做，但是在自己的子类实现中，一般在该方法中设定一些必要的layout的结构和初始需要的参数等。
 
 之后，-(CGSize) collectionViewContentSize将被调用，以确定collection应该占据的尺寸。注意这里的尺寸不是指可视部分的尺寸，而应该是所有内容所占的尺寸。collectionView的本质是一个scrollView，因此需要这个尺寸来配置滚动行为。
 
 接下来-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect被调用，这个没什么值得多说的。初始的layout的外观将由该方法返回的UICollectionViewLayoutAttributes来决定。
 
 另外，在需要更新layout时，需要给当前layout发送 -invalidateLayout，该消息会立即返回，并且预约在下一个loop的时候刷新当前layout，这一点和UIView的setNeedsLayout方法十分类似。在-invalidateLayout后的下一个collectionView的刷新loop中，又会从prepareLayout开始，依次再调用-collectionViewContentSize和-layoutAttributesForElementsInRect来生成更新后的布局。
 */

-(id)init
{
    self = [super init];
    if (self)
    {
        /*
         The default size to use for cells.
         If the delegate does not implement the collectionView:layout:sizeForItemAtIndexPath: method, the flow layout uses the value in this property to set the size of each cell. This results in cells that all have the same size.
         The default size value is (50.0, 50.0).
         */
        //每个Item的大小
        self.itemSize = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
        
        /*
         Description
         The scroll direction of the grid表格.
         
         The grid layout scrolls along one axis only, either horizontally or vertically. For the non scrolling axis, the width of the collection view in that dimension serves as starting width of the content.
         
         The default value of this property is UICollectionViewScrollDirectionVertical.
         */
        //滑动的方向
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //self.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        /*
         If the delegate object does not implement the collectionView:layout:insetForSectionAtIndex: method, the flow layout uses the value in this property to set the margins for each section.
         
         Section insets reflect the spacing at the outer edges of the section. The margins affect the initial position of the header view, the minimum space on either side of each line of items, and the distance from the last line to the footer view. The margin insets do not affect the size of the header and footer views in the non scrolling direction.
         
         The default edge insets are all set to 0.
         */
        //ItemVieW 的整体位置 相对屏幕的位移 上 左 下 右
        //确定了缩进，此处为上方和下方各缩进200个point。由于cell的size已经定义了为200×200，因此屏幕上在缩进后就只有一排item的空间了。
        self.sectionInset = UIEdgeInsetsMake(200, 0.0, 200, 0.0);
        //self.sectionInset = UIEdgeInsetsMake(100, 0.0, 300, 0.0);
        //self.sectionInset = UIEdgeInsetsMake(300, 0.0, 100, 0.0);
        //self.sectionInset = UIEdgeInsetsMake(0, 0.0, 300, 0.0);
        
        
        /*
         If the delegate object does not implement the collectionView:layout:minimumLineSpacingForSectionAtIndex: method, the flow layout uses the value in this property to set the spacing between lines in a section.
         
         For a vertically scrolling grid, this value represents the minimum spacing between successive rows. For a horizontally scrolling grid, this value represents the minimum spacing between successive columns. This spacing is not applied to the space between the header and the first line or between the last line and the footer.
         对于垂直滚动的网格，该值表示连续行之间的最小间距。
         对于水平滚动的网格，该值表示连续列之间的最小间距。
         此间距还没有应用到的报头和第一行之间的空间之间，或最后一行和页脚。
         
         
         The default value of this property is 10.0.
         
         水平的是:连续列之间间距的最小值
         垂直的是:连续行之间间距的最小值
         */
        self.minimumLineSpacing = 50.0;
        //self.minimumLineSpacing = 500.0;
        
        /*
         The minimum spacing to use between items in the same row.
         
         If the delegate object does not implement the collectionView:layout:minimumInteritemSpacingForSectionAtIndex: method, the flow layout uses the value in this property to set the spacing between items in the same line.
         
         For a vertically scrolling grid, this value represents the minimum spacing between items in the same row. For a horizontally scrolling grid, this value represents the minimum spacing between items in the same column. This spacing is used to compute how many items can fit in a single line, but after the number of items is determined, the actual spacing may possibly be adjusted upward.
         对于垂直滚动的网格，该值表示在同一行中的项之间的最小间距。
         对于水平滚动的网格，该值表示在同一列中的项目之间的最小间距。
         这个间距是用来计算多少项目可以容纳在一个单一的线，但后的项数被确定时，实际的间隔可能向上调整。
         
         The default value of this property is 10.0.
         
         水平的是:每一行Item之间间距的最小值
         垂直的是:每一列Item之间间距的最小值
         */
        //???:不知道怎么用
        //self.minimumInteritemSpacing = 500.0;
        
        /*
         The default sizes to use for section headers.
         
         If the delegate does not implement the collectionView:layout:referenceSizeForHeaderInSection: method, the flow layout object uses the default header sizes set in this property.
         
         During layout, only the size that corresponds to the appropriate scrolling direction is used. For example, for the vertical scrolling direction, the layout object uses the height value returned by your method. (In that instance, the width of the header would be set to the width of the collection view.) If the size in the appropriate scrolling dimension is 0, no header is added.
         在布局过程中，只有对应于相应的滚动方向的大小使用。例如，对于垂直滚动方向，布局对象使用你的方法返回的高度值。 （在该实例中，标头的宽度将被设置为集合视图的宽度），如果在适当的滚动维度的大小为0时，没有标头被添加。
         
         需要注意根据滚动方向不同，header和footer的高和宽中只有一个会起作用。垂直滚动时section间宽度为该尺寸的高，而水平滚动时为宽度起作用，
         The default size values are (0, 0).
         */
        //页眉 及 页脚 的大小
        //self.headerReferenceSize = CGSizeMake(500.0, 500.0);
        //self.footerReferenceSize = CGSizeMake(500.0, 500.0);
    }
    return self;
}

/*
 Asks the layout object if the new bounds require a layout update.
 
 The default implementation of this method returns NO. Subclasses should override it and return an appropriate value based on whether changes in the bounds of the collection view require changes to the layout of cells and supplementary views.
 当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
 
 对于个别UICollectionViewLayoutAttributes进行调整，以达到满足设计需求是UICollectionView使用中的一种思路。在根据位置提供不同layout属性的时候，需要记得让-shouldInvalidateLayoutForBoundsChange:返回YES，这样当边界改变的时候，-invalidateLayout会自动被发送，才能让layout得到刷新。
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

/*
 Returns the layout attributes for all of the cells and views in the specified rectangle.
 
 Subclasses must override this method and use it to return layout information for all items whose view intersects the specified rectangle. Your implementation should return attributes for all visual elements, including cells, supplementary views, and decoration views.
 
 When creating the layout attributes, always create an attributes object that represents the correct element type (cell, supplementary, or decoration). The collection view differentiates between attributes for each type and uses that information to make decisions about which views to create and how to manage them.
 
 Return: An array of UICollectionViewLayoutAttributes objects representing the layout information for the cells and views. The default implementation returns nil.
 
 -(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
 返回rect中的所有的元素的布局属性
 返回的是包含UICollectionViewLayoutAttributes的NSArray
 UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：
 layoutAttributesForCellWithIndexPath:
 layoutAttributesForSupplementaryViewOfKind:withIndexPath:
 layoutAttributesForDecorationViewOfKind:withIndexPath:
 
 -(UICollectionViewLayoutAttributes )layoutAttributesForItemAtIndexPath:(NSIndexPath)indexPath
 返回对应于indexPath的位置的cell的布局属性
 -(UICollectionViewLayoutAttributes )layoutAttributesForSupplementaryViewOfKind:(NSString)kind atIndexPath:(NSIndexPath *)indexPath
 返回对应于indexPath的位置的追加视图的布局属性，如果没有追加视图可不重载
 -(UICollectionViewLayoutAttributes * )layoutAttributesForDecorationViewOfKind:(NSString)decorationViewKind atIndexPath:(NSIndexPath)indexPath
 返回对应于indexPath的位置的装饰视图的布局属性，如果没有装饰视图可不重载
 
 */
//当前item放大 功能
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    //获取Rect内所有的Item
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    
    //可视范围
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    //循环可视范围内的所有Item 做动画效果
    for (UICollectionViewLayoutAttributes* attributes in array)
    {
        /*
         Returns whether two rectangles intersect.
         
         true if the two specified rectangles intersect; otherwise, false. The first rectangle intersects the second if the intersection of the rectangles is not equal to the null rectangle.
         
         CGRect的用法三例
         1.CGRectOffset使用从源CGRect偏移的原点来创建矩形
         float offset = 25.0;
         CGRect r1 = CGRectMake(100, 100, 100, 100);
         CGRect r2 = CGRectOffset(r1, offset, offset);
         
         2.CGRectIntersectsRect允许我们确定两个矩形是否相交
         float offset = 25.0;
         CGRect r1 = CGRectMake(100, 100, 100, 100);
         CGRect r2 = CGRectMake(150, 150, 100, 100);
         if (CGRectIntersectsRect(r1, r2))
         {
             NSLog(@"intersecting");
         }
         
         3.NSStringFromCGRect可以用来把CGRect显示到控制台
         CGRect r1 = CGRectMake(100, 100, 100, 100);
         NSLog(@"rect:@%",NSStringFromCGRect(r1));
         同样，CGRectFromString允许我们根据一个字符串创建一个CGRect：
         NSString *r = @"{0,0},{100,100}";
         CGRect r1 = CGRectFromString(r);
         */
        //判断frame范围是否相交
        if (CGRectIntersectsRect(attributes.frame, rect))
        {
            /*
             Returns the x- coordinate that establishes the center of a rectangle.
             返回建立一个矩形的中心的x坐标。
             */
//            CGFloat aFloat = CGRectGetMaxX(visibleRect);
//            CGFloat bFloat = attributes.center.x;
//            CGFloat distance = aFloat - bFloat;
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;

            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            if (ABS(distance) < ACTIVE_DISTANCE)
            {
                CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attributes.zIndex = 1;
            }
        }
    }
    return array;
}

/*
 Returns the point at which to stop scrolling.
 
 If you want the scrolling behavior to snap to specific boundaries, you can override this method and use it to change the point at which to stop. For example, you might use this method to always stop scrolling on a boundary between items, as opposed to stopping in the middle of an item.
 如果你想捕捉到特定边界的滚动行为，你可以重写此方法，并用它来改变点停止。例如，您可以使用此方法来停止滚动项目之间的边界，而不是停在中间的一个项目。
 
 Parameters: 
 proposedContentOffset
 The proposed point (in the collection view’s content view) at which to stop scrolling. This is the value at which scrolling would naturally stop if no adjustments were made. The point reflects the upper-left corner of the visible content.
 建议点（集合视图的内容视图中）在停止滚动。这是自然停止滚动时的值，如果不需要进行任何调整。点反映了左上角的可见的内容。
 
 velocity
 The current scrolling velocity along both the horizontal and vertical axes. This value is measured in points per second.
 
 Return: 
 The content offset that you want to use instead. This value reflects the adjusted upper-left corner of the visible area. The default implementation of this method returns the value in the proposedContentOffset parameter.
 */
//自动对齐到网格 功能
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //proposedContentOffset是没有对齐到网格时本来应该停下的位置
    
    CGFloat offsetAdjustment = MAXFLOAT;
    /*
     Returns the width of a rectangle.
     Regardless of whether the width is stored in the CGRect data structure as a positive or negative number, this function returns the width as if the rectangle were standardized. That is, the result is never a negative number.
     */
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    //对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in array)
    {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment))
        {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

/*
 //返回每个Item的大小
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
 
 //返回最小间距
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
 
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
 
 //返回页眉和页脚的大小
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
 
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
 
 //返回整体的位移
 - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
 
 */

@end