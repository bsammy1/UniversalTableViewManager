//
//  OrderTableViewCell.m
//  Minimarket
//
//  Created by Samat on 04.10.16.
//  Copyright © 2016 Samat. All rights reserved.
//

#import "SubjectTableViewCell.h"
#import "Subject.h"
#import "StudentsOfSubjectViewController.h"

@implementation SubjectTableViewCell

+ (int)getCellHeightFromObject:(NSObject *)object {
    return 74;
}

- (void)fillCellWithObject:(NSObject *)object options:(NSDictionary *)options delegate:(UniversalTableViewDelegate *)delegate {
    Subject *subject = (Subject *)object;
    
    self.nameLabel.text = subject.name;
    self.codeLabel.text = subject.code;
}

- (void)selectedCellWithObject:(NSObject *)object inViewController:(UIViewController *)viewController tableView:(UITableView *)tableView options:(NSDictionary *)options delegate:(UniversalTableViewDelegate *)delegate {
    StudentsOfSubjectViewController *svc = [StudentsOfSubjectViewController new];
    
    svc.subject = (Subject *)object;
    
    [viewController.navigationController pushViewController:svc animated:YES];
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
