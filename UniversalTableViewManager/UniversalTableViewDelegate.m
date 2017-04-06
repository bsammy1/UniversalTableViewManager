//
//  UniversalTableViewDelegate.m
//  Minimarket
//
//  Created by Samat on 07.11.16.
//  Copyright © 2016 Samat. All rights reserved.
//

#import "UniversalTableViewDelegate.h"
#import "UniversalTableViewDelegateManager.h"

#import "HeadingTableViewCell.h"

#define kRefreshControlTag 101
#define kNoObjectsLabelTag 102
#define kScrollToTopButtonTag 103

@implementation UniversalTableViewDelegate {    
    UniversalTableViewDelegateManager *manager;
    
    CGRect tableViewFrame;
}

@synthesize noObjectsText = _noObjectsText;
@synthesize displayingObjects;
@synthesize statesOfFirstLevelObjects;

#pragma mark lifecycle

- (instancetype)initWithFrame:(CGRect)frame firstLevelObjects:(NSMutableArray *)firstLevelObjects secondLevelObjects:(NSMutableArray *)secondLevelObjects inViewController:(UIViewController *)viewController {
    if ([self initWithFrame:frame firstLevelObjects:firstLevelObjects secondLevelObjects:secondLevelObjects inViewController:viewController initiallyAllClosed:NO]) {
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame firstLevelObjects:(NSMutableArray *)firstLevelObjects secondLevelObjects:(NSMutableArray *)secondLevelObjects inViewController:(UIViewController *)viewController initiallyAllClosed:(BOOL)initiallyAllClosed {
    if ([super init]) {
        manager = [UniversalTableViewDelegateManager sharedInstance];
        
        self.initiallyAllClosed = initiallyAllClosed;
        
        self.options = [NSMutableDictionary new];
        
        self.vc = viewController;
        
        self.firstLevelObjects = firstLevelObjects;
        self.secondLevelObjects = secondLevelObjects;
        
        [self configureDisplayingObjects];
        
        if (!CGRectEqualToRect(frame, CGRectNull)) {
            tableViewFrame = frame;
            [self initTableView];
            
            [self configureTableView];
            
            [self.tableView reloadData];
        } else {
            [self configureTableView];
        }
    }
    
    return self;
}

- (void)populateWithNewFirstLevelObjects:(NSMutableArray *)firstLevelObjects secondLevelObjects:(NSMutableArray *)secondLevelObjects {
    self.firstLevelObjects = firstLevelObjects;
    self.secondLevelObjects = secondLevelObjects;
    [self configureDisplayingObjects];
    [self controlNoObjectsLabel];
    [self.tableView reloadData];
}

- (void)configureDisplayingObjects {
    statesOfFirstLevelObjects = [NSMutableArray new];

    displayingObjects = [self.firstLevelObjects mutableCopy];
    
    if (!self.initiallyAllClosed) {
        for (int i=0; i<self.firstLevelObjects.count; i++) {
            int index = (int)[displayingObjects indexOfObject:self.firstLevelObjects[i]];
            
            NSArray *secondLevelObjects = self.secondLevelObjects[i];
            for (int j=0; j<secondLevelObjects.count; j++) {
                [displayingObjects insertObject:secondLevelObjects[j] atIndex:index+j+1];
            }
        }
        
        for (int i=0; i<self.firstLevelObjects.count; i++) {
            [statesOfFirstLevelObjects addObject:@"opened"];
        }
    } else {
        for (int i=0; i<self.firstLevelObjects.count; i++) {
            [statesOfFirstLevelObjects addObject:@"closed"];
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame objects:(NSMutableArray *)objects inViewController:(UIViewController *)viewController {
    if ([self initWithFrame:frame firstLevelObjects:objects secondLevelObjects:nil inViewController:viewController]) {
        [self.tableView reloadData];
    }
    
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView firstLevelObjects:(NSMutableArray *)firstLevelObjects andSecondLevelObjects:(NSMutableArray *)secondLevelObjects inViewController:(UIViewController *)viewController initiallyAllClosed:(BOOL)initiallyAllClosed {
    if([self initWithFrame:CGRectNull firstLevelObjects:firstLevelObjects secondLevelObjects:secondLevelObjects inViewController:viewController initiallyAllClosed:initiallyAllClosed]) {
        self.tableView = tableView;
        tableViewFrame = self.tableView.frame;
        
        self.initiallyAllClosed = initiallyAllClosed;
        
        [self configureTableView];
        
        [self.tableView reloadData];
    }
    
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView firstLevelObjects:(NSMutableArray *)firstLevelObjects andSecondLevelObjects:(NSMutableArray *)secondLevelObjects inViewController:(UIViewController *)viewController {
    if([self initWithTableView:tableView firstLevelObjects:firstLevelObjects andSecondLevelObjects:secondLevelObjects inViewController:viewController initiallyAllClosed:NO]) {
        
    }
    
    return self;
}

- (void)configureTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.tableView registerNib:[UINib nibWithNibName:@"HeadingTableViewCell" bundle:nil] forCellReuseIdentifier:@"HeadingTableViewCell"];

    for (Class cellClass in manager.cellClasses) {
        NSString *className = NSStringFromClass (cellClass);
        [self.tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
}

- (void)noInternetNotification {
    [self.refreshControl endRefreshing];
}


#pragma mark views
- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:tableViewFrame];
    
    [self.vc.view addSubview:self.tableView];
}

- (void)refreshTable {
    //TODO: refresh your data
    dispatch_async(dispatch_get_main_queue(), ^{
        // do work here
        self.refreshControlBlock();
    });
}

- (void)addRefreshControlWithRefreshBlock:(RefreshControlBlock)block {
    if ([self.tableView viewWithTag:kRefreshControlTag]==nil) {
        self.refreshControl = [[UIRefreshControl alloc]init];
        self.refreshControl.tag = kRefreshControlTag;
        [self.tableView addSubview:self.refreshControl];
        [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    } else {
        self.refreshControl = [self.tableView viewWithTag:kRefreshControlTag];
        [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    }

    self.refreshControlBlock = block;
}

//ONLY NEEDED FOR CUSTOM REFRESH CONTROL
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    // If a refresh is already in place, do not mess up with alpha values
//    if (!self.refreshControl.refreshing) {
//        // Distance the table has been pulled >= 0.
//        CGFloat pullDistance = MAX(0.0, -self.refreshControl.frame.origin.y);
//        
//        // Calculate the pull ratio, between 0.0-1.0.
//        CGFloat pullRatio = MIN(MAX(pullDistance, 0.0), 100.0) / 100.0;
//        
//        [customRefreshControl setStateForPullRatio:pullRatio];
//    } else if (!customRefreshControl.isAnimating) {
//        // Double check if an animation isn't already in place
//        [customRefreshControl animate];
//    }
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    if (self.refreshControl.refreshing) {
//        if (!customRefreshControl.isAnimating) {
//            [customRefreshControl animate];
//        }
//    }
//}

- (void)addBottomRefreshControlWithBottomRefreshBlock:(ReachedBottomBlock)block {
    self.reachedBottomBlock = block;
}

- (void)setNoObjectsText:(NSString *)noObjectsText {
    _noObjectsText = noObjectsText;

    [self controlNoObjectsLabel];
}

- (void)controlNoObjectsLabel {
    self.noObjectsLabel = [self.tableView viewWithTag:kNoObjectsLabelTag];
    
    if (self.noObjectsLabel==nil) {
        self.noObjectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, self.vc.view.frame.size.width-40, 100)];
        self.noObjectsLabel.text = self.noObjectsText;
        self.noObjectsLabel.textColor = [UIColor lightGrayColor];
        self.noObjectsLabel.numberOfLines = 0;
        self.noObjectsLabel.textAlignment = NSTextAlignmentCenter;
        self.noObjectsLabel.tag = kNoObjectsLabelTag;
        
    }

    if (self.firstLevelObjects.count==0) {
        [self.tableView addSubview:self.noObjectsLabel];
    } else {
        if (self.noObjectsLabel!=nil) {
            [self.noObjectsLabel removeFromSuperview];
            self.noObjectsLabel = nil;
        }
    }
}

- (void)addScrollToTopButton {
    UIScreen *screen = [UIScreen mainScreen];
    int buttonSize = 40;
    
    if ([self.tableView.superview viewWithTag:kScrollToTopButtonTag]==nil) {
        self.scrollToTopButton = [[UIButton alloc] initWithFrame:CGRectMake(screen.bounds.size.width-buttonSize-16, screen.bounds.size.height-buttonSize-16-64, buttonSize, buttonSize)];
        self.scrollToTopButton.tag = kScrollToTopButtonTag;
        [self.scrollToTopButton addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollToTopButton setBackgroundColor:[UIColor whiteColor]];
        self.scrollToTopButton.layer.cornerRadius = buttonSize/2;
        self.scrollToTopButton.layer.borderWidth = 0.5;
        self.scrollToTopButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.scrollToTopButton setImage:[UIImage imageNamed:@"expand_less"] forState:UIControlStateNormal];
        [self.tableView.superview addSubview:self.scrollToTopButton];
    } else {
        self.scrollToTopButton = [self.tableView.superview viewWithTag:kScrollToTopButtonTag];
    }
}

- (void)scrollToTop {
    [self.tableView setContentOffset:CGPointZero animated:YES];
}

- (void)hideScrollToTopButton:(BOOL)hidden {
    if (self.scrollToTopButton!=nil) {
        [self.scrollToTopButton setHidden:hidden];
    }
}

#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return displayingObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL foundCell = NO;
    
    NSObject *object = displayingObjects[indexPath.row];
    
    NSString *finalCellIdentifier;

    if ([object isKindOfClass:[self.firstLevelObjects[0] class]] && [self hasSecondLevelObjects]) {
        finalCellIdentifier = @"HeadingTableViewCell";
        foundCell = YES;
    } else {
        NSMutableArray *correctCellClassIndexes = [NSMutableArray new];
        
        for (Class objectClass in manager.objectClasses) {
            if ([object isKindOfClass:objectClass]) {
                NSInteger index = [manager.objectClasses indexOfObject:objectClass];
                
                [correctCellClassIndexes addObject:[NSNumber numberWithInteger:index]];
                foundCell = YES;
            }
        }
        
        if (correctCellClassIndexes.count==1) {
            int index = [correctCellClassIndexes[0] intValue];
            finalCellIdentifier = NSStringFromClass(manager.cellClasses[index]);
        } else {
            for (NSNumber *index in correctCellClassIndexes) {
                NSDictionary *specialKeyValue = manager.optionKeyValues[[index intValue]];
                
                for (NSString *key in specialKeyValue) {
                    if ([self.options[key] isEqualToString:specialKeyValue[key]]) {
                        int index = [correctCellClassIndexes[0] intValue];
                        finalCellIdentifier = NSStringFromClass(manager.cellClasses[index]);
                        
                        break;
                    }
                }
            }
        }
    }
    
    if (!foundCell) {
        [NSException raise:@"No cell for object class" format:@"Could not find cell class for object class %@, please check if you added a cell class for this class", NSStringFromClass([object class])];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:finalCellIdentifier];
    
    [self fillCell:cell WithObject:object];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSObject *object = displayingObjects[indexPath.row];

    [(id <UniversalTableViewCellDelegate>)cell selectedCellWithObject:object inViewController:self.vc tableView:self.tableView options:self.options delegate:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isHeadingCell:indexPath]) {
        return kHeadingCellHeight;
    }
    
    NSObject *object = displayingObjects[indexPath.row];
    
    for (Class objectClass in manager.objectClasses) {
        int index = (int)[manager.objectClasses indexOfObject:objectClass];
        
        if ([object isKindOfClass:objectClass]) {
            Class cellClass = manager.cellClasses[index];
            
            return [cellClass getCellHeightFromObject:object];
        }
    }
    
    return kHeadingCellHeight;
    
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    
//    NSObject *object = displayingObjects[indexPath.row];
//    
//    return [(id <UniversalTableViewCellDelegate>)cell getCellHeightFromObject:object];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        [self hideScrollToTopButton:YES];
    } else if (indexPath.row>12) {
        [self hideScrollToTopButton:NO];
    }
    
    NSObject *object = displayingObjects[indexPath.row];
    
    if([object isKindOfClass:[self.firstLevelObjects[0] class]] && [self hasSecondLevelObjects]) {
        int index = (int)[self.firstLevelObjects indexOfObject:object];
        
        if (index==0) {
            return;
        }
        
        if ([statesOfFirstLevelObjects[index-1] isEqualToString:@"opened"]) {
            if (self.reachedBottomOfFirstLevelObjectBlock!=nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // do work here
                    self.reachedBottomOfFirstLevelObjectBlock(index-1, self.firstLevelObjects[index-1]);
                });

            }
        }
    }
    
    if (indexPath.row==displayingObjects.count-1) {
        if (self.reachedBottomBlock!=nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // do work here
                self.reachedBottomBlock();
            });

        }
    }
}

