//
//  TAWallPicturesViewController.h
//  TutorialACS
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cocoafish.h"
#import "Constants.h"

@interface TAWallPicturesViewController : UIViewController


@property (nonatomic, retain) IBOutlet UIScrollView *wallScroll;

-(IBAction)uploadPressed:(id)sender;
-(IBAction)logoutPressed:(id)sender;

@end
