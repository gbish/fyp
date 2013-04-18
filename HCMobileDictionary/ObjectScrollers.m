//
//  ObjectScrollers.m
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 03/04/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import "ObjectScrollers.h"
#import "PaddedUILabel.h"
#import "UIColor_Categories.h"
#import <QuartzCore/QuartzCore.h>
#import "HCTranslations.h"

@implementation ObjectScrollers {
    UIScrollView *scroller;
}

@synthesize scroller = _scroller;
@synthesize pageControl = _pageControl;

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
    scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.bounds.size.width, height)];
    [scroller setPagingEnabled:YES];
    CGSize scrollViewContentSize = scroller.bounds.size;
    [scroller setContentSize:scrollViewContentSize];
    [scroller setShowsHorizontalScrollIndicator:NO];
    
//    NSArray *keysArray = [[NSArray alloc] initWithObjects:@"french", @"german", @"spanish", @"italian", nil];
//    NSDictionary *translationObj = [[NSDictionary alloc] initWithObjects:arrayData forKeys:keysArray];
    
    int i = 0;
    
    for (HCTranslations *def in arrayData) {
        PaddedUILabel *translationLabel = [[PaddedUILabel alloc] initWithFrame:CGRectMake(i * scroller.bounds.size.width + 5.0f, 0.0f, scroller.bounds.size.width - 10.0f, 100.0f)];
        translationLabel.backgroundColor = [UIColor whiteColor];
        translationLabel.numberOfLines = 0;
        translationLabel.layer.cornerRadius = 8;
        translationLabel.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
        translationLabel.layer.borderWidth = 2;
        [translationLabel setText:def.translation];
        [translationLabel setFont:[UIFont fontWithName:@"Times" size:14.0]];
        [scroller addSubview:translationLabel];
        i++;
    }
    
    CGSize newScrollViewContentSize = CGSizeMake(scroller.bounds.size.width * arrayData.count, 100.0f);
    [scroller setContentSize:newScrollViewContentSize];
    [self addSubview:scroller];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f, 125.0f, self.bounds.size.width, 16.0f)];
    self.pageControl.numberOfPages = arrayData.count;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    
    [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    
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
