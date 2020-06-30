//
//  CourseSubject+CoreDataProperties.m
//  CoreData_HW
//
//  Created by kluv on 01/07/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "CourseSubject+CoreDataProperties.h"

@implementation CourseSubject (CoreDataProperties)

+ (NSFetchRequest<CourseSubject *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"CourseSubject"];
}

@dynamic name;

@end
