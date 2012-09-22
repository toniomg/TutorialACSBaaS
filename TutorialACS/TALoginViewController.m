//
//  TALoginViewController.m
//  TutorialACS
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "TALoginViewController.h"

#import "TARegisterViewController.h"
#import "TAWallPicturesViewController.h"

@implementation TALoginViewController

@synthesize userTextField = _userTextField, passwordTextField = _passwordTextField;


-(void)dealloc
{
    [_userTextField release];
    [_passwordTextField release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Log In";
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
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.userTextField = nil;
    self.passwordTextField = nil;
}


#pragma mark IB Actions

//Show the hidden register view
-(IBAction)signUpPressed:(id)sender
{
    TARegisterViewController *registerVC = [[TARegisterViewController alloc] initWithNibName:@"TARegisterView" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
    [registerVC release];
    
}


//Login button pressed
-(IBAction)logInPressed:(id)sender
{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity:1];
    [paramDict setObject:self.userTextField.text forKey:KEY_LOGIN_USER];   
    [paramDict setObject:self.passwordTextField.text forKey:KEY_PASSWORD];
    CCRequest *request = [[[CCRequest alloc] initWithDelegate:self httpMethod:@"POST" baseUrl:URL_LOGIN paramDict:paramDict] autorelease];
    
    [request startAsynchronous];

}


#pragma mark CCRequest Delegate

-(void)ccrequest:(CCRequest *)request didSucceed:(CCResponse *)response
{
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
