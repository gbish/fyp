//
//  WOTDScroller.h
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 09/04/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import "Scroller.h"

@class WOTDScroller;

@protocol WOTDScrollerDelegate <NSObject>

@optional
- (void)scroller:(WOTDScroller *)scroller didSelectWord:(NSString *)word;

@end

@interface WOTDScroller : Scroller

@property (nonatomic, weak) id <WOTDScrollerDelegate> delegate;

@property (nonatomic) UIView *wotdView;

@property (nonatomic) UIScrollView *scroller;

@end
