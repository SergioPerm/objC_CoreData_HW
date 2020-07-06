//
//  User+CoreDataClass.m
//  CoreData_HW
//
//  Created by kluv on 01/07/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "User+CoreDataClass.h"

@implementation User

- (void)setLastName:(NSString *)lastName {
    
    [self willChangeValueForKey:@"lastName"];
    [self setPrimitiveValue:lastName forKey:@"lastName"];
    [self didChangeValueForKey:@"lastName"];
    
    [self formFullName];
    
}

- (void)setFirstName:(NSString *)firstName {
    
    [self willChangeValueForKey:@"firstName"];
    [self setPrimitiveValue:firstName forKey:@"firstName"];
    [self didChangeValueForKey:@"firstName"];
    
    [self formFullName];
    
}

- (void)formFullName {
    
    NSString *firstName = [self primitiveValueForKey:@"firstName"];
    NSString *lastName = [self primitiveValueForKey:@"lastName"];
    
    if (![firstName isEqualToString:@""] && ![lastName isEqualToString:@""]) {
        [self setPrimitiveValue:[NSString stringWithFormat:@"%@ %@", lastName, firstName] forKey:@"fullName"];
    }
    
}

@end
