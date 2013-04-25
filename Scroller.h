//
//  Scrollers.h
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 02/04/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Scroller : UIView <UIScrollViewDelegate>

@property (nonatomic) NSString *title;
@property (nonatomic) UIScrollView *scroller;
@property (nonatomic) UIPageControl *pageControl;

- (void)fillScrollView:(NSArray *)arrayData scrollViewHeight:(float)height;

@end
