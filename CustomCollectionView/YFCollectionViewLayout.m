//
//  YFCollectionViewLayout.m
//  WaterfallFlowCollection
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 蓝天的梦想. All rights reserved.
//

#import "YFCollectionViewLayout.h"

@interface YFCollectionViewLayout ()
/**
 *  最后列的Y值
 */
@property (nonatomic, strong) NSMutableDictionary *lastYValueForColumn;
/**
 * 布局信息
 */
@property (nonatomic, strong) NSMutableDictionary *layoutInfo;
@end

@implementation YFCollectionViewLayout


/**
 *  布局准备方法，可以把一些计算的东西放到这里
 */
-(void) prepareLayout {
    
     [super prepareLayout];
    
    self.lastYValueForColumn = [NSMutableDictionary dictionary];
    CGFloat currentColumn = 0;
    CGFloat fullWidth = self.collectionView.frame.size.width;
    CGFloat availableSpaceExcludingPadding = fullWidth - (self.interItemSpacing * (self.numberOfColumns + 1));
    CGFloat itemWidth = availableSpaceExcludingPadding / self.numberOfColumns;
    self.layoutInfo = [NSMutableDictionary dictionary];
    NSIndexPath *indexPath;
    NSInteger numSections = [self.collectionView numberOfSections];
    
    for(NSInteger section = 0; section < numSections; section++)  {
        
        NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
        for(NSInteger item = 0; item < numItems; item++){
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            CGFloat x = self.interItemSpacing + (self.interItemSpacing + itemWidth) * currentColumn;
            CGFloat y = [self.lastYValueForColumn[@(currentColumn)] doubleValue];
            CGFloat height = [((id<YFCollectionViewLayoutDelegate>)self.collectionView.delegate)
                              collectionView:self.collectionView
                              layout:self
                              heightForItemAtIndexPath:indexPath];
            
            itemAttributes.frame = CGRectMake(x, y, itemWidth, height);
            y+= height;
            y += self.interItemSpacing;
            
            self.lastYValueForColumn[@(currentColumn)] = @(y);
            
            currentColumn ++;
            if(currentColumn == self.numberOfColumns) currentColumn = 0;
            self.layoutInfo[indexPath] = itemAttributes;
        }
    }
}

/**
 *  每个子控件的一些属性
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
   NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                         UICollectionViewLayoutAttributes *attributes,
                                                         BOOL *stop) {
        
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [allAttributes addObject:attributes];
        }
    }];
    return allAttributes;
}

/**
 *  集合视图整体大小
 *
 */
-(CGSize) collectionViewContentSize {
    
    NSUInteger currentColumn = 0;
    CGFloat maxHeight = 0;
    do {
        CGFloat height = [self.lastYValueForColumn[@(currentColumn)] doubleValue];
        if(height > maxHeight)
            maxHeight = height;
        currentColumn ++;
    } while (currentColumn < self.numberOfColumns);
    
    return CGSizeMake(self.collectionView.frame.size.width, maxHeight);
}

@end
