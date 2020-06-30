//
//  UserTableViewCell.m
//  CoreData_HW
//
//  Created by kluv on 24/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFirstName:(NSString *)firstName {
    
    [self constructFullName];
    
}

- (void)setLastName:(NSString *)lastName {
    
    [self constructFullName];
    
}

- (void)setEmail:(NSString *)email {
    
    self.ibEmailLabel.text = _email;
    
}

- (void)constructFullName {
    
    self.ibNameLabel.text = [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
    
}

@end
