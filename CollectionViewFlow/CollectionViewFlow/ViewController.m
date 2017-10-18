//
//  ViewController.m
//  CollectionViewFlow
//
//  Created by paprika on 2017/7/20.
//  Copyright © 2017年 paprika. All rights reserved.
//

#import "ViewController.h"
#import "PAMasonryLayout.h"

static NSString *cellid = @"cellid";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,PAMasonryLayoutDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
    
}

#pragma mark - PAMasonryLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(PAMasonryLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat randomHeight = 100 + (arc4random()%140);
    
    return randomHeight;
    
}

#pragma mark - Lazy Loads

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        PAMasonryLayout *layout = [[PAMasonryLayout alloc] init];
        layout.delegate = self;
        layout.numberOfColumns = 4;
        layout.itemHorizontalSpacing = 10;
        layout.itemVerticalSpacing = 20;

        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor blueColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellid];
        
           }
    
    return _collectionView;
    
}

@end
