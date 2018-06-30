//
//  ItemListViewController.h
//  Dummy-Ecommerce
//
//  Created by Tanjim on 30/6/18.
//  Copyright © 2018 Tanjim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemViewModel.h"
#import "Item.h"
#import "Shop.h"

@interface ItemListViewController : UIViewController

@property (nonatomic, strong) Shop *selectedShop;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
