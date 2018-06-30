//
//  ItemDetailsTableViewCell.h
//  Dummy-Ecommerce
//
//  Created by Tanjim on 30/6/18.
//  Copyright © 2018 Tanjim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
- (IBAction)onButtonPlus:(id)sender;
- (IBAction)onButtonMinus:(id)sender;

@end
