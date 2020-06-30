//
//  User+CoreDataProperties.h
//  CoreData_HW
//
//  Created by kluv on 01/07/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, retain) NSSet<Course *> *course;
@property (nullable, nonatomic, retain) NSSet<Course *> *teachCourse;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addCourseObject:(Course *)value;
- (void)removeCourseObject:(Course *)value;
- (void)addCourse:(NSSet<Course *> *)values;
- (void)removeCourse:(NSSet<Course *> *)values;

- (void)addTeachCourseObject:(Course *)value;
- (void)removeTeachCourseObject:(Course *)value;
- (void)addTeachCourse:(NSSet<Course *> *)values;
- (void)removeTeachCourse:(NSSet<Course *> *)values;

@end

NS_ASSUME_NONNULL_END
