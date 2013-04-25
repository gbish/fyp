//
//  WordsOfTheDayController.h
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 14/03/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WordsOfTheDayController;

@protocol WordsOfTheDayViewDelegate <NSObject>

@optional
- (void)controller:(WordsOfTheDayController *)controller didSelectWord:(NSString *)word;

@end

@interface WordsOfTheDayController : UIViewController

@property (nonatomic, weak) id <WordsOfTheDayViewDelegate> delegate;

@end
