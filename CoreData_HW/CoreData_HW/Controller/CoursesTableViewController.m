//
//  CoursesTableViewController.m
//  CoreData_HW
//
//  Created by kluv on 27/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "CoursesTableViewController.h"
#import "Course+CoreDataClass.h"
#import "CourseTableViewCell.m"
#import "CourseDetailTableViewController.h"

@interface CoursesTableViewController ()

@end

@implementation CoursesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - FRC

@synthesize fetchedResultsController = _fetchedResultsController;

- (NSFetchedResultsController<Course*> *)fetchedResultsController {
        
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest<Course *> *fetchRequest = Course.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<Course *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
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

#pragma mark - TableView

- (void)configureCell:(CourseTableViewCell *)cell withObject:(Course*)dataObject {

    cell.ibNameLabel.text = dataObject.name;
    cell.ibTeacherLabel.text = @""; //temporary teacher unavaible

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"CourseCell";

    CourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [[CourseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

    Course *dataObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:dataObject];

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//    UserDetailTableViewController *userDetailView = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"UserDetailView"];
//
//    userDetailView.user = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    userDetailView.managedObjectContext = self.managedObjectContext;
//
//    [self.navigationController pushViewController:userDetailView animated:YES];

}

#pragma mark - Actions

- (IBAction)addCourseAction:(UIBarButtonItem *)sender {
    
    CourseDetailTableViewController *courseDetailView = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"CourseDetailView"];
    
    courseDetailView.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:courseDetailView animated:YES];
    
}
@end
