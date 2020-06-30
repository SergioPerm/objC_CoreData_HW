//
//  TeachersTableViewController.m
//  CoreData_HW
//
//  Created by kluv on 29/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "TeachersTableViewController.h"
#import "User+CoreDataClass.h"
#import "Course+CoreDataClass.h"
#import "UserTableViewCell.h"
#import "UserDetailTableViewController.h"
#import "CourseSubject+CoreDataClass.h"

@interface TeachersTableViewController ()

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) NSMutableDictionary *subjectsData;

@end

@implementation TeachersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.managedObjectContext = [[DataManager shareManager] persistentContainer].viewContext;
        
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self initData];
    [self.tableView reloadData];
    
}

- (void)initData {
    
    NSFetchRequest *fetchRequest = CourseSubject.fetchRequest;
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSArray *allSubjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    self.subjectsData = [[NSMutableDictionary alloc] init];
    
    for (CourseSubject *subject in allSubjects) {
                
        NSFetchRequest *fetchRequest = Course.fetchRequest;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teacher != %@ AND subject == %@", nil, subject];
        [fetchRequest setPredicate:predicate];
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        
        NSArray *courses = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        
        if ([courses count] == 0)
            continue;
        
        [self.subjectsData setObject:courses forKey:subject.name];
        
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.subjectsData count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *subjects = [self.subjectsData allKeys];
    id subjectKey = [subjects objectAtIndex:section];
    
    NSArray *courses = [self.subjectsData objectForKey:subjectKey];
        
    return courses.count;

}

- (void)configureCell:(UserTableViewCell *)cell withObject:(User*)dataObject {

    cell.ibNameLabel.text = [NSString stringWithFormat:@"%@ %@", dataObject.firstName, dataObject.lastName];
    cell.ibEmailLabel.text = [NSString stringWithFormat:@"Count teach courses: %lu",(unsigned long)[dataObject.teachCourse count]];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"CourseUserCell";

    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [[UserTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

//    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][indexPath.section];
//
//    NSArray *distinctObjects = [sectionInfo.objects valueForKeyPath:@"@distinctUnionOfObjects.teacher"];
//
//    User *dataObject = [distinctObjects objectAtIndex:indexPath.row];
//
//    //Course *dataObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    [self configureCell:cell withObject:dataObject];

    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 
    return @"";
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UserDetailTableViewController *userDetailView = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"UserDetailView"];
//
//    Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    userDetailView.user = course.teacher;
//    userDetailView.managedObjectContext = self.managedObjectContext;
//
//    [self.navigationController pushViewController:userDetailView animated:YES];
    
}

@end
