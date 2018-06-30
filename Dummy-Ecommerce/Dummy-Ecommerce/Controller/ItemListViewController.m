//
//  ItemListViewController.m
//  Dummy-Ecommerce
//
//  Created by Tanjim on 30/6/18.
//  Copyright © 2018 Tanjim. All rights reserved.
//

#import "ItemListViewController.h"

@interface ItemListViewController ()<ItemViewModelDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray <Item *> *itemList;

@end

@implementation ItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.selectedShop.shopName;
    
    self.itemList = [[NSMutableArray alloc] init];
    
    ItemViewModel *itemViewModel = [[ItemViewModel alloc] init];
    itemViewModel.delegate = self;
    NSString *shopID = [NSString stringWithFormat:@"%ld",[self.selectedShop.shopID integerValue]];
    [itemViewModel requestItemListForShopID:shopID];
}

#pragma mark - ItemViewModelDelegate

-(void) itemListFetched:(NSArray<Item *> *)itemList forShopId:(NSString *)shopID{
    
    [self.itemList removeAllObjects];
    [self.itemList addObjectsFromArray:itemList];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
    
    
}


@end
