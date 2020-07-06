//
//  User+CoreDataProperties.m
//  CoreData_HW
//
//  Created by kluv on 01/07/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"User"];
}

@dynamic email;
@dynamic firstName;
@dynamic lastName;
@dynamic fullName;
@dynamic course;
@dynamic teachCourse;


@end
