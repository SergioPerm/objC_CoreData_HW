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
    
    if (![self.cellsTextFieldsArray containsObject:cell.ibTextField])
        [self.cellsTextFieldsArray addObject:cell.ibTextField];
    
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
