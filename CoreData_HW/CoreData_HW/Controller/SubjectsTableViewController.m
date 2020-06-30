//
//  SubjectsTableViewController.m
//  CoreData_HW
//
//  Created by kluv on 01/07/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "SubjectsTableViewController.h"
#import "SubjectTableViewCell.h"

@interface SubjectsTableViewController ()

@end

@implementation SubjectsTableViewController

#pragma mark - Delegate methods

- (void)selectSubject:(CourseSubject*)subject {
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
}

#pragma mark - FRC

@synthesize fetchedResultsController = _fetchedResultsController;

- (NSFetchedResultsController<CourseSubject*> *)fetchedResultsController {
        
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest<CourseSubject *> *fetchRequest = CourseSubject.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<CourseSubject *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
    
}

#pragma mark - Table view data source

- (void)configureCell:(SubjectTableViewCell *)cell withObject:(CourseSubject*)dataObject {

    cell.ibNameLabel.text = dataObject.name;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"SubjectCell";

    SubjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [[SubjectTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

    CourseSubject *dataObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:dataObject];

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CourseSubject *dataObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(selectSubject:)]) {
        [self.delegate selectSubject:dataObject];
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Actions

- (IBAction)addSubjectAction:(UIBarButtonItem *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Create subject" message:@"enter name of subject" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"Subject name";
        textField.textColor = [UIColor colorWithRed:0.f/255 green:122.f/255 blue:255.f/255 alpha:1];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CourseSubject *courseSubject = [[CourseSubject alloc] initWithContext:self.managedObjectContext];
        courseSubject.name = alertController.textFields[0].text;
        
        [self.managedObjectContext save:nil];
        
    }];
    
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
        
}

- (IBAction)closeAction:(UIBarButtonItem *)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
@end
