//
//  Course+CoreDataProperties.m
//  CoreData_HW
//
//  Created by kluv on 26/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "Course+CoreDataProperties.h"

@implementation Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Course"];
}

@dynamic name;
@dynamic departament;
@dynamic subject;
@dynamic students;

@end
