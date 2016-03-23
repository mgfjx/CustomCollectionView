//
//  GridrLayout.h
//  CustomCollectionView
//
//  Created by 谢小龙 on 16/3/23.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridrLayout : UICollectionViewLayout

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat interitemSpacing;
@property (nonatomic, assign) CGFloat lineSpacing;

@property (nonatomic, assign) UIEdgeInsets contentInset;

@end
