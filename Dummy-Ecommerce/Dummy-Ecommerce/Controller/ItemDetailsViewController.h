//
//  ItemDetailsViewController.h
//  Dummy-Ecommerce
//
//  Created by Tanjim on 30/6/18.
//  Copyright © 2018 Tanjim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

- (IBAction)onButtonPlus:(id)sender;
- (IBAction)onButtonMinus:(id)sender;

@end
