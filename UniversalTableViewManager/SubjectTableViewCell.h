//
//  OrderTableViewCell.h
//  Minimarket
//
//  Created by Samat on 04.10.16.
//  Copyright © 2016 Samat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversalTableViewDelegate.h"

@interface SubjectTableViewCell : UITableViewCell <UniversalTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@end
