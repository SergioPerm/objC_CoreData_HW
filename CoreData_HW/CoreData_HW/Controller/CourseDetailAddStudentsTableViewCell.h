//
//  CourseDetailAddStudentsTableViewCell.h
//  CoreData_HW
//
//  Created by kluv on 27/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CourseDetailAddStudentsTableViewCellDelegate <NSObject>

@optional

- (void)addStudents;

@end

@interface CourseDetailAddStudentsTableViewCell : UITableViewCell

@property (weak, nonatomic) id<CourseDetailAddStudentsTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *ibAddUsersBtn;
- (IBAction)actionAddUsers:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
