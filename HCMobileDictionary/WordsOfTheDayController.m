//
//  WordsOfTheDayController.m
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 14/03/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import "WordsOfTheDayController.h"
#import "WOTDScroller.h"

@interface WordsOfTheDayController () <NSURLConnectionDataDelegate, WOTDScrollerDelegate> {
    NSMutableData *receivedData;
    WOTDScroller *wotds;
}

@end

@implementation WordsOfTheDayController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];    
    
    NSString *wordsOfTheDayURL = @"http://stage.collinsdictionary.com/7f441a97/recent";
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:wordsOfTheDayURL]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:15.0];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){

        if (error) {
            
            NSLog(@"Connection Failed! - %@ %@",
                  [error localizedDescription],
                  [[error userInfo] objectForKey:NSURLErrorFailingURLErrorKey]);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"Check your internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            return;
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Perform a JSON Serialisation on the received JSON data
        NSArray *wotdJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        wotds = [[WOTDScroller alloc] initWithFrame:CGRectMake(0.0f, 45.0f, self.view.frame.size.width, self.view.frame.size.height)];
        wotds.delegate = self;
        [self.view addSubview:wotds];
        [wotds fillScrollView:wotdJSON scrollViewHeight:300.0f];
    }];
}


- (void)scroller:(WOTDScroller *)scroller didSelectWord:(NSString *)word {
    
    if ([self.delegate respondsToSelector:@selector(controller:didSelectWord:)]) {
        [self.delegate controller:self didSelectWord:word];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
