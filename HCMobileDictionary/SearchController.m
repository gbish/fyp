//
//  SearchController.m
//  HCMobileDictionary
//
//  Created by Gareth Bishop on 11/04/2013.
//  Copyright (c) 2013 com.othermedia. All rights reserved.
//

#import "SearchController.h"
#import "HCContainer.h"
#import "DefinitionViewController.h"

@interface SearchController () <UITableViewDelegate, UITableViewDataSource>
{
//    UITableView *searchTableView;
    HCContainer *container;
    DefinitionViewController *definitionController;
    NSArray *JSONData;
}

@end

@implementation SearchController

@synthesize searchTableView;
@synthesize typeFlag;

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
    
    container = [[HCContainer alloc] initWithNibName:nil bundle:nil];
    definitionController = [[DefinitionViewController alloc] initWithNibName:nil bundle:nil];
    
    // table view listing
    searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - 60.0f)];
    searchTableView.dataSource = self;
    searchTableView.delegate = self;
    
    [self.view addSubview:searchTableView];
    
    [searchTableView setHidden:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange:)
                                                 name:UITextFieldTextDidChangeNotification object:container.omniBar];
    
    typeFlag = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidChange:(NSNotification *)notice {
    
    if ([notice.name isEqualToString:UITextFieldTextDidChangeNotification]) {
        container.omniBar = (UITextField *)notice.object;
        
        NSString *term = [container.omniBar.text stringByReplacingOccurrencesOfString:@" " withString:@"-"];
        
        NSString *url = [NSString stringWithFormat:@"http://www.collinsdictionary.com/search/autocomplete/ENGLISH_DICTIONARY?term=%@", term];
        
        NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                                    cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                timeoutInterval:10.0];
        
        [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
            if (error) {
                if (!typeFlag) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"Check your internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    typeFlag = YES;
                }
                return;
            }
            
            JSONData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            [searchTableView reloadData];
            NSLog(@"%@", JSONData);
        }];
        
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"Should begin editing");
    [searchTableView setHidden:NO];
//    [_definitionView setHidden:YES];
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
    NSLog(@"%@", textField.text);
    [textField resignFirstResponder];
//    [self loadDefinitionView:textField.text];
    [searchTableView setHidden:YES];
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSString *searchResult = [JSONData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = searchResult;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return JSONData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cell = [JSONData objectAtIndex:[indexPath row]];
    container.omniBar.text = cell;
    [container.omniBar resignFirstResponder];
    [tableView setHidden:YES];
    [self.view setHidden:YES];
    [definitionController.view setHidden:NO];
    [definitionController loadDefinitionView:cell];
}


@end
