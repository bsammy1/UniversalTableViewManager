//
//  UniversalTableViewDelegate.h
//  Minimarket
//
//  Created by Samat on 07.11.16.
//  Copyright © 2016 Samat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^RefreshControlBlock)();
typedef void (^ReachedBottomBlock)();
typedef void (^ReachedBottomOfFirstLevelObjectBlock)(int index, NSObject *object);

@interface UniversalTableViewDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *firstLevelObjects;
@property NSMutableArray *secondLevelObjects;

@property UITableView *tableView;
@property UIViewController *vc;

@property UILabel *noObjectsLabel;
@property (nonatomic) NSString *noObjectsText;

@property NSMutableDictionary *options;

@property BOOL openOnlyOne;

@property BOOL initiallyAllClosed;

@property NSMutableArray *displayingObjects;
@property NSMutableArray *statesOfFirstLevelObjects;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) RefreshControlBlock refreshControlBlock;
@property (strong, nonatomic) ReachedBottomBlock reachedBottomBlock;
@property (strong, nonatomic) ReachedBottomOfFirstLevelObjectBlock reachedBottomOfFirstLevelObjectBlock;
- (void)addRefreshControlWithRefreshBlock:(RefreshControlBlock)block;
- (void)addBottomRefreshControlWithBottomRefreshBlock:(ReachedBottomBlock)block;

@property UIButton *scrollToTopButton;
- (void)addScrollToTopButton;

- (instancetype)initWithFrame:(CGRect)frame firstLevelObjects:(NSMutableArray *)firstLevelObjects secondLevelObjects:(NSMutableArray *)secondLevelObjects inViewController:(UIViewController *)viewController;

- (instancetype)initWithFrame:(CGRect)frame objects:(NSMutableArray *)objects inViewController:(UIViewController *)viewController;

- (instancetype)initWithTableView:(UITableView *)tableView firstLevelObjects:(NSMutableArray *)firstLevelObjects andSecondLevelObjects:(NSMutableArray *)secondLevelObjects inViewController:(UIViewController *)viewController;

- (instancetype)initWithTableView:(UITableView *)tableView firstLevelObjects:(NSMutableArray *)firstLevelObjects andSecondLevelObjects:(NSMutableArray *)secondLevelObjects inViewController:(UIViewController *)viewController initiallyAllClosed:(BOOL)initiallyAllClosed;

- (void)addOptionWithKey:(NSString *)key value:(NSString *)value;

- (void)insertRowsAtFirstLevelIndex:(int)index;

- (void)deleteRowsAtFirstLevelIndex:(int)index;

- (void)closeAllFirstLevelObjects;

- (BOOL)isHeadingCell:(NSIndexPath *)indexPath;

- (void)addFirstLevelObjects:(NSMutableArray *)firstLevelObjects withSecondLevelObjects:(NSMutableArray *)secondLevelObjects;

- (void)addObjects:(NSMutableArray *)objects atFirstLevelIndex:(int)firstLevelIndex;

- (void)addObjects:(NSMutableArray *)objects;

- (void)reloadTable;

- (void)populateWithNewFirstLevelObjects:(NSMutableArray *)firstLevelObjects secondLevelObjects:(NSMutableArray *)secondLevelObjects;

@end

@protocol UniversalTableViewCellDelegate <NSObject>

+ (int)getCellHeightFromObject:(NSObject *)object;
- (void)fillCellWithObject:(NSObject *)object options:(NSDictionary *)options delegate:(UniversalTableViewDelegate *)delegate;
- (void)selectedCellWithObject:(NSObject *)object inViewController:(UIViewController *)viewController tableView:(UITableView *)tableView options:(NSDictionary *)options delegate:(UniversalTableViewDelegate *)delegate;

@end
