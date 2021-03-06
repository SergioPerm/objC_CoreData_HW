//
//  UsersTableViewController.m
//  CoreData_HW
//
//  Created by kluv on 24/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "UsersTableViewController.h"
#import "User+CoreDataClass.h"
#import "UserTableViewCell.h"
#import "UserDetailTableViewController.h"

@implementation UsersTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [self deleteAllEntities:@"User"];
//    [self deleteAllEntities:@"Course"];
    
//    NSArray * urls = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
//    NSLog(@"%@",[urls description]);
    
    //[self generateUsers];
    
}

- (void)generateUsers {
    
    NSDictionary* testNames = [self JSONFromFile];
            
    for (NSDictionary* nameDict in testNames) {
        
        NSString* fullName = [nameDict objectForKey:@"name"];

        NSArray* fullNameArr = [fullName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

        User *user = [[User alloc] initWithContext:self.managedObjectContext];
        
        user.firstName = [fullNameArr objectAtIndex:0];
        user.lastName = [fullNameArr objectAtIndex:1];
        user.email = [NSString stringWithFormat:@"%@@mail.ru",[user.lastName substringToIndex:3]];
                
        NSLog(@"%@", user.fullName);
                
    }
    
    [self.managedObjectContext save:nil];
    
}

- (NSDictionary *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"names" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)deleteAllEntities:(NSString *)nameEntity {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:nameEntity];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID

    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [self.managedObjectContext deleteObject:object];
    }

    error = nil;
    [self.managedObjectContext save:&error];
    
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

#pragma mark - TableView

- (void)configureCell:(UserTableViewCell *)cell withObject:(User*)dataObject {
            
    cell.ibNameLabel.text = [NSString stringWithFormat:@"%@ %@", dataObject.firstName, dataObject.lastName];
    cell.ibEmailLabel.text = dataObject.email;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"UserCell";
          
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UserTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    User *dataObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
    [self configureCell:cell withObject:dataObject];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserDetailTableViewController *userDetailView = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"UserDetailView"];
    
    userDetailView.user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    userDetailView.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:userDetailView animated:YES];
    
}

#pragma mark - Actions

- (IBAction)actionAddUser:(UIBarButtonItem *)sender {
    
    UserDetailTableViewController *userDetailView = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"UserDetailView"];
    
    userDetailView.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:userDetailView animated:YES];
    
}
@end
