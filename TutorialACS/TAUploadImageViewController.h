//
//  TPUploadImageViewController.h
//  TutorialParse
//
//  Created by Antonio MG on 7/4/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cocoafish.h"
#import "Constants.h"

@interface TAUploadImageViewController : UIViewController <UIPickerViewDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *imgToUpload;
@property (nonatomic, retain) IBOutlet UITextField *commentTextField;

-(IBAction)selectPicturePressed:(id)sender;

@end
