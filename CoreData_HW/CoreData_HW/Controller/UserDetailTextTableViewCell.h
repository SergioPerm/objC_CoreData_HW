//
//  UserDetailTextTableViewCell.h
//  CoreData_HW
//
//  Created by kluv on 25/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDetailTextTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ibLabel;
@property (weak, nonatomic) IBOutlet UITextField *ibTextField;

@end

NS_ASSUME_NONNULL_END
