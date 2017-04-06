//
//  OrderTableViewCell.m
//  Minimarket
//
//  Created by Samat on 04.10.16.
//  Copyright © 2016 Samat. All rights reserved.
//

#import "HeadingTableViewCell.h"

@implementation HeadingTableViewCell

+ (int)getCellHeightFromObject:(NSObject *)object {
    return 48;
}

- (void)fillCellWithObject:(NSObject *)object options:(NSDictionary *)options delegate:(UniversalTableViewDelegate *)delegate {
    NSString *name;
    if ([object respondsToSelector:@selector(name)]) {
        name = [object valueForKey:@"name"];
    }
    
    self.nameLabel.text = name;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[delegate.displayingObjects indexOfObject:object] inSection:0];
    
    int index = (int)[delegate.firstLevelObjects indexOfObject:delegate.displayingObjects[indexPath.row]];
        
    if ([delegate.statesOfFirstLevelObjects[index] isEqualToString:@"closed"]) {
        self.arrowImageView.image = [UIImage imageNamed:@"expand_more"];
    } else {
        self.arrowImageView.image = [UIImage imageNamed:@"expand_less"];
    }    
}

- (void)selectedCellWithObject:(NSObject *)object inViewController:(UIViewController *)viewController tableView:(UITableView *)tableView options:(NSDictionary *)options delegate:(UniversalTableViewDelegate *)delegate {
    int index = (int)[delegate.firstLevelObjects indexOfObject:object];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    if (delegate.secondLevelObjects==nil && ![delegate.displayingObjects[indexPath.row] isKindOfClass:[delegate.firstLevelObjects[0] class]]) {
        return;
    }
    
    if ([delegate.statesOfFirstLevelObjects[index] isEqualToString:@"opened"]) {
        delegate.statesOfFirstLevelObjects[index] = @"closed";

        [delegate deleteRowsAtFirstLevelIndex:index];        
    } else {
        if (delegate.openOnlyOne) {
            [delegate closeAllFirstLevelObjects];
        }
        
        [delegate insertRowsAtFirstLevelIndex:index];
        
        delegate.statesOfFirstLevelObjects[index] = @"opened";
    }
    
    if ([delegate isHeadingCell:indexPath]) {
        if ([delegate.statesOfFirstLevelObjects[index] isEqualToString:@"closed"]) {
            self.arrowImageView.image = [UIImage imageNamed:@"expand_more"];
        } else {
            self.arrowImageView.image = [UIImage imageNamed:@"expand_less"];
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
