//
//  TARegisterViewController.m
//  TutorialACS
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "TARegisterViewController.h"
#import "TAWallPicturesViewController.h"

@interface TARegisterViewController ()

@end

@implementation TARegisterViewController

@synthesize userRegisterTextField = _userRegisterTextField, passwordRegisterTextField = _passwordRegisterTextField;

-(void)dealloc
{
    
    [_userRegisterTextField release];
    [_passwordRegisterTextField release];
    
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Sign Up";
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.userRegisterTextField = nil;
    self.passwordRegisterTextField = nil;
}


#pragma mark IB Actions

////Sign Up Button pressed
-(IBAction)signUpUserPressed:(id)sender
{
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity:3];
    [paramDict setObject:self.userRegisterTextField.text forKey:KEY_USER];    
    [paramDict setObject:self.passwordRegisterTextField.text forKey:KEY_PASSWORD];   
    [paramDict setObject:self.passwordRegisterTextField.text forKey:KEY_PASSWORD_CONFIRMATION]; 
    CCRequest *request = [[[CCRequest alloc] initWithDelegate:self httpMethod:@"POST" baseUrl:URL_CREATE_USER paramDict:paramDict] autorelease];

    [request startAsynchronous];
    
}


#pragma mark CCRequest Delegate

-(void)ccrequest:(CCRequest *)request didSucceed:(CCResponse *)response{
    
    NSArray *users = [response getObjectsOfType:[CCUser class]];
    
    if ([users count] == 1) {
        
        TAWallPicturesViewController *wallVC = [[TAWallPicturesViewController alloc] initWithNibName:@"TAWallPicturesView" bundle:nil];
        [self.navigationController pushViewController:wallVC animated:NO];
        [wallVC release];
        
    }
    
}


-(void)ccrequest:(CCRequest *)request didFailWithError:(NSError *)error
{
    
    NSString *errorString = [error localizedDescription];
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
    [errorAlertView release];
    
    
}

@end
