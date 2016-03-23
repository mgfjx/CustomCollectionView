//
//  YFCollectionViewLayout.h
//  WaterfallFlowCollection
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 蓝天的梦想. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YFCollectionViewLayout;

@protocol YFCollectionViewLayoutDelegate <NSObject>
@required
- (CGFloat)collectionView:(UICollectionView *) collectionView
                   layout:(YFCollectionViewLayout *)layout
 heightForItemAtIndexPath:(NSIndexPath *) indexPath;

@end

@interface YFCollectionViewLayout : UICollectionViewLayout
/**
 *  列数
 */
@property (nonatomic, assign) NSUInteger numberOfColumns;
/**
 *  间距
 */
@property (nonatomic, assign) CGFloat interItemSpacing;
@property (nonatomic, weak)  id<YFCollectionViewLayoutDelegate> delegate;

@end
