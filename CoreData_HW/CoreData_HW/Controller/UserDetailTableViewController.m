//
//  UserDetailTableViewController.m
//  CoreData_HW
//
//  Created by kluv on 25/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "UserDetailTableViewController.h"
#import "UserDetailTextTableViewCell.h"
#import "Course+CoreDataClass.h"
#import "CourseTableViewCell.h"

typedef NS_ENUM(NSInteger, UserTextFieldType) {
    UserTextFieldTypeFirstName,
    UserTextFieldTypeLastName,
    UserTextFieldTypeEmail
};

typedef NS_ENUM(NSInteger, UserSectionType) {
    UserSectionTypeInfo,
    UserSectionTypeCourses,
    UserSectionTypeTeacherInCourses
};

@interface UserDetailTableViewController ()

@property (strong, nonatomic) NSMutableArray *cellsTextFieldsArray;

@end

@implementation UserDetailTableViewController

#pragma mark - Delegate methods

- (void)addStudents {
    
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.cellsTextFieldsArray = [NSMutableArray array];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"");
    
}

#pragma mark - Methods

- (NSArray*)getAllTeacheCourses {
    
    NSFetchRequest *fetchRequest = Course.fetchRequest;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teacher == %@",self.user];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *teachCourses = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    return teachCourses;
    
}

- (BOOL)validateEmailWithString:(NSString*)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([self.cellsTextFieldsArray indexOfObject:textField] == UserTextFieldTypeEmail) {
        
        if (![self validateEmailWithString: textField.text]) {
            textField.backgroundColor = [UIColor systemPinkColor];
        } else {
            textField.backgroundColor = nil;
        }
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSInteger textFieldIndex = [self.cellsTextFieldsArray indexOfObject:textField];
    
    if (textFieldIndex < [self.cellsTextFieldsArray count] - 1) {
        UITextField *nextTextField = [self.cellsTextFieldsArray objectAtIndex:textFieldIndex + 1];
        [nextTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell isKindOfClass:[UserDetailTextTableViewCell class]]) {
        
        UserDetailTextTableViewCell *userCell = (UserDetailTextTableViewCell*)cell;
        
        NSInteger textFieldIndex = [self.cellsTextFieldsArray indexOfObject:userCell.ibTextField];
        
        if (textFieldIndex == UserTextFieldTypeFirstName) {
            
            userCell.ibTextField.keyboardType = UIKeyboardTypeAlphabet;
            userCell.ibTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            userCell.ibTextField.autocorrectionType = UITextAutocorrectionTypeNo;
            userCell.ibTextField.returnKeyType = UIReturnKeyNext;
            
        } else if (textFieldIndex == UserTextFieldTypeLastName) {
            
            userCell.ibTextField.keyboardType = UIKeyboardTypeAlphabet;
            userCell.ibTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            userCell.ibTextField.autocorrectionType = UITextAutocorrectionTypeNo;
            userCell.ibTextField.returnKeyType = UIReturnKeyNext;
            
        } else if (textFieldIndex == UserTextFieldTypeEmail) {
            
            userCell.ibTextField.keyboardType = UIKeyboardTypeEmailAddress;
            userCell.ibTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            userCell.ibTextField.autocorrectionType = UITextAutocorrectionTypeNo;
            userCell.ibTextField.returnKeyType = UIReturnKeyDone;
            
        }
        
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == UserSectionTypeInfo) {
    
        return 3;
        
    } else if (section == UserSectionTypeCourses) {
        
        return [self.user.course count];
        
    } else if (section == UserSectionTypeTeacherInCourses) {
        
        return [[self getAllTeacheCourses] count];
        
    }
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == UserSectionTypeInfo) {
        
        UserDetailTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell" forIndexPath:indexPath];
        
        if (indexPath.row == UserTextFieldTypeFirstName) {
            
            cell.ibLabel.text = @"First name";
            cell.ibTextField.text = self.user ? self.user.firstName : @"";
            
        } else if (indexPath.row == UserTextFieldTypeLastName) {
            
            cell.ibLabel.text = @"Last name";
            cell.ibTextField.text = self.user ? self.user.lastName : @"";
            
        } else if (indexPath.row == UserTextFieldTypeEmail) {
            
            cell.ibLabel.text = @"E-mail";
            cell.ibTextField.text = self.user ? self.user.email : @"";
            
        }
        
        if (![self.cellsTextFieldsArray containsObject:cell.ibTextField]) {
            
            cell.ibTextField.delegate = self;
            [self.cellsTextFieldsArray addObject:cell.ibTextField];
            
        }
        
        return cell;
        
    } else if (indexPath.section == UserSectionTypeCourses) {
        
        CourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell" forIndexPath:indexPath];
                
        Course *course = [[self.user.course allObjects] objectAtIndex:indexPath.row];
        
        cell.ibNameLabel.text = course.name;
        cell.ibTeacherLabel.text = [NSString stringWithFormat:@"%@ %@", course.teacher.firstName, course.teacher.lastName];
        
        return cell;
        
    } else if (indexPath.section == UserSectionTypeTeacherInCourses) {
        
        CourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell" forIndexPath:indexPath];
        
        NSArray *teachCourses = [self getAllTeacheCourses];
        
        Course *course = [teachCourses objectAtIndex:indexPath.row];
        
        cell.ibNameLabel.text = course.name;
        cell.ibTeacherLabel.text = [NSString stringWithFormat:@"%@ %@", course.teacher.firstName, course.teacher.lastName];
        
        return cell;
        
    }
    
    return cell;
    
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == UserSectionTypeCourses) {
        return @"Courses:";
    } else if (section == UserSectionTypeTeacherInCourses) {
        return @"Teacher in courses:";
    }
    
    return @"";
    
}

#pragma mark - Actions

- (IBAction)actionSave:(UIBarButtonItem *)sender {
    
    UITextField *textFieldFirstName = [self.cellsTextFieldsArray objectAtIndex:UserTextFieldTypeFirstName];
    UITextField *textFieldLastName = [self.cellsTextFieldsArray objectAtIndex:UserTextFieldTypeLastName];
    UITextField *textFieldEmail = [self.cellsTextFieldsArray objectAtIndex:UserTextFieldTypeEmail];
    
    if (self.user) {
        
        self.user.firstName = textFieldFirstName.text;
        self.user.lastName = textFieldLastName.text;
        self.user.email = textFieldEmail.text;
        
    } else {
        
        User *user = [[User alloc] initWithContext:self.managedObjectContext];
        
        user.firstName = textFieldFirstName.text;
        user.lastName = textFieldLastName.text;
        user.email = textFieldEmail.text;
        
        NSLog(@"%@", user.firstName);
                
        self.user = user;
        
    }
    
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    if ([self.delegate respondsToSelector:@selector(saveStudentWithObject:)]) {
        [self.delegate saveStudentWithObject:self.user];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
