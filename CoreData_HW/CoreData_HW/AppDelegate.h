//
//  AppDelegate.h
//  CoreData_HW
//
//  Created by kluv on 17/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

