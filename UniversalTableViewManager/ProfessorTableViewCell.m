//
//  OrderTableViewCell.m
//  Minimarket
//
//  Created by Samat on 04.10.16.
//  Copyright © 2016 Samat. All rights reserved.
//

#import "ProfessorTableViewCell.h"
#import "Professor.h"

@implementation ProfessorTableViewCell

+ (int)getCellHeightFromObject:(NSObject *)object {
    return 105;
}

- (void)fillCellWithObject:(NSObject *)object options:(NSDictionary *)options delegate:(UniversalTableViewDelegate *)delegate {
    Professor *professor = (Professor *)object;
    
    self.nameLabel.text = professor.name;
    self.degreeLabel.text = professor.degree;
    self.mainInterestLabel.text = professor.mainInterest;
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
