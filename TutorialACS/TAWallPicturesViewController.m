//
//  TAWallPicturesViewController.m
//  TutorialACS
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "TAWallPicturesViewController.h"
#import "TAUploadImageViewController.h"

@interface TAWallPicturesViewController () {

}

@property (nonatomic, retain) NSArray *wallObjectsArray;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;


-(void)getWallImages;
-(void)loadWallViews;
-(void)showErrorView:errorString;

@end

@implementation TAWallPicturesViewController

@synthesize wallObjectsArray = _wallObjectsArray;
@synthesize wallScroll = _wallScroll;
@synthesize activityIndicator = _loadingSpinner;



-(void)dealloc 
{
    [_wallObjectsArray release];
    [_wallScroll release];
    [_loadingSpinner release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Wall";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutPressed:)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStylePlain target:self action:@selector(uploadPressed:)] autorelease];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.wallScroll = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //Put the activity indicator in the view
    self.activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    [self.activityIndicator setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.activityIndicator];
    
    //Reload the wall
    [self getWallImages];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark Wall Load
//Load the images on the wall
-(void)loadWallViews
{
    //Clean the scroll view
    for (id viewToRemove in [self.wallScroll subviews]){
        
        if ([viewToRemove isMemberOfClass:[UIView class]])
            [viewToRemove removeFromSuperview];
    }

    
    //For every wall element, put a view in the scroll
    int originY = 10;
    
    for (NSDictionary *wallObject in self.wallObjectsArray){
        
        NSLog(@"%@", wallObject);
    
        //Build the view with the image and the comments
        UIView *wallImageView = [[UIView alloc] initWithFrame:CGRectMake(10, originY, self.view.frame.size.width - 20 , 300)];
    
        //Add the image
        NSURL *imageURL = [NSURL URLWithString:[[[wallObject objectForKey:KEY_IMAGE] objectForKey:KEY_IMAGE_URL] objectForKey:KEY_IMAGE_SIZE]];
        UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]]];
        userImage.frame = CGRectMake(0, 0, wallImageView.frame.size.width, 200);
        [wallImageView addSubview:userImage];
        [userImage release];
        
        //Add the info label (User and creation date)
//        NSDate *creationDate = wallObject;
        NSDate *creationDate = [NSDate date];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"HH:mm dd/MM yyyy"];
        
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, wallImageView.frame.size.width,15)];
        infoLabel.text = [NSString stringWithFormat:@"Uploaded by: %@, %@", [[wallObject objectForKey:KEY_USER] objectForKey:KEY_USERNAME], [df stringFromDate:creationDate]];
        infoLabel.font = [UIFont fontWithName:@"Arial-ItalicMT" size:9];
        infoLabel.textColor = [UIColor whiteColor];
        infoLabel.backgroundColor = [UIColor clearColor];
        [wallImageView addSubview:infoLabel];
        [infoLabel release];
        [df release];
        
        //Add the comment
        UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 240, wallImageView.frame.size.width, 15)];
        commentLabel.text = [wallObject objectForKey:KEY_COMMENT];
        commentLabel.font = [UIFont fontWithName:@"ArialMT" size:13];
        commentLabel.textColor = [UIColor whiteColor];
        commentLabel.backgroundColor = [UIColor clearColor];
        [wallImageView addSubview:commentLabel];
        [commentLabel release];
        
        [self.wallScroll addSubview:wallImageView];
        [wallImageView release];
        

        originY = originY + wallImageView.frame.size.width + 20;

    }
    
    //Set the bounds of the scroll
    self.wallScroll.contentSize = CGSizeMake(self.wallScroll.frame.size.width, originY);
    
    //Remove the activity indicator
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
    
}



#pragma mark Receive Wall Objects

//Get the list of images
-(void)getWallImages
{
    //In descending order
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"-%@",KEY_CREATION_DATE],@"order", nil];
    
    CCRequest *requestWall = [[[CCRequest alloc] initWithDelegate:self httpMethod:@"GET" baseUrl:URL_WALLIMAGE_GET paramDict:paramDict] autorelease];
    [requestWall startAsynchronous];

}


#pragma mark IB Actions
-(IBAction)uploadPressed:(id)sender
{
    //Go to the upload view
    TAUploadImageViewController *uploadImageViewController = [[TAUploadImageViewController alloc] initWithNibName:@"TAUploadImageView" bundle:nil];
    [self.navigationController pushViewController:uploadImageViewController animated:YES];
    [uploadImageViewController release];
        
}


-(IBAction)logoutPressed:(id)sender
{
    //Logout user
    CCRequest *request = [[[CCRequest alloc] initWithDelegate:self httpMethod:@"GET" baseUrl:URL_LOGOUT paramDict:nil] autorelease];
    [request startAsynchronous];
    
}


#pragma mark CCRequest Delegate

-(void)ccrequest:(CCRequest *)request didSucceed:(CCResponse *)response{
    
    if ([response.meta.methodName isEqualToString:METHOD_NAME_QUERY]) {

        self.wallObjectsArray = nil;
        self.wallObjectsArray = [[[NSArray alloc] initWithArray:[response.response objectForKey:WALL_OBJECT]] autorelease];
        
        [self loadWallViews];
        
    }
    else if ([response.meta.methodName isEqualToString:METHOD_NAME_LOGOUT]) {
        
        [self.navigationController popViewControllerAnimated:NO];
    }
}


-(void)ccrequest:(CCRequest *)request didFailWithError:(NSError *)error{
    
    NSString *errorString = [error localizedDescription];
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
    [errorAlertView release];
}


#pragma mark Error Alert

-(void)showErrorView:(NSString *)errorMsg{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
    [errorAlertView release];
}


@end
