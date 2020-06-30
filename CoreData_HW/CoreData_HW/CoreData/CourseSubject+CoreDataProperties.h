//
//  CourseSubject+CoreDataProperties.h
//  CoreData_HW
//
//  Created by kluv on 01/07/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "CourseSubject+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CourseSubject (CoreDataProperties)

+ (NSFetchRequest<CourseSubject *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
