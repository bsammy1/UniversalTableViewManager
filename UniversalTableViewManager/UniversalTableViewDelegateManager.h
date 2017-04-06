//
//  UniversalTableViewDelegateManager.h
//  Minimarket
//
//  Created by Samat on 25.01.17.
//  Copyright © 2017 Samat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UniversalTableViewDelegateManager : NSObject

+ (id)sharedInstance;

@property NSMutableArray *objectClasses;
@property NSMutableArray *cellClasses;
@property NSMutableArray *optionKeyValues;

+ (void)addCellClass:(Class)cellClass forObjectClass:(Class)objectClass;

+ (void)addCellClass:(Class)cellClass forObjectClass:(Class)objectClass withOptionsKey:(NSString *)key value:(NSString *)value;

@end
