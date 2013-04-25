//
//  Scrollers.m
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 02/04/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import "Scroller.h"
#import "PaddedUILabel.h"
#import "UIColor_Categories.h"
#import <QuartzCore/QuartzCore.h>
#import "HCNouns.h"
#import "HCVerbs.h"

@interface Scroller ()
@end

@implementation Scroller

@synthesize title;
@synthesize scroller;
@synthesize pageControl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"section_bg.png"]];
        
        self.scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.bounds.size.width, 100.0f)];
        self.scroller.delegate = self;
        [self.scroller setPagingEnabled:YES];
        [self.scroller setShowsHorizontalScrollIndicator:NO];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f, 125.0f, self.bounds.size.width, 16.0f)];
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
        self.pageControl.currentPage = 0;
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
    CGSize scrollViewContentSize = self.scroller.bounds.size;
    [self.scroller setContentSize:scrollViewContentSize];    
    
    int i = 0;
    
    for (NSManagedObject *def in arrayData) {
        PaddedUILabel *definitionLabel = [[PaddedUILabel alloc] initWithFrame:CGRectMake(i * self.scroller.bounds.size.width + 5.0f, 0.0f, self.scroller.bounds.size.width - 10.0f, 100.0f)];
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
        [self.scroller addSubview:definitionLabel];
        i++;
    }
    
    CGSize newScrollViewContentSize = CGSizeMake(self.scroller.bounds.size.width * arrayData.count, 100.0f);
    [self.scroller setContentSize:newScrollViewContentSize];
    
    self.pageControl.numberOfPages = arrayData.count;
    [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:self.scroller];
    [self addSubview:self.pageControl];
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
    int page = self.pageControl.currentPage;
    CGRect frame = self.scroller.frame;
    frame.origin.x = frame.size.width * page;
    NSLog(@"%f", self.bounds.size.width * page);
    [self.scroller scrollRectToVisible:CGRectMake(320.0f * page, 0.0f, self.bounds.size.width, 100.0f) animated:YES];
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
