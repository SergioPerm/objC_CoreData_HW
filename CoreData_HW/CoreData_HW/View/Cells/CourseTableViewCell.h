//
//  CourseTableViewCell.h
//  CoreData_HW
//
//  Created by kluv on 27/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ibNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ibTeacherLabel;


@end

NS_ASSUME_NONNULL_END
