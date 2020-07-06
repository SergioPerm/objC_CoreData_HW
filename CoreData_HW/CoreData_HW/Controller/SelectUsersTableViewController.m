//
//  SelectUsersTableViewController.m
//  CoreData_HW
//
//  Created by kluv on 28/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "SelectUsersTableViewController.h"
#import "User+CoreDataClass.h"
#import "UserTableViewCell.h"

@interface SelectUsersTableViewController ()

@property (strong, nonatomic) NSString *searchFilter;

@end

@implementation SelectUsersTableViewController

#pragma mark - Delegate methods

- (void)saveUserSelectionWithArray:(NSMutableArray*)selectedUsersArray forTeacher:(BOOL)itsTeacher {
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.selectedUsersArray) {
        self.selectedUsersArray = [NSMutableArray array];
    }
    
    self.searchFilter = @"";
    
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

    if (![self.searchFilter isEqualToString:@""]) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fullName CONTAINS[cd] %@", self.searchFilter];
        [fetchRequest setPredicate:predicate];
        
    }
    
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
    
    if ([self.selectedUsersArray containsObject:dataObject]) {
        cell.ibBookmarkImageView.image = [UIImage systemImageNamed:@"bookmark.fill"];
    } else {
        cell.ibBookmarkImageView.image = [UIImage systemImageNamed:@"bookmark"];
    }
    
    [self configureCell:cell withObject:dataObject];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
    if ([self.selectedUsersArray containsObject:user]) {
        
        cell.ibBookmarkImageView.image = [UIImage systemImageNamed:@"bookmark"];
        [self.selectedUsersArray removeObject:user];
        
    } else {
        
        cell.ibBookmarkImageView.image = [UIImage systemImageNamed:@"bookmark.fill"];
        
        if (!self.multiplySelect) {
            [self.selectedUsersArray removeAllObjects];
        }
        
        [self.selectedUsersArray addObject:user];
        
    }
    
    [self.tableView reloadData];
    
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    self.searchFilter = searchText;
    
    self.fetchedResultsController = nil;
    
    [self.tableView reloadData];
    
}

#pragma mark - Actions

- (IBAction)saveUsersAction:(UIBarButtonItem *)sender {
    
    if ([self.delegate respondsToSelector:@selector(saveUserSelectionWithArray:forTeacher:)]) {
        [self.delegate saveUserSelectionWithArray:self.selectedUsersArray forTeacher:!self.multiplySelect];
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
@end
