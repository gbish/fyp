//
//  Scrollers.m
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 02/04/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import "Scrollers.h"
#import "PaddedUILabel.h"
#import "UIColor_Categories.h"
#import <QuartzCore/QuartzCore.h>
#import "HCNouns.h"
#import "HCVerbs.h"

@interface Scrollers () {
    UIScrollView *scroller;
}

@end

@implementation Scrollers

@synthesize title;
@synthesize scroller;
@synthesize pageControl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"section_bg.png"]];
    }
    return self;
}

- (void)setTitle:(NSString *)theTitle {
    title = theTitle;
    
    UILabel *_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 0.0f, self.bounds.size.width - 10.0f, 16.0f)];
    _titleLabel.text = title;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [self addSubview:_titleLabel];
}

- (void)fillScrollView:(NSArray *)arrayData scrollViewHeight:(float)height
{
    scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.bounds.size.width, height)];
    scroller.delegate = self;
    [scroller setPagingEnabled:YES];
    CGSize scrollViewContentSize = scroller.bounds.size;
    [scroller setContentSize:scrollViewContentSize];
    [scroller setShowsHorizontalScrollIndicator:NO];
    
    int i = 0;
    
    for (NSManagedObject *def in arrayData) {
        PaddedUILabel *definitionLabel = [[PaddedUILabel alloc] initWithFrame:CGRectMake(i * scroller.bounds.size.width + 5.0f, 0.0f, scroller.bounds.size.width - 10.0f, 100.0f)];
        definitionLabel.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
        definitionLabel.numberOfLines = 0;
        definitionLabel.layer.cornerRadius = 8;
        definitionLabel.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
        definitionLabel.layer.borderWidth = 2;
        if ([def isKindOfClass:[HCNouns class]]) {
            [definitionLabel setText:[(HCNouns *) def definition]];
        } else {
            [definitionLabel setText:[(HCVerbs *) def definition]];
        }
        [definitionLabel setFont:[UIFont fontWithName:@"Times" size:14.0]];
        definitionLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [scroller addSubview:definitionLabel];
        i++;
    }
    
//    for (int i = 0; i < arrayData.count; i++) {
//        PaddedUILabel *definitionLabel = [[PaddedUILabel alloc] initWithFrame:CGRectMake(i * scroller.bounds.size.width + 5.0f, 0.0f, scroller.bounds.size.width - 10.0f, 100.0f)];
//        definitionLabel.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
//        definitionLabel.numberOfLines = 0;
//        definitionLabel.layer.cornerRadius = 8;
//        definitionLabel.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
//        definitionLabel.layer.borderWidth = 2;
//        [definitionLabel setText:arrayData[i]];
//        [definitionLabel setFont:[UIFont fontWithName:@"Times" size:14.0]];
//        definitionLabel.textColor = [UIColor colorWithHexString:@"#333333"];
//        [scroller addSubview:definitionLabel];
//        i++;
//    }
    
    CGSize newScrollViewContentSize = CGSizeMake(scroller.bounds.size.width * arrayData.count, 100.0f);
    [scroller setContentSize:newScrollViewContentSize];
    [self addSubview:scroller];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f, 125.0f, self.bounds.size.width, 16.0f)];
    pageControl.numberOfPages = arrayData.count;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    
    [pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:pageControl];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = sender.frame.size.width;
    float fractionalPage = sender.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageControl.currentPage = page;
}

- (void)pageChanged:(UIPageControl *)control
{
    int page = pageControl.currentPage + 1;
    CGRect frame = scroller.frame;
    frame.origin.x = frame.size.width * page;
    NSLog(@"%f", self.bounds.size.width * page);
//    NSLog(@"Page: %d Frame: %f", page, width);
    [scroller scrollRectToVisible:CGRectMake(320.0f * page, 0.0f, self.bounds.size.width, 100.0f) animated:YES];
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
