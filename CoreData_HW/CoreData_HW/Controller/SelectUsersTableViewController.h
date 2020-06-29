//
//  SelectUsersTableViewController.h
//  CoreData_HW
//
//  Created by kluv on 28/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SelectUsersTableViewControllerDelegate <NSObject>

@optional

- (void)saveUserSelectionWithArray:(NSMutableArray*)selectedUsersArray forTeacher:(BOOL)itsTeacher;

@end

@interface SelectUsersTableViewController : CoreDataTableViewController

@property (weak, nonatomic) id<SelectUsersTableViewControllerDelegate> delegate;
@property (assign, nonatomic) BOOL multiplySelect;
@property (strong, nonatomic) NSMutableArray *selectedUsersArray;

- (IBAction)saveUsersAction:(UIBarButtonItem *)sender;


@end

NS_ASSUME_NONNULL_END
