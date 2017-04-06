//
//  StudentsOfSubjectViewController.m
//  UniversalTableViewManagerExample
//
//  Created by Samat on 06.04.17.
//  Copyright © 2017 Samat. All rights reserved.
//

#import "StudentsOfSubjectViewController.h"
#import "UniversalTableViewDelegate.h"

@interface StudentsOfSubjectViewController ()

@end

@implementation StudentsOfSubjectViewController {
    UniversalTableViewDelegate *delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];

    NSMutableArray *objects = [NSMutableArray new];
    [objects addObject:self.subject];
    [objects addObjectsFromArray:self.subject.students];
    
    delegate = [[UniversalTableViewDelegate alloc] initWithFrame:self.view.bounds objects:objects inViewController:self];
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
