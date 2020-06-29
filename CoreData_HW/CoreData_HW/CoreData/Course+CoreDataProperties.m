//
//  Course+CoreDataProperties.m
//  CoreData_HW
//
//  Created by kluv on 28/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "Course+CoreDataProperties.h"

@implementation Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Course"];
}

@dynamic name;
@dynamic students;
@dynamic teacher;

@end
