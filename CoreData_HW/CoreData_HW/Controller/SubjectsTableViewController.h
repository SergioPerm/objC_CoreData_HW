//
//  SubjectsTableViewController.h
//  CoreData_HW
//
//  Created by kluv on 01/07/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "CourseSubject+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SubjectsTableViewControllerDelegate <NSObject>

@optional

- (void)selectSubject:(CourseSubject*)subject;

@end

@interface SubjectsTableViewController : CoreDataTableViewController

- (IBAction)addSubjectAction:(UIBarButtonItem *)sender;
- (IBAction)closeAction:(UIBarButtonItem *)sender;

@property (weak, nonatomic) id<SubjectsTableViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
