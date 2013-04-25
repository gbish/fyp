//
//  HCContainer.m
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 11/04/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import "HCContainer.h"
#import "UIColor_Categories.h"
#import "WordsOfTheDayController.h"
#import "SearchController.h"
#import "DefinitionViewController.h"

@interface HCContainer () <UITextFieldDelegate, UIScrollViewDelegate, WordsOfTheDayViewDelegate>
{
    WordsOfTheDayController *wotdsController;
    SearchController *searchController;
    DefinitionViewController *definitionController;
    UITextField *omniBar;
    UIView *paddingView;
    NSArray *JSONData;
    CGRect viewArea;
}

@end

@implementation HCContainer

@synthesize omniBar;

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
	// Do any additional setup after loading the view.
    
//    UIViewController *wotd = [[UIViewController alloc] init];
    
    wotdsController = [[WordsOfTheDayController alloc] initWithNibName:nil bundle:nil];
    wotdsController.delegate = self;
    searchController = [[SearchController alloc] initWithNibName:nil bundle:nil];
    definitionController = [[DefinitionViewController alloc] initWithNibName:nil bundle:nil];
    
    omniBar = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 60.0f)];
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 8.0f, 20.0f)];
    omniBar.delegate = self;
    omniBar.placeholder = @"search... e.g. cat";
    omniBar.leftView = paddingView;
    omniBar.leftViewMode = UITextFieldViewModeAlways;
    [omniBar setAutocorrectionType:UITextAutocorrectionTypeNo];
    omniBar.returnKeyType = UIReturnKeySearch;
    omniBar.backgroundColor = [UIColor colorWithHexString:@"#C6D2E2"];
    [omniBar setFont:[UIFont fontWithName:@"Times" size:36.0]];
    omniBar.textColor = [UIColor colorWithHexString:@"#194885"];
    omniBar.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    omniBar.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:omniBar];
    
    [self addChildViewController:wotdsController];
    [self addChildViewController:searchController];
    [self addChildViewController:definitionController];
    
    [self.view addSubview:wotdsController.view];
    [self.view addSubview:searchController.view];
    [self.view addSubview:definitionController.view];
    
    [searchController.view setHidden:YES];
    [definitionController.view setHidden:YES];
    
    viewArea = CGRectMake(0.0f, 60.0f, self.view.frame.size.width, self.view.frame.size.height - 60.0f);
    
    wotdsController.view.frame = viewArea;
    searchController.view.frame = viewArea;
    definitionController.view.frame = viewArea;
}


- (void)controller:(WordsOfTheDayController *)controller didSelectWord:(NSString *)word {
    omniBar.text = word.lowercaseString;
    [wotdsController.view setHidden:YES];
    [definitionController.view setHidden:NO];
    [definitionController loadDefinitionView:word];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [omniBar resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"Should begin editing");
    [definitionController.view setHidden:YES];
    [wotdsController.view setHidden:YES];
    [searchController.view setHidden:NO];
    [searchController.searchTableView setHidden:NO];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"Did begin editing");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"Should end editing");
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"Did end editing");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"Char change");
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    NSLog(@"Field Cleared");
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"Field returned");
    [textField resignFirstResponder];
    [searchController.view setHidden:YES];
    [searchController.searchTableView setHidden:YES];
    [definitionController.view setHidden:NO];
    [definitionController loadDefinitionView:textField.text];
    return YES;
}

@end
