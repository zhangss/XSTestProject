//
//  XSLineLayout.m
//  XSTestProject
//
//  Created by 张松松 on 13-2-27.
//
//

#import "XSLineLayout.h"

#define ITEM_SIZE 200.0

#define ACTIVE_DISTANCE 200.0
#define ZOOM_FACTOR 0.3

@implementation XSLineLayout

-(id)init
{
    self = [super init];
    if (self)
    {
        self.itemSize = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
        
        //self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical)
        {
            self.minimumLineSpacing = 40.0;
            /*
             collectionView会有一个默认的偏移 当设置的偏移小于默认偏移时 以默认偏移为准
             如设置UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0),不会生效;
             设置UIEdgeInsetsMake(0.0, 100.0, 0.0, 0.0)即可生效。
             垂直模式下默认偏移 >10  < 100;
             */
            self.sectionInset = UIEdgeInsetsMake(20.0, 0.0, 20.0, 0.0);
        }
        else
        {
            self.minimumLineSpacing = 40.0;
            //两行
//            self.sectionInset = UIEdgeInsetsMake(40.0, 10.0, 40.0, 10.0);
            
            //一行
            self.sectionInset = UIEdgeInsetsMake(200.0, 0.0, 200.0, 0.0);
        }
        /*
         UICollectionViewScrollDirectionHorizontal 对此起作用 top及bottom
         */
//        self.sectionInset = UIEdgeInsetsMake(30.0, 0.0, 30.0, 0.0);
        
        /*
         UICollectionViewScrollDirectionHorizontal 对此起作用
         水平模式: 每列间隔
         垂直模式:每行间隔
         */
//        self.minimumLineSpacing = 100.0;
        
        //???:没什么作用
        //self.minimumInteritemSpacing = 100.0;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

/*
 Returns the layout attributes for all of the cells and views in the specified rectangle.
 Subclasses must override this method and use it to return layout information for all items whose view intersects the specified rectangle. Your implementation should return attributes for all visual elements, including cells, supplementary views, and decoration views.
 When creating the layout attributes, always create an attributes object that represents the correct element type (cell, supplementary, or decoration). The collection view differentiates between attributes for each type and uses that information to make decisions about which views to create and how to manage them.
 返回的布局属性，在指定的矩形中的所有cell和View。
 子类必须重写此方法，并用它来返回与指定的矩形相交的所有项目的布局信息。你的实现应该返回属性的所有视觉元素，包括细胞，补充意见，装饰景观。
 在创建布局属性，创建一个属性对象，它代表正确的单元类型（细胞，补充，或饰）。集合视图属性之间的区别，每种类型和使用这些信息来作出决定的意见如何创建和管理他们。
 
 rect
 The rectangle (specified in the collection view’s coordinate system) containing the target views.
 */
//放大
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{    
    //内容区域范围(contentSize)
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    
    //当前可视范围
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array)
    {
//        NSLog(@"Orign:%@ AndVisibleRect:%@",NSStringFromCGRect(rect),NSStringFromCGRect(visibleRect));
//        NSLog(@"ItemCount:%d",[array count]);
        
        //判断是否相交 两个矩形
        if (CGRectIntersectsRect(attributes.frame, rect))
        {
            //计算两个矩形的中心 间距
            CGFloat distance = 0.0;
            if (self.scrollDirection == UICollectionViewScrollDirectionVertical)
            {
                distance = CGRectGetMidY(visibleRect) - attributes.center.y;
            }
            else
            {
                distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            }
            
            //开始做动画的范围???:滚动距离足够 开始方法
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            if (ABS(distance) < ACTIVE_DISTANCE)
            {
                CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                
                /*Specifies the item’s position on the z axis.*/
                attributes.zIndex = 1;
            }
        }
    }
    return array;
}

//自动对齐到网格 相当于pagScroll 滚动到某个范围时 手动滚动到某个Item
//没拖动一次 调用一次
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //自然停止滚动的位置值proposedContentOffset
    NSLog(@"Start:%@",NSStringFromCGPoint(proposedContentOffset));
    CGPoint returnPoint = CGPointZero;
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical)
    {
        CGFloat offsetAdjustment = MAXFLOAT; //默认为最大浮点数
        
        //自然停止滚动的中心位置
        CGFloat verticalCenter = proposedContentOffset.y + (CGRectGetHeight(self.collectionView.bounds) / 2.0);
        
        //自然停止滚动的可视范围 及其可视的Item
        CGRect targetRect = CGRectMake(0.0, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
        NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
        
        //循环遍历Item
        for (UICollectionViewLayoutAttributes *layoutAttributes in array)
        {
            //当前的Item的中心位置
            CGFloat itemVerticalCenter = layoutAttributes.center.y;
            
            //更新偏移位置
            if (ABS(itemVerticalCenter - verticalCenter) < ABS(offsetAdjustment))
            {
                offsetAdjustment = itemVerticalCenter - verticalCenter;
            }
        }
        
        //根据偏移位置获取 对其后的 调整位置 返回使该Item停止在这个点
        returnPoint = CGPointMake(proposedContentOffset.x, proposedContentOffset.y + offsetAdjustment);
    }
    else
    {
        CGFloat offsetAdjustment = MAXFLOAT;
        
        CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
        /*
         Returns the width of a rectangle.
         Regardless of whether the width is stored in the CGRect data structure as a positive or negative number, this function returns the width as if the rectangle were standardized. That is, the result is never a negative number.
         */
        CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
        NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
        
        for (UICollectionViewLayoutAttributes* layoutAttributes in array)
        {
            CGFloat itemHorizontalCenter = layoutAttributes.center.x;
            if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment))
            {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter;
            }
        }
        returnPoint = CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);

    }
    NSLog(@"Return:%@",NSStringFromCGPoint(returnPoint));
    return returnPoint;
}

@end
