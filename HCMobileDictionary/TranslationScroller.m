//
//  ObjectScrollers.m
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 03/04/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import "TranslationScroller.h"
#import "PaddedUILabel.h"
#import "UIColor_Categories.h"
#import <QuartzCore/QuartzCore.h>
#import "HCTranslations.h"

@implementation TranslationScroller

@synthesize scroller;
@synthesize pageControl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)fillScrollView:(NSArray *)arrayData scrollViewHeight:(float)height
{
    CGSize scrollViewContentSize = self.scroller.bounds.size;
    [self.scroller setContentSize:scrollViewContentSize];
    
    int i = 0;
    
    for (HCTranslations *def in arrayData) {
        PaddedUILabel *translationLabel = [[PaddedUILabel alloc] initWithFrame:CGRectMake(i * self.scroller.bounds.size.width + 5.0f, 0.0f, self.scroller.bounds.size.width - 10.0f, 100.0f)];
        NSString *langImg = [NSString stringWithFormat:@"%@.png", def.language.lowercaseString];
        UIImageView *flag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:langImg]];
        flag.frame = CGRectMake(translationLabel.bounds.size.width - flag.bounds.size.width, 0.0f, flag.bounds.size.width, flag.bounds.size.height);
        translationLabel.backgroundColor = [UIColor whiteColor];
        translationLabel.numberOfLines = 0;
        translationLabel.layer.cornerRadius = 8;
        translationLabel.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
        translationLabel.layer.borderWidth = 2;
        [translationLabel setText:def.translation];
        [translationLabel setFont:[UIFont fontWithName:@"Times" size:14.0]];
        [translationLabel addSubview:flag];
        [self.scroller addSubview:translationLabel];
        i++;
    }
    
    CGSize newScrollViewContentSize = CGSizeMake(self.scroller.bounds.size.width * arrayData.count, 100.0f);
    [self.scroller setContentSize:newScrollViewContentSize];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f, 125.0f, self.bounds.size.width, 16.0f)];
    self.pageControl.numberOfPages = arrayData.count;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:self.scroller];
    [self addSubview:self.pageControl];
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
