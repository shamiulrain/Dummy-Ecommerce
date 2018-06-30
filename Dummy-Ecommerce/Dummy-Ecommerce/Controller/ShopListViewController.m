//
//  ShopListViewController.m
//  Dummy-Ecommerce
//
//  Created by Tanjim on 30/6/18.
//  Copyright © 2018 Tanjim. All rights reserved.
//

#import "ShopListViewController.h"
#import "Shop.h"

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

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shop_cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"shop_cell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = @"test";
        
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.shopList.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
