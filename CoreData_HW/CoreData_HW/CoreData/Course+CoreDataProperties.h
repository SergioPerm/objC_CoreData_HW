//
//  Course+CoreDataProperties.h
//  CoreData_HW
//
//  Created by kluv on 01/07/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "Course+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<User *> *students;
@property (nullable, nonatomic, retain) CourseSubject *subject;
@property (nullable, nonatomic, retain) User *teacher;

@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(User *)value;
- (void)removeStudentsObject:(User *)value;
- (void)addStudents:(NSSet<User *> *)values;
- (void)removeStudents:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