- (void)fillCell:(UITableViewCell *)cell WithObject:(NSObject *)object {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [(id <UniversalTableViewCellDelegate>)cell fillCellWithObject:object options:self.options delegate:self];
}


#pragma mark handling adding/removing objects
- (void)closeAllFirstLevelObjects {
    for (int i=0; i<statesOfFirstLevelObjects.count; i++) {
        if ([statesOfFirstLevelObjects[i] isEqualToString:@"opened"]) {
            [self deleteRowsAtFirstLevelIndex:i];
            
            statesOfFirstLevelObjects[i] = @"closed";
        }
    }
}

- (void)insertRowsAtFirstLevelIndex:(int)index {
    int displayingIndex = (int)[displayingObjects indexOfObject:self.firstLevelObjects[index]];
    
    NSArray *displayingSecondLevelObjects = self.secondLevelObjects[index];
    
    [self insertObjects:displayingSecondLevelObjects atIndex:displayingIndex+1];
}

- (void)insertObjects:(NSArray *)objects atIndex:(int)index {
    NSMutableArray *insertingIndexPaths = [NSMutableArray new];
    
    for (int i=0; i<objects.count; i++) {
        [displayingObjects insertObject:objects[i] atIndex:index+i];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index+i inSection:0];
        
        [insertingIndexPaths addObject:indexPath];
    }
    
    int64_t delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [(UITableView *)self.tableView insertRowsAtIndexPaths:insertingIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    });
    
    [self controlNoObjectsLabel];
}

