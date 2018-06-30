//
//  ItemListViewController.m
//  Dummy-Ecommerce
//
//  Created by Tanjim on 30/6/18.
//  Copyright © 2018 Tanjim. All rights reserved.
//

#import "ItemListViewController.h"
#import "ItemCollectionViewCell.h"
#import "ItemDetailsViewController.h"

@interface ItemListViewController ()<ItemViewModelDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray <Item *> *itemList;

@end

@implementation ItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.selectedShop.shopName;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cart" style:UIBarButtonItemStylePlain target:self action:@selector(onButtonCart)];
    
    self.itemList = [[NSMutableArray alloc] init];
    
    static NSString *identifier = @"item_cell";
    [self.collectionView registerNib:[UINib nibWithNibName:@"ItemCollectionViewCell" bundle:[NSBundle mainBundle]]
        forCellWithReuseIdentifier:@"item_cell"];
    
    ItemViewModel *itemViewModel = [[ItemViewModel alloc] init];
    itemViewModel.delegate = self;
    NSString *shopID = [NSString stringWithFormat:@"%ld",[self.selectedShop.shopID integerValue]];
    [itemViewModel requestItemListForShopID:shopID];
}

- (void) onButtonCart {
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        ItemDetailsViewController *itemDetailsVC = [[ItemDetailsViewController alloc] init];
        [self.navigationController pushViewController:itemDetailsVC animated:YES];
    });
}

#pragma mark - CollectionView methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Item *item = [self.itemList objectAtIndex:indexPath.row];
    
    static NSString *identifier = @"item_cell";
    
    ItemCollectionViewCell *cell = (ItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemCollectionViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if(item.itemName && item.itemName.length > 0) {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",item.itemName];
    }
    
    if(item.price) {
        cell.priceLabel.text = [NSString stringWithFormat:@"Price: %@",item.price];
    }
    
    if(item.imageURL && item.imageURL.length >0 ) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
                           NSURL *imageURL = [NSURL URLWithString:item.imageURL];
                           NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                           
                           dispatch_sync(dispatch_get_main_queue(), ^{
                               
                               cell.itemImageView.image= [UIImage imageWithData:imageData];
                           });
                       });
    }
    
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(200, 200);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Item *item = [self.itemList objectAtIndex:indexPath.row];
    
    NSString *msg = [NSString stringWithFormat:@"How many of %@ you want?",item.itemName];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                                    textField.placeholder = @"How many?";
                                }];
    
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault   handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textfield = alert.textFields.firstObject;
        
    }];
    UIAlertAction *noneAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:doneAction];
    [alert addAction:noneAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:^{
            [self.collectionView reloadData];
        }];
    });
    
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
