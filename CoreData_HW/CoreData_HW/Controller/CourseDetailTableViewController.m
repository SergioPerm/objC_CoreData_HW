//
//  CourseDetailTableViewController.m
//  CoreData_HW
//
//  Created by kluv on 28/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "CourseDetailTableViewController.h"
#import "User+CoreDataClass.h"
#import "CourseDetailTextTableViewCell.h"
#import "CourseDetailAddStudentsTableViewCell.h"
#import "CourseDetailUserTableViewCell.h"
#import "CourseSubject+CoreDataClass.h"

typedef NS_ENUM(NSInteger, CourseSectionType) {
    CourseSectionTypeInfo,
    CourseSectionTypeAddStudents,
    CourseSectionTypeStudents
};

typedef NS_ENUM(NSInteger, CourseTextFieldType) {
    CourseTextFieldTypeName,
    CourseTextFieldTypeSubject,
    CourseTextFieldTypeTeacher
};

@interface CourseDetailTableViewController ()

@property (strong, nonatomic) NSMutableArray *cellsTextFieldsArray;
@property (strong, nonatomic) NSMutableArray *students;
@property (strong, nonatomic) User *teacher;
@property (strong, nonatomic) NSString *courseName;
@property (strong, nonatomic) CourseSubject *subject;

@end

