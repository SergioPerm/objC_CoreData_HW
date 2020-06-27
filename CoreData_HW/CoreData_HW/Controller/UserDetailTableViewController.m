//
//  UserDetailTableViewController.m
//  CoreData_HW
//
//  Created by kluv on 25/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "UserDetailTableViewController.h"
#import "UserDetailTextTableViewCell.h"

typedef NS_ENUM(NSInteger, UserTextFieldType) {
    UserTextFieldTypeFirstName,
    UserTextFieldTypeLastName,
    UserTextFieldTypeEmail
};

@interface UserDetailTableViewController ()

@property (strong, nonatomic) NSMutableArray *cellsTextFieldsArray;

@end

@implementation UserDetailTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.cellsTextFieldsArray = [NSMutableArray array];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"");
    
}

#pragma mark - Methods

- (BOOL)validateEmailWithString:(NSString*)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (![self validateEmailWithString: textField.text]) {
        textField.backgroundColor = [UIColor systemPinkColor];
    } else {
        textField.backgroundColor = nil;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
                
    }
    
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
