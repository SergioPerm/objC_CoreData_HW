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

@interface UserDetailTableViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)actionSave:(UIBarButtonItem *)sender;

@end

NS_ASSUME_NONNULL_END
