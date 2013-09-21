//
//  XSCircleLayout.m
//  XSTestProject
//
//  Created by 张松松 on 13-2-28.
//
//

#import "XSCircleLayout.h"

#define ITEM_SIZE 70

@interface XSCircleLayout ()

//存储增加和删除的项
@property (nonatomic,retain)NSMutableArray *deleteIndexPaths;
@property (nonatomic,retain)NSMutableArray *insertIndexPaths;

@end

@implementation XSCircleLayout
@synthesize cellCount;
@synthesize center;
@synthesize radius;

- (void)prepareLayout
{
    [super prepareLayout];
    
    CGSize size = self.collectionView.frame.size;
    cellCount = [self.collectionView numberOfItemsInSection:0];
    center = CGPointMake(size.width / 2.0, size.height / 2.0);
    radius = MIN(size.width, size.height) / 2.5;
}

#pragma mark - 
#pragma mark UICollectionViewLayout 子类必须重写方法
- (CGSize)collectionViewContentSize
{
    //CollectionView的fram大小
    return self.collectionView.frame.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //生成空白的attributes对象，其中只记录了类型是cell以及对应的位置是indexPath
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //配置attribute位置 在圆周上
    attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
    attributes.center = CGPointMake(center.x + radius * cosf(2 * indexPath.item * M_PI / cellCount), center.y + radius * sinf(2 * indexPath.item * M_PI / cellCount));
    
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [NSMutableArray arrayWithCapacity:3];
    for (NSInteger i = 0; i < cellCount; i++)
    {
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:index]];
    }
    
    return attributes;
}

#pragma mark -
#pragma mark 比较复杂的动画实现
#pragma mark 插入和删除动作
- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
    
    self.deleteIndexPaths = [NSMutableArray array];
    self.insertIndexPaths = [NSMutableArray array];
    for (UICollectionViewUpdateItem *aItem in updateItems)
    {
        if (aItem.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deleteIndexPaths addObject:aItem.indexPathBeforeUpdate];
        }
        else if (aItem.updateAction == UICollectionUpdateActionInsert)
        {
            [self.insertIndexPaths addObject:aItem.indexPathAfterUpdate];
        }
    }
}

- (void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    
    self.deleteIndexPaths = nil;
    self.insertIndexPaths = nil;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    //此处必须调用父类方法
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];

    //只对插入操作 做下列动作
    if ([self.insertIndexPaths containsObject:itemIndexPath])
    {
        if (!attributes)
        {
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        }
        
        //动画初始位置 全透明 中心位置为view的中心
        attributes.alpha = 0.0;
        attributes.center = center;
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    //只对删除操作
    if ([self.deleteIndexPaths containsObject:itemIndexPath])
    {
        if (!attributes)
        {
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        }
        
        //动画结束位置 全透明 中心位置为View中心 大小缩小为0.1
        attributes.alpha = 0.0;
        attributes.center = center;
        attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    }
    return attributes;
}

#pragma mark -
#pragma mark 简单的动画实现
#pragma mark 插入 / 删除Item
///*
// 插入前，cell在圆心位置，全透明
// */
//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//    attributes.alpha = 0.0;
//    attributes.center = center;
//    return attributes;
//}
//
////删除时，cell在圆心位置，全透明，且只有原来的1/10大
//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//    attributes.alpha = 0.0;
//    attributes.center = center;
//    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
//    return attributes;
//}

@end
