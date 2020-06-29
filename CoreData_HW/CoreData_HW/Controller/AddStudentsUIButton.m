//
//  AddStudentsUIButton.m
//  CoreData_HW
//
//  Created by kluv on 29/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "AddStudentsUIButton.h"

@implementation AddStudentsUIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setHighlighted:(BOOL)highlighted {
 
    [super setHighlighted:highlighted];

    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:0.f/255 green:196.f/255 blue:255.f/255 alpha:1];
    } else {
        self.backgroundColor = [UIColor colorWithRed:0.f/255 green:122.f/255 blue:255.f/255 alpha:1];
    }
    
}

- (void)setSelected:(BOOL)selected {
 
    [super setSelected:selected];
    
    if (selected) {
        self.backgroundColor = [UIColor colorWithRed:0.f/255 green:196.f/255 blue:255.f/255 alpha:1];
    } else {
        self.backgroundColor = [UIColor colorWithRed:0.f/255 green:122.f/255 blue:255.f/255 alpha:1];
    }
    
}

@end
