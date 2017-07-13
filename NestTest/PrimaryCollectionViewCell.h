//
//  PrimaryCollectionViewCell.h
//  NestTest
//
//  Created by zhouzheng on 17/1/11.
//  Copyright © 2017年 zhouzheng. All rights reserved.
//collectionView的cell

#import <UIKit/UIKit.h>

typedef void(^DidEndDraggingBlock)(BOOL status);

@interface PrimaryCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) DidEndDraggingBlock didEndDraggingBlock;

@property (nonatomic, assign) NSInteger indexPath;
@property (nonatomic, assign) BOOL scrolltotop;

@end
