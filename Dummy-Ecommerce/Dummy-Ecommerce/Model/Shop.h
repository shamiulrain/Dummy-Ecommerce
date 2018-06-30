//
//  Shop.h
//  Dummy-Ecommerce
//
//  Created by Tanjim on 30/6/18.
//  Copyright © 2018 Tanjim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *email;

@end
