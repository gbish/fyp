//
//  HCTranslations.h
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 18/04/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HCWords;

@interface HCTranslations : NSManagedObject

@property (nonatomic, retain) NSString * headword;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * translation;
@property (nonatomic, retain) NSString * wordId;
@property (nonatomic, retain) HCWords *word;

@end
