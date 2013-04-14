//
//  WOTDScroller.m
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 09/04/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import "WOTDScroller.h"
#import "PaddedUILabel.h"
#import "UIColor_Categories.h"
#import <QuartzCore/QuartzCore.h>

@implementation WOTDScroller

@synthesize scroller;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = nil;
    }
    return self;
}

- (void)fillScrollView:(NSArray *)arrayData scrollViewHeight:(float)height
{
    scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, height)];
    scroller.delegate = self;
    [scroller setPagingEnabled:YES];
    CGSize scrollViewContentSize = scroller.bounds.size;
    [scroller setContentSize:scrollViewContentSize];
    [scroller setShowsHorizontalScrollIndicator:NO];
    
    float i = 0;
    
    for (NSDictionary *dict in arrayData) {
        float wordHeight = 60.0f;
        float defHeight = height - wordHeight;
        UIView *wrapper = [[UIView alloc] initWithFrame:CGRectMake(i * scroller.bounds.size.width + 5.0f, 0.0f, self.frame.size.width - 10.0f, height)];
        wrapper.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
        wrapper.layer.cornerRadius = 8;
        wrapper.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
        wrapper.layer.borderWidth = 2;
        wrapper.backgroundColor = [UIColor colorWithHexString:@"#194885"];
        [scroller addSubview:wrapper];
        
        PaddedUILabel *wordLabel = [[PaddedUILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, wrapper.bounds.size.width, 60.0f)];
        wordLabel.numberOfLines = 0;
        [wordLabel setText:[dict objectForKey:@"word"]];
        [wordLabel setFont:[UIFont fontWithName:@"Times" size:36.0]];
        wordLabel.textColor = [UIColor whiteColor];
        wordLabel.backgroundColor = [UIColor clearColor];
        
        PaddedUILabel *defLabel = [[PaddedUILabel alloc] initWithFrame:CGRectMake(0.0f, wordHeight, wrapper.bounds.size.width, defHeight)];
        defLabel.numberOfLines = 0;
        [defLabel setText:[dict objectForKey:@"definition"]];
        [defLabel setFont:[UIFont fontWithName:@"Helvetica" size:18.0]];
        defLabel.textColor = [UIColor colorWithHexString:@"#ACD9F6"];
        defLabel.backgroundColor = [UIColor clearColor];
        
        [wrapper addSubview:wordLabel];
        [wrapper addSubview:defLabel];
        i++;
    }
    
    CGSize newScrollViewContentSize = CGSizeMake(scroller.bounds.size.width * arrayData.count, height);
    [scroller setContentSize:newScrollViewContentSize];
    [self addSubview:scroller];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f, height, self.bounds.size.width, 16.0f)];
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