@implementation CourseDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellsTextFieldsArray = [NSMutableArray array];
    self.students = [NSMutableArray arrayWithArray:[self.course.students allObjects]];
        
    if (self.course) {
        self.teacher = self.course.teacher;
        self.courseName = self.course.name;
        self.subject = self.course.subject;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger numberOfRows = 0;
    
    if (section == CourseSectionTypeInfo) {
     
        numberOfRows = 3;
        
    } else if (section == CourseSectionTypeStudents) {
        
        numberOfRows = [self.students count];
        
    } else if (section == CourseSectionTypeAddStudents) {
        
        numberOfRows = 1;
        
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"";
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if (indexPath.section == CourseSectionTypeInfo) {
     
        identifier = @"CourseTextCell";
        
        CourseDetailTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[CourseDetailTextTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        
        if (indexPath.row == CourseTextFieldTypeName) {
            cell.ibTextField.text = self.courseName;
        } else if (indexPath.row == CourseTextFieldTypeSubject) {
            cell.ibTextLabel.text = @"Subject:";
            cell.ibTextField.text = self.subject ? self.subject.name : @"";
        } else {
            cell.ibTextLabel.text = @"Teacher:";
            cell.ibTextField.text = self.teacher ? [NSString stringWithFormat:@"%@ %@", self.teacher.firstName, self.teacher.lastName] : @"";
            cell.ibTextField.placeholder = @"Choose a teacher";
        }
        
        if (![self.cellsTextFieldsArray containsObject:cell.ibTextField]) {
            [self.cellsTextFieldsArray addObject:cell.ibTextField];
            cell.ibTextField.delegate = self;
        }
        
        return cell;
        
    } else if (indexPath.section == CourseSectionTypeStudents) {
                
        identifier = @"CourseUserCell";
        
        CourseDetailUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[CourseDetailUserTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        
        User *user = [self.students objectAtIndex:indexPath.row];//[self.fetchedResultsController objectAtIndexPath:indexPath];
        
        cell.ibNameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
        cell.ibEmailLabel.text = user.email;
        
        return cell;
                
    } else if (indexPath.section == CourseSectionTypeAddStudents) {
        
        identifier = @"CourseButtonCell";
        
        CourseDetailAddStudentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[CourseDetailAddStudentsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        
        cell.delegate = self;
        
        return cell;
        
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == CourseSectionTypeStudents) {
    
        UserDetailTableViewController *userDetailView = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"UserDetailView"];
        
        userDetailView.user = [self.students objectAtIndex:indexPath.row];
        userDetailView.managedObjectContext = self.managedObjectContext;
        userDetailView.delegate = self;
        
        [self.navigationController pushViewController:userDetailView animated:YES];
        
    } else {
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        
    }
        
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == CourseSectionTypeAddStudents) {
        return @"Students";
    }
    
    return @"";
    
}

#pragma mark - CourseDetailAddStudentsTableViewCellDelegate

- (void)addStudents {

    SelectUsersTableViewController* selectUsersView = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectUsersDetailView"];
    selectUsersView.delegate = self;
    selectUsersView.selectedUsersArray = [NSMutableArray arrayWithArray:self.students];
    selectUsersView.multiplySelect = YES;
    
    UINavigationController* navCtrl = [[UINavigationController alloc] initWithRootViewController:selectUsersView];
    
    navCtrl.preferredContentSize = CGSizeMake(300, 180);
    navCtrl.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController* presentCtrl = navCtrl.popoverPresentationController;
    presentCtrl.permittedArrowDirections = UIPopoverArrowDirectionUp;
    presentCtrl.delegate = self;
    presentCtrl.sourceView = self.view;
    
    [self presentViewController:navCtrl animated:YES completion:nil];

}

#pragma mark - UITxtFieldDelegate

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if ([self.cellsTextFieldsArray objectAtIndex:CourseTextFieldTypeName] == textField) {
     
        self.courseName = textField.text;
                
    }
    
    return YES;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
        
    NSString *courseName = [NSString stringWithFormat:@"%@%@", textField.text, string];
    self.courseName = courseName;
    
    return YES;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([self.cellsTextFieldsArray objectAtIndex:CourseTextFieldTypeTeacher] == textField) {
        
        SelectUsersTableViewController* selectUsersView = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectUsersDetailView"];
        selectUsersView.delegate = self;
        
        if (self.teacher)
            selectUsersView.selectedUsersArray = [NSMutableArray arrayWithArray:@[self.teacher]];
        
        selectUsersView.multiplySelect = NO;
        
        UINavigationController* navCtrl = [[UINavigationController alloc] initWithRootViewController:selectUsersView];
        
        navCtrl.preferredContentSize = CGSizeMake(300, 180);
        navCtrl.modalPresentationStyle = UIModalPresentationPopover;
        
        UIPopoverPresentationController* presentCtrl = navCtrl.popoverPresentationController;
        presentCtrl.permittedArrowDirections = UIPopoverArrowDirectionUp;
        presentCtrl.delegate = self;
        presentCtrl.sourceRect = [textField convertRect:textField.bounds toView:self.view];
        presentCtrl.sourceView = self.view;
        
        [self presentViewController:navCtrl animated:YES completion:nil];
        
        return NO;
        
    } else if ([self.cellsTextFieldsArray objectAtIndex:CourseTextFieldTypeSubject] == textField) {
        
        SubjectsTableViewController *subjectsView = [self.storyboard instantiateViewControllerWithIdentifier:@"SubjectsView"];
        subjectsView.delegate = self;
        
        UINavigationController* navCtrl = [[UINavigationController alloc] initWithRootViewController:subjectsView];
        
        navCtrl.preferredContentSize = CGSizeMake(300, 180);
        navCtrl.modalPresentationStyle = UIModalPresentationPopover;
        
        UIPopoverPresentationController* presentCtrl = navCtrl.popoverPresentationController;
        presentCtrl.permittedArrowDirections = UIPopoverArrowDirectionUp;
        presentCtrl.delegate = self;
        presentCtrl.sourceRect = [textField convertRect:textField.bounds toView:self.view];
        presentCtrl.sourceView = self.view;
        
        [self presentViewController:navCtrl animated:YES completion:nil];
        
        return NO;
        
    }
 
    return YES;
    
}

#pragma mark - SubjectsTableViewControllerDelegate

- (void)selectSubject:(CourseSubject *)subject {
    
    self.subject = subject;
    
    UITextField *textField = [self.cellsTextFieldsArray objectAtIndex:CourseTextFieldTypeSubject];
    textField.text = subject.name;
    
}

#pragma mark - SelectUsersTableViewControllerDelegate

- (void)saveUserSelectionWithArray:(NSMutableArray *)selectedUsersArray forTeacher:(BOOL)itsTeacher {
    
    if (itsTeacher) {
        
        if ([selectedUsersArray count] > 0) {
            self.teacher = selectedUsersArray[0];
        } else {
            self.teacher = nil;
        }
        
    } else {
        
        [self.students removeAllObjects];
        self.students = [NSMutableArray arrayWithArray:selectedUsersArray];
        
    }
        
    [self.tableView reloadData];
    
}

#pragma mark - UserDetailTableViewControllerDelegate

- (void)saveStudentWithObject:(User *)student {
    
    [self.tableView reloadData];
    
}

#pragma mark - Actions

- (IBAction)saveCourseAction:(UIBarButtonItem *)sender {
    
    if (!self.course) {
        self.course = [[Course alloc] initWithContext:self.managedObjectContext];
    }
    
    self.course.name = self.courseName;
    self.course.subject = self.subject;
    self.course.teacher = self.teacher;
    
    NSSet *setRemoveStudents = [NSSet setWithArray:[self.course.students allObjects]];
    NSSet *setStudents = [NSSet setWithArray:self.students];
    
    [self.course removeStudents:setRemoveStudents];
    [self.course addStudents:setStudents];
    
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
