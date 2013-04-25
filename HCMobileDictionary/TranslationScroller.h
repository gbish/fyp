//
//  ObjectScrollers.h
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 03/04/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import "Scroller.h"

@interface TranslationScroller : Scroller

//@property (nonatomic) UIScrollView *scroller;
//@property (nonatomic) UIPageControl *pageControl;

- (void)fillScrollView:(NSArray *)arrayData scrollViewHeight:(float)height;

@end
