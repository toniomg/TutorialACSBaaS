//
//  TPUploadImageViewController.m
//  TutorialParse
//
//  Created by Antonio MG on 7/4/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "TAUploadImageViewController.h"

@interface TAUploadImageViewController ()

@end

@implementation TAUploadImageViewController

@synthesize imgToUpload = _imgToUpload;
@synthesize commentTextField = _commentTextField;


-(void)dealloc
{
    [_imgToUpload release];
    [_commentTextField release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Upload";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(sendPressed:)] autorelease];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.imgToUpload = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark IB Actions

-(IBAction)selectPicturePressed:(id)sender
{
    
    //Open a UIImagePickerController to select the picture
    UIImagePickerController *imgPicker = [[[UIImagePickerController alloc] init] autorelease];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentModalViewController:imgPicker animated:YES];


}
//
-(IBAction)sendPressed:(id)sender
{
    [self.commentTextField resignFirstResponder];
    
    //Disable the send button until we are ready
    self.navigationItem.rightBarButtonItem.enabled = NO;

    //Place the loading spinner
    UIActivityIndicatorView *loadingSpinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    
    [loadingSpinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    [loadingSpinner startAnimating];
    
    [self.view addSubview:loadingSpinner];
    
    //Add the dictionary with the fields
    NSMutableDictionary *fieldsDict = [NSMutableDictionary dictionaryWithCapacity:3];
    CLLocation *location = [[[CLLocation alloc] initWithLatitude:50 longitude:41] autorelease];
    [fieldsDict setObject:location  forKey:KEY_GEOLOC];
    if ([self.commentTextField.text length] !=0) [fieldsDict setObject:self.commentTextField.text forKey:KEY_COMMENT];
    else [fieldsDict setObject:@"" forKey:KEY_COMMENT];
    
    NSDictionary *paramDict = [NSDictionary dictionaryWithObject:fieldsDict forKey:KEY_FIELDS];
    
    CCRequest *request = [[[CCRequest alloc] initWithDelegate:self httpMethod:@"POST" baseUrl:URL_WALLIMAGE_CREATE paramDict:paramDict] autorelease];
    [request addPhotoUIImage:self.imgToUpload.image paramDict:nil];
    
    [request startAsynchronous];
    
}

#pragma mark UIImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo 
{
    [picker dismissModalViewControllerAnimated:YES];
    
    //Place the image in the imageview
    self.imgToUpload.image = img;
}

#pragma mark CCRequest Delegate

-(void)ccrequest:(CCRequest *)request didSucceed:(CCResponse *)response{
    
    if ([response.meta.methodName isEqualToString:METHOD_NAME_CREATE]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)ccrequest:(CCRequest *)request didFailWithError:(NSError *)error{
    
    NSString *errorString = [error localizedDescription];
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
    [errorAlertView release];
}


#pragma mark Error View


-(void)showErrorView:(NSString *)errorMsg
{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
    [errorAlertView release];
}


@end
