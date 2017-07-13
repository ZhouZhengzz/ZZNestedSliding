//
//  PrimaryTableViewCell.m
//  NestTest
//
//  Created by zhouzheng on 17/1/11.
//  Copyright © 2017年 zhouzheng. All rights reserved.
//

#import "PrimaryTableViewCell.h"
#import "PrimaryCollectionViewCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
static NSString *PrimaryCollectionViewCellID = @"PrimaryCollectionViewCellID";

@interface PrimaryTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UICollectionViewFlowLayout *_layout;
    UICollectionView *_collectionView;
}
@end

@implementation PrimaryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 0.0;
        _layout.minimumLineSpacing = 0.0;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight-64-60);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-60) collectionViewLayout:_layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_collectionView];
        
        [_collectionView registerClass:[PrimaryCollectionViewCell class] forCellWithReuseIdentifier:PrimaryCollectionViewCellID];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PrimaryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PrimaryCollectionViewCellID forIndexPath:indexPath];
    cell.scrolltotop = YES;
    cell.indexPath = indexPath.item;
    
    cell.didEndDraggingBlock = ^(BOOL status) {
        if (status) {
            if (self.didEndDraggingBlock) {
                _didEndDraggingBlock(YES);
            }
        }
    };
    
    return cell;
}


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
