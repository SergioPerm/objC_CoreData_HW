//
//  CourseDetailTableViewController.h
//  CoreData_HW
//
//  Created by kluv on 28/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course+CoreDataClass.h"
#import "CoreDataTableViewController.h"
#import "CourseDetailAddStudentsTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailTableViewController : CoreDataTableViewController <UITextFieldDelegate, CourseDetailAddStudentsTableViewCellDelegate>

- (IBAction)saveCourseAction:(UIBarButtonItem *)sender;

@property (strong, nonatomic) Course *course;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

NS_ASSUME_NONNULL_END
