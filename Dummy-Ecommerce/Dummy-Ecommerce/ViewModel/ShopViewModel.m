//
//  ShopViewModel.m
//  Dummy-Ecommerce
//
//  Created by Tanjim on 30/6/18.
//  Copyright © 2018 Tanjim. All rights reserved.
//

#import "ShopViewModel.h"
#import "Shop.h"

#define shopApi @"http://192.168.5.214:3000/shops"

@implementation ShopViewModel

- (void) requestShopList {
    
    NSURL *url = [[NSURL alloc] initWithString:shopApi];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            
            
        } else {
            
            NSError* jsonError;
            NSArray* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&jsonError];
            
            if(!jsonError) {
                [self parseJson:json];
            }
            
            
            
        }
    }];
}

-(void) parseJson:(NSArray *) json {
    
    NSMutableArray<Shop *> *shopList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *eachObject in json) {
        
        NSLog(@"Each object: %@",eachObject);
        
        Shop *shop = [[Shop alloc] init];
        
        shop.id = [NSString stringWithFormat:@"%@", [eachObject objectForKey:@"id"]];
        shop.shopName = [NSString stringWithFormat:@"%@", [eachObject objectForKey:@"shop_name"]];
        shop.address = [NSString stringWithFormat:@"%@", [eachObject objectForKey:@"address"]];
        shop.city = [NSString stringWithFormat:@"%@",[eachObject objectForKey:@"city"]];
        shop.imageURL = [NSString stringWithFormat:@"%@", [eachObject objectForKey:@"image"]];
        
        
        NSString *email = [NSString stringWithFormat:@"%@", [eachObject objectForKey:@"email"]];
        NSString *phone = [NSString stringWithFormat:@"%@", [eachObject objectForKey:@"phone"]];
        
        if(![email isEqualToString:@"<null>"]) {
            shop.email = email;
        }
        
        if(![phone isEqualToString:@"<null"]) {
            shop.phone = phone;
        }
        
        [shopList addObject:shop];
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(shopListFetched:)]) {
        [self.delegate shopListFetched:shopList];
    }
    
}

@end
