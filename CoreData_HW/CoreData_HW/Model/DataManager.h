//
//  DataManager.h
//  CoreData_HW
//
//  Created by kluv on 24/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+(DataManager*) shareManager;

@end

NS_ASSUME_NONNULL_END
