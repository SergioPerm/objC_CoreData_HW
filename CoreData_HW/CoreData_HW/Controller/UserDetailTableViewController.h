//
//  UserDetailTableViewController.h
//  CoreData_HW
//
//  Created by kluv on 25/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UserDetailTableViewControllerDelegate <NSObject>

@optional

- (void)saveStudentWithObject:(User*)student;

@end

@interface UserDetailTableViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) id<UserDetailTableViewControllerDelegate> delegate;

- (IBAction)actionSave:(UIBarButtonItem *)sender;

@end

NS_ASSUME_NONNULL_END
