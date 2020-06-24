//
//  User+CoreDataProperties.h
//  CoreData_HW
//
//  Created by kluv on 24/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *email;

@end

NS_ASSUME_NONNULL_END
