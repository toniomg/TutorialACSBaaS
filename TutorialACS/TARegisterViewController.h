//
//  TARegisterViewController.h
//  TutorialACS
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "Cocoafish.h"

@interface TARegisterViewController : UIViewController <CCRequestDelegate>

@property (nonatomic, retain) IBOutlet UITextField *userRegisterTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordRegisterTextField;


-(IBAction)signUpUserPressed:(id)sender;
-(IBAction)cancelPressed:(id)sender;

@end
