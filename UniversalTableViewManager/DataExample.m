//
//  DataExample.m
//  UniversalTableViewManagerExample
//
//  Created by Samat on 06.04.17.
//  Copyright © 2017 Samat. All rights reserved.
//

#import "DataExample.h"
#import "Professor.h"
#import "Subject.h"
#import "Student.h"

@implementation DataExample

+ (NSMutableArray *)getSampleData {
    NSMutableArray *professors = [NSMutableArray new];
    
    Student *student1 = [Student new];
    student1.name = @"Stan Marsh";
    student1.gpa = 3.65;
    Student *student2 = [Student new];
    student2.name = @"Kyle Broflovski";
    student2.gpa = 4.00;
    Student *student3 = [Student new];
    student3.name = @"Eric Cartman";
    student3.gpa = 2.04;
    Student *student4 = [Student new];
    student4.name = @"Kenny McCormick";
    student4.gpa = 3.13;
    Student *student5 = [Student new];
    student5.name = @"Butters Stotch";
    student5.gpa = 3.95;
    NSArray *sampleStudents = @[student1, student2, student3, student4, student5];
    
    Professor *professor1 = [Professor new];
    professor1.name = @"Hal Abelson";
    professor1.degree = @"PhD";
    professor1.mainInterest = @"Cybersecurity";
    professor1.subjects = [NSMutableArray new];
    
    Subject *subject11 = [Subject new];
    subject11.name = @"Cybersecurity 1";
    subject11.code = @"CBS1001";
    subject11.students = [NSMutableArray new];
    [subject11.students addObjectsFromArray:sampleStudents];
    
    Subject *subject12 = [Subject new];
    subject12.name = @"Cybersecurity 2";
    subject12.code = @"CBS1002";
    subject12.students = [NSMutableArray new];
    [subject12.students addObjectsFromArray:sampleStudents];
    
    Subject *subject13 = [Subject new];
    subject13.name = @"Encryption algorithms";
    subject13.code = @"EAL1223";
    subject13.students = [NSMutableArray new];
    [subject13.students addObjectsFromArray:sampleStudents];

    [professor1.subjects addObjectsFromArray:@[subject11, subject12, subject13]];
    
    Professor *professor2 = [Professor new];
    professor2.name = @"Elfar Adalsteinsson";
    professor2.degree = @"PhD";
    professor2.mainInterest = @"RLE, I-InfoSys, I-BioMed, bio-EECS";
    professor2.subjects = [NSMutableArray new];

    Subject *subject21 = [Subject new];
    subject21.name = @"Bio-Medicine";
    subject21.code = @"BIM3005";
    subject21.students = [NSMutableArray new];
    [subject21.students addObjectsFromArray:sampleStudents];
    
    Subject *subject22 = [Subject new];
    subject22.name = @"Information Systems";
    subject22.code = @"INS1602";
    subject22.students = [NSMutableArray new];
    [subject22.students addObjectsFromArray:sampleStudents];
    
    Subject *subject23 = [Subject new];
    subject23.name = @"Advances Bio-Medicine";
    subject23.code = @"BIM3006";
    subject23.students = [NSMutableArray new];
    [subject23.students addObjectsFromArray:sampleStudents];
    
    [professor2.subjects addObjectsFromArray:@[subject21, subject22, subject23]];

    Professor *professor3 = [Professor new];
    professor3.name = @"Anant Agarwal";
    professor3.degree = @"PhD";
    professor3.mainInterest = @"Electrical Engineering and Computer Science";
    professor3.subjects = [NSMutableArray new];

    Subject *subject31 = [Subject new];
    subject31.name = @"Electrical Engineering";
    subject31.code = @"ELE2021";
    subject31.students = [NSMutableArray new];
    [subject31.students addObjectsFromArray:sampleStudents];
    
    Subject *subject32 = [Subject new];
    subject32.name = @"Digital Design";
    subject32.code = @"DID4802";
    subject32.students = [NSMutableArray new];
    [subject32.students addObjectsFromArray:sampleStudents];
    
    Subject *subject33 = [Subject new];
    subject33.name = @"Electrical Engineering 2";
    subject33.code = @"ELE2022";
    subject33.students = [NSMutableArray new];
    [subject33.students addObjectsFromArray:sampleStudents];
    
    [professor3.subjects addObjectsFromArray:@[subject31, subject32, subject33]];
    
    [professors addObjectsFromArray:@[professor1, professor2, professor3]];
    
    return professors;
}

@end
