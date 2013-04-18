//
//  HCWords.h
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 18/04/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HCNouns, HCTranslations, HCVerbs;

@interface HCWords : NSManagedObject

@property (nonatomic, retain) NSString * audio_path;
@property (nonatomic, retain) NSString * audio_pronunciation;
@property (nonatomic, retain) NSString * headword;
@property (nonatomic, retain) NSString * word_id;
@property (nonatomic, retain) NSSet *nouns;
@property (nonatomic, retain) NSSet *translations;
@property (nonatomic, retain) NSSet *verbs;
@end

@interface HCWords (CoreDataGeneratedAccessors)

- (void)addNounsObject:(HCNouns *)value;
- (void)removeNounsObject:(HCNouns *)value;
- (void)addNouns:(NSSet *)values;
- (void)removeNouns:(NSSet *)values;

- (void)addTranslationsObject:(HCTranslations *)value;
- (void)removeTranslationsObject:(HCTranslations *)value;
- (void)addTranslations:(NSSet *)values;
- (void)removeTranslations:(NSSet *)values;

- (void)addVerbsObject:(HCVerbs *)value;
- (void)removeVerbsObject:(HCVerbs *)value;
- (void)addVerbs:(NSSet *)values;
- (void)removeVerbs:(NSSet *)values;

@end
