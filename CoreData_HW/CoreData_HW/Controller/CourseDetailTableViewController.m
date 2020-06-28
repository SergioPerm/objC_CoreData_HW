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

typedef NS_ENUM(NSInteger, CourseSectionType) {
    CourseSectionTypeInfo,
    CourseSectionTypeStudents
};

typedef NS_ENUM(NSInteger, CourseTextFieldType) {
    CourseTextFieldTypeName
};

@interface CourseDetailTableViewController ()

@property (strong, nonatomic) NSMutableArray *cellsTextFieldsArray;

@end

@implementation CourseDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellsTextFieldsArray = [NSMutableArray array];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - FRC

@synthesize fetchedResultsController = _fetchedResultsController;

- (NSFetchedResultsController<User*> *)fetchedResultsController {
        
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest<User *> *fetchRequest = User.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"course contains %@", self.course];
    [fetchRequest setPredicate:predicate];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<User *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger numberOfRows = 0;
    
    if (section == CourseSectionTypeInfo) {
     
        numberOfRows = 1;
        
    } else if (section == CourseSectionTypeStudents) {
        
        numberOfRows = [self.fetchedResultsController.fetchedObjects count];
        
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
        
        cell.ibTextField.text = self.course ? self.course.name : @"";
        
        if (![self.cellsTextFieldsArray containsObject:cell.ibTextField]) {
            [self.cellsTextFieldsArray addObject:cell.ibTextField];
        }
        
        return cell;
        
    } else if (indexPath.section == CourseSectionTypeStudents) {
        
        if (indexPath.row == 0) {
            identifier = @"CourseButtonCell";
            
            CourseDetailAddStudentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (!cell) {
                cell = [[CourseDetailAddStudentsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            }
            
            cell.delegate = self;
            
            return cell;
            
        } else {
            identifier = @"CourseUserCell";
            
            CourseDetailUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (!cell) {
                cell = [[CourseDetailUserTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            }
            
            User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
            
            cell.ibNameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
            cell.ibEmailLabel.text = user.email;
            
            return cell;
            
        }
        
    }
    
    return cell;

}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - CourseDetailAddStudentsTableViewCellDelegate

- (void)addStudents {

    NSLog(@"Add students!");

}

#pragma mark - Actions

- (IBAction)saveCourseAction:(UIBarButtonItem *)sender {
    
    if (!self.course) {
        self.course = [[Course alloc] init];
    }
    
    UITextField *nametextField = [self.cellsTextFieldsArray objectAtIndex:CourseTextFieldTypeName];
    
    self.course.name = nametextField.text;
    
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
