//
//  OrderTableViewCell.h
//  Minimarket
//
//  Created by Samat on 04.10.16.
//  Copyright © 2016 Samat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversalTableViewDelegate.h"

@interface StudentTableViewCell : UITableViewCell <UniversalTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gpaLabel;

@end
