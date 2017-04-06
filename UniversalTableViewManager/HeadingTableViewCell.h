//
//  OrderTableViewCell.h
//  Minimarket
//
//  Created by Samat on 04.10.16.
//  Copyright © 2016 Samat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversalTableViewDelegate.h"

#define kHeadingCellHeight 48

@interface HeadingTableViewCell : UITableViewCell <UniversalTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@end
