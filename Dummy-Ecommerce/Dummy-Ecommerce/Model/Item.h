//
//  Item.h
//  Dummy-Ecommerce
//
//  Created by Tanjim on 30/6/18.
//  Copyright © 2018 Tanjim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, strong) NSString *shopID;
@property (nonatomic, strong) NSString *imageURL;
@end
