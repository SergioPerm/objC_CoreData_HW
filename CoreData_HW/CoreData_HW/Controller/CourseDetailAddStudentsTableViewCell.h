//
//  CourseDetailAddStudentsTableViewCell.h
//  CoreData_HW
//
//  Created by kluv on 27/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailAddStudentsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *ibAddUsersBtn;
- (IBAction)actionAddUsers:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
