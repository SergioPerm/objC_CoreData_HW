//
//  CourseDetailAddStudentsTableViewCell.m
//  CoreData_HW
//
//  Created by kluv on 27/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "CourseDetailAddStudentsTableViewCell.h"

@implementation CourseDetailAddStudentsTableViewCell

#pragma mark - Delegate methods

- (void)addStudents {
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.ibAddUsersBtn.layer.cornerRadius = 10;
    self.ibAddUsersBtn.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)actionAddUsers:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(addStudents)]) {
        [self.delegate addStudents];
    }
    
}
@end
