//
//  TALoginViewController.h
//  TutorialACS
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cocoafish.h"
#import "Constants.h"


@interface TALoginViewController : UIViewController <CCRequestDelegate>


@property (nonatomic, retain) IBOutlet UITextField *userTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextField;


-(IBAction)signUpPressed:(id)sender;
-(IBAction)logInPressed:(id)sender;

@end
