//
//  OrderTableViewCell.m
//  Minimarket
//
//  Created by Samat on 04.10.16.
//  Copyright © 2016 Samat. All rights reserved.
//

#import "StudentTableViewCell.h"
#import "Student.h"

@implementation StudentTableViewCell

+ (int)getCellHeightFromObject:(NSObject *)object {
    return 66;
}

- (void)fillCellWithObject:(NSObject *)object options:(NSDictionary *)options delegate:(UniversalTableViewDelegate *)delegate {
    Student *student = (Student *)object;
    
    self.nameLabel.text = student.name;
    self.gpaLabel.text = [NSString stringWithFormat:@"%.02f", student.gpa];
}

- (void)selectedCellWithObject:(NSObject *)object inViewController:(UIViewController *)viewController tableView:(UITableView *)tableView options:(NSDictionary *)options delegate:(UniversalTableViewDelegate *)delegate {
    
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