- (void)deleteRowsAtFirstLevelIndex:(int)index {
    int displayingIndex = (int)[displayingObjects indexOfObject:self.firstLevelObjects[index]];

    NSArray *displayingSecondLevelObjects = self.secondLevelObjects[index];

    NSMutableArray *deletingIndexPaths = [NSMutableArray new];
    
    for (int i=0; i<displayingSecondLevelObjects.count; i++) {
        [displayingObjects removeObjectAtIndex:displayingIndex+1];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:displayingIndex+i+1 inSection:0];
        
        [deletingIndexPaths addObject:indexPath];
    }
    
    [(UITableView *) self.tableView deleteRowsAtIndexPaths:deletingIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (BOOL)isHeadingCell:(NSIndexPath *)indexPath {
    NSObject *object = displayingObjects[indexPath.row];

    if (self.secondLevelObjects!=nil && [object isKindOfClass:[self.firstLevelObjects[0] class]]) {
        return YES;
    }
    
    return NO;
}

- (void)reloadTable {
    displayingObjects = [self.firstLevelObjects mutableCopy];
    [self.tableView reloadData];
}

- (void)addFirstLevelObjects:(NSMutableArray *)firstLevelObjects withSecondLevelObjects:(NSMutableArray *)secondLevelObjects {
    [self.firstLevelObjects addObjectsFromArray:firstLevelObjects];
    [self.secondLevelObjects addObjectsFromArray:secondLevelObjects];

    for (int i=0; i<firstLevelObjects.count; i++) {
        [statesOfFirstLevelObjects addObject:@"closed"];
    }
    
    int index = (int)displayingObjects.count-1;
    
    if (index<0) {
        index = 0;
    }

    [self insertObjects:firstLevelObjects atIndex:index];
}

- (void)addObjects:(NSMutableArray *)objects atFirstLevelIndex:(int)firstLevelIndex { //it is first level index!
    if ([self hasSecondLevelObjects]) {
        if (firstLevelIndex>=self.firstLevelObjects.count) {
            [self.secondLevelObjects[firstLevelIndex] addObjectsFromArray:objects];
            [self insertObjects:objects atIndex:(int)displayingObjects.count-1];
        } else {
            NSObject *nextFirstLevelObject = self.firstLevelObjects[firstLevelIndex+1];
            int insertingIndex = (int)[displayingObjects indexOfObject:nextFirstLevelObject];
            [self.secondLevelObjects[firstLevelIndex] addObjectsFromArray:objects];
            [self insertObjects:objects atIndex:insertingIndex];
        }
    } else {
        [self.firstLevelObjects addObjectsFromArray:objects];
        
        for (int i=0; i<objects.count; i++) {
            [statesOfFirstLevelObjects addObject:@"closed"];
        }
        
        [self insertObjects:objects atIndex:firstLevelIndex];
    }
}

- (void)addObjects:(NSMutableArray *)objects {
    int index = (int)self.firstLevelObjects.count;
    
    if (index<0) {
        index = 0;
    }
    
    [self addObjects:objects atFirstLevelIndex:index];
}


- (BOOL)hasSecondLevelObjects {
    if (self.secondLevelObjects==nil) {
        return NO;
    }
    
    return YES;
}

- (void)addOptionWithKey:(NSString *)key value:(NSString *)value {
    [self.options setValue:value forKey:key];
}





@end
