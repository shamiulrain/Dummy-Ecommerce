//
//  ItemViewModel.h
//  Dummy-Ecommerce
//
//  Created by Tanjim on 30/6/18.
//  Copyright © 2018 Tanjim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@protocol ItemViewModelDelegate<NSObject>

- (void) itemListFetched: (NSArray<Item *> *) itemList forShopId:(NSString *) shopID;

@end

@interface ItemViewModel : NSObject

@property (nonatomic,assign) id<ItemViewModelDelegate> delegate;

- (void) requestItemListForShopID:(NSString *)shopID ;

@end

