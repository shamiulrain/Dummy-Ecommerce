//
//  ShopListViewController.m
//  Dummy-Ecommerce
//
//  Created by Tanjim on 30/6/18.
//  Copyright © 2018 Tanjim. All rights reserved.
//

#import "ShopListViewController.h"
#import "Shop.h"
#import "ShopTableViewCell.h"
#import "ItemListViewController.h"

@interface ShopListViewController ()<ShopViewModelDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <Shop *> *shopList;

@end

@implementation ShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Shops";
    
    self.shopList = [[NSMutableArray alloc] init];
    
    ShopViewModel *shopViewModel = [[ShopViewModel alloc] init];
    shopViewModel.delegate = self;
    [shopViewModel requestShopList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source and Delegate methods

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    Shop *shop = [self.shopList objectAtIndex:indexPath.row];
    
    static NSString *simpleTableIdentifier = @"shop_cell";
    
    ShopTableViewCell *cell = (ShopTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShopTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if(shop.shopName && shop.shopName.length > 0) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Shop name: %@",shop.shopName];
    }
    
    if(shop.address && shop.address.length > 0) {
        cell.addressLabel.text = [NSString stringWithFormat:@"Address: %@",shop.address];
    }
    
    if(shop.city && shop.city.length > 0) {
        cell.cityLabel.text = [NSString stringWithFormat:@"City: %@",shop.city];
    }
    if((shop.phone && shop.phone.length > 0) && (shop.email && shop.email.length)) {
        cell.phoneEmailLabel.text = [NSString stringWithFormat:@"Contact: "];
        
        if(shop.phone && shop.phone.length > 0) {
            cell.phoneEmailLabel.text = [NSString stringWithFormat:@"%@%@, ",cell.phoneEmailLabel.text,shop.phone];
        }
        
        if(shop.email && shop.email.length > 0) {
            cell.phoneEmailLabel.text = [NSString stringWithFormat:@"%@%@",cell.phoneEmailLabel.text,shop.email];
        }
        
    }
    
    if(shop.imageURL && shop.imageURL.length >0 ) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
                           NSURL *imageURL = [NSURL URLWithString:shop.imageURL];
                           NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                           
                           dispatch_sync(dispatch_get_main_queue(), ^{
                               
                               cell.shopImageView.image= [UIImage imageWithData:imageData];
                           });
                       });
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.shopList.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Shop *selectedShop = [self.shopList objectAtIndex:indexPath.row];
    
    ItemListViewController *itemListVC = [[ItemListViewController alloc] init];
    itemListVC.selectedShop = selectedShop;
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self.navigationController pushViewController:itemListVC animated:YES];
    });
    
    
}

#pragma mark - ShopViewModelDelegate

-(void) shopListFetched:(NSArray<Shop *> *)shopList {
    
    [self.shopList removeAllObjects];
    [self.shopList addObjectsFromArray:shopList];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
    
}

@end
