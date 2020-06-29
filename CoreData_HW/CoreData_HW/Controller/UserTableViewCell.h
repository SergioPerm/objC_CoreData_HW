//
//  UserTableViewCell.h
//  CoreData_HW
//
//  Created by kluv on 24/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ibNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ibEmailLabel;

@property (weak, nonatomic) IBOutlet UIImageView *ibBookmarkImageView;

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* email;

@end

NS_ASSUME_NONNULL_END
