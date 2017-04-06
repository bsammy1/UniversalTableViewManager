//
//  UniversalTableViewDelegateManager.m
//  Minimarket
//
//  Created by Samat on 25.01.17.
//  Copyright © 2017 Samat. All rights reserved.
//

#import "UniversalTableViewDelegateManager.h"

@implementation UniversalTableViewDelegateManager

@synthesize cellClasses;
@synthesize objectClasses;

+ (id)sharedInstance {
    static UniversalTableViewDelegateManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    if ([super init]) {
        cellClasses = [NSMutableArray new];
        objectClasses = [NSMutableArray new];
    }
    
    return self;
}

+ (void)addCellClass:(Class)cellClass forObjectClass:(Class)objectClass {
    UniversalTableViewDelegateManager *manager = [UniversalTableViewDelegateManager sharedInstance];
    
    [manager.cellClasses addObject:cellClass];
    [manager.objectClasses addObject:objectClass];
    [manager.optionKeyValues addObject:[NSNull null]];
}

+ (void)addCellClass:(Class)cellClass forObjectClass:(Class)objectClass withOptionsKey:(NSString *)key value:(NSString *)value {
    UniversalTableViewDelegateManager *manager = [UniversalTableViewDelegateManager sharedInstance];
    
    [manager.cellClasses addObject:cellClass];
    [manager.objectClasses addObject:objectClass];
    [manager.optionKeyValues addObject:@{key:value}];
}

@end
