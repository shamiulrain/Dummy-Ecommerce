//
//  ItemViewModel.m
//  Dummy-Ecommerce
//
//  Created by Tanjim on 30/6/18.
//  Copyright © 2018 Tanjim. All rights reserved.
//

#import "ItemViewModel.h"
#import "Item.h"

#define itemApiPrefix @"http://192.168.5.214:3000/shops/"
#define itemApiPostfix @"/items"

@interface ItemViewModel() {
    
    NSString *selectedShopID;
}

@end

@implementation ItemViewModel


- (void) requestItemListForShopID:(NSString *)shopID  {
    
    selectedShopID = shopID;
    
    NSString *itemApi = [NSString stringWithFormat:@"%@%@%@",itemApiPrefix,shopID,itemApiPostfix];
    
    NSURL *url = [[NSURL alloc] initWithString:itemApi];
    
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
    
    NSMutableArray<Item *> *itemList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *eachObject in json) {
        
        NSLog(@"Each object: %@",eachObject);
        
        Item *item = [[Item alloc] init];
        
        item.itemID = [NSString stringWithFormat:@"%@", [eachObject objectForKey:@"id"]];
        item.itemName = [NSString stringWithFormat:@"%@", [eachObject objectForKey:@"item_name"]];
        item.shopID = [NSString stringWithFormat:@"%@", [eachObject objectForKey:@"shop_id"]];
        item.category = [NSString stringWithFormat:@"%@",[eachObject objectForKey:@"category"]];
        item.imageURL = [NSString stringWithFormat:@"%@", [eachObject objectForKey:@"image"]];
        item.price= [NSString stringWithFormat:@"%@", [eachObject objectForKey:@"price"]];
        [itemList addObject:item];
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(itemListFetched:forShopId:)]) {
        [self.delegate itemListFetched:itemList forShopId:selectedShopID];
    }
    
}
       
@end

