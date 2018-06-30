//
//  ShopViewModel.h
//  Dummy-Ecommerce
//
//  Created by Tanjim on 30/6/18.
//  Copyright © 2018 Tanjim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shop.h"
#import "ShopListViewController.h"

@protocol ShopViewModelDelegate<NSObject>

- (void) shopListFetched: (NSArray<Shop *> *) shopList;

@end

@interface ShopViewModel : NSObject

@property (nonatomic,assign) id<ShopViewModelDelegate> delegate;

- (void) requestShopList ;

@end
