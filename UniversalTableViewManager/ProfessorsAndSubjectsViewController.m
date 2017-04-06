//
//  ProfessorsAndSubjectsViewController.m
//  UniversalTableViewManagerExample
//
//  Created by Samat on 06.04.17.
//  Copyright © 2017 Samat. All rights reserved.
//

#import "ProfessorsAndSubjectsViewController.h"
#import "UniversalTableViewDelegate.h"
#import "DataExample.h"
#import "Professor.h"

@interface ProfessorsAndSubjectsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProfessorsAndSubjectsViewController {
    UniversalTableViewDelegate *delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSMutableArray *professors = [DataExample getSampleData];
    
    NSMutableArray *subjects1 = ((Professor *)professors[0]).subjects;
    NSMutableArray *subjects2 = ((Professor *)professors[1]).subjects;
    NSMutableArray *subjects3 = ((Professor *)professors[2]).subjects;
    
    delegate = [[UniversalTableViewDelegate alloc] initWithFrame:self.view.bounds firstLevelObjects:professors secondLevelObjects:[@[subjects1,subjects2,subjects3] mutableCopy] inViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
