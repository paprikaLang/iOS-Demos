//
//  PAMasonryLayout.h
//  CollectionViewFlow
//
//  Created by paprika on 2017/7/20.
//  Copyright © 2017年 paprika. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PAMasonryLayout;

@protocol PAMasonryLayoutDelegate <NSObject>

@required

//数据源提供高度
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(PAMasonryLayout  *)layout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PAMasonryLayout : UICollectionViewLayout

@property(nonatomic,assign) NSUInteger numberOfColumns;
@property(nonatomic,assign) CGFloat itemVerticalSpacing;
@property(nonatomic,assign) CGFloat itemHorizontalSpacing;
@property (nonatomic,weak) id<PAMasonryLayoutDelegate>delegate;

@end
