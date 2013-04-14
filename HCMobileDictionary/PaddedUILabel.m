//
//  PaddedUILabel.m
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 03/04/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import "PaddedUILabel.h"

@implementation PaddedUILabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 8, 0, 8};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
