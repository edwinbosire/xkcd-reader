//
//  comicViewer.m
//  xkcd
//
//  Created by Denis on 07/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "comicViewer.h"
#import <QuartzCore/QuartzCore.h>
#import "MKNetworkKit.h"
#import "EGOImageView.h"
#import "EGOImageLoader.h"
@implementation comicViewer
@synthesize aComic;
@synthesize imageView;
@synthesize operation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, 460)];
        [scrollView setBackgroundColor:[UIColor clearColor]];
        scrollView.minimumZoomScale = 0.5;
        scrollView.maximumZoomScale = 1.5;
        scrollView.delegate =self;
        scrollView.contentSize = CGSizeMake(320, 460);
        scrollView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        scrollView.showsHorizontalScrollIndicator = YES;
        [self.view addSubview:scrollView];
        
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage_repeat"]];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [EGOimageView cancelImageLoad];
}

-(void)setAComic:(Comic *)newComic{
    
    if (aComic) {
        aComic = nil;
    }
    aComic = newComic;
//    self.title = aComic.title;
     Engine = [[xkcdEngine alloc] init];
    if ([[Engine retrieveFavouritesComics] containsObject:aComic]) {
        save.enabled = NO;
    }else{
        save.enabled = YES;
    }
        
    [self BackgroundImageLoadingwithURL:aComic.imageURL];
}



-(void)setImageView:(EGOImageView *)newImageView{
    
    if (imageView) {
        imageView = nil;
    }
    
    //lets calculate the dimensions and positioning of the image
    //this allows us to centre the image in the screen
    
    float xPadding=0;
    float yPadding=0;
    float imageWidth = newImageView.image.size.width;
    float imageHeight = newImageView.image.size.height;
    
    if (imageWidth < 320) {
        xPadding = (320 - imageWidth)/2;
    }
    if (imageHeight < 369){
        yPadding = (369 - imageHeight)/2;
    }
    
    imageView = [[EGOImageView alloc] init];
    imageView.frame = CGRectMake(xPadding, yPadding, newImageView.image.size.width, newImageView.image.size.height);
   
    imageView.contentMode = UIViewContentModeTop;
    
    imageView.image = newImageView.image;
    
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [[UIColor grayColor]CGColor];
    [scrollView addSubview:imageView];
    
    scrollView.contentSize = CGSizeMake(newImageView.image.size.width, newImageView.image.size.height+50);
    [scrollView setNeedsDisplay];
    
    [progress hide:YES];
    
    
    //load transcript view here
     size = [aComic.transcript sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] 
                                constrainedToSize:CGSizeMake(320, 150) 
                                    lineBreakMode:UILineBreakModeWordWrap];
    
    if (size.height <28) {
        size.height = 35;
    }

    infoView = [[transcriptViewController alloc] initWithFrame:CGRectMake(0,(460 - size.height - 25 ),320, 150)];
    infoView.transcriptText = aComic.transcript;
    
  
    NSLog(@"Comic Transcript %@", aComic.transcript);
//    infoView.layer.borderColor = [[UIColor redColor] CGColor];
//    infoView.layer.borderWidth = 2;
    [self.view addSubview:infoView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleNavBar:)];
    [self.view addGestureRecognizer:gesture];
    
}

- (void)toggleNavBar:(UITapGestureRecognizer *)gesture {
    //hide the navigation bar
    BOOL barsHidden = self.navigationController.navigationBar.hidden;
    
    
    //hide the transcript info view
    
    float hidden;
    float moved;
    if (!barsHidden) {
        hidden = (460 + size.height + 25 );
        moved = 0;
    }else{
        hidden = (460 - size.height - 25 );
        moved = 44;
    }
    
   
    [UIView animateWithDuration:0.7
                     animations:^(void){
                         infoView.frame = CGRectMake(0, hidden, 320, 150);
                         scrollView.frame = CGRectMake(0, moved, 320, 460);
                     }completion:^(BOOL finished){
                         
                         [self.navigationController setNavigationBarHidden:!barsHidden animated:YES];

                     }];
    
}

- (void)BackgroundImageLoadingwithURL:(NSString *)url{
    

    
    NSLog(@"url %@", url);
    
    EGOimageView.imageURL = [NSURL URLWithString:aComic.imageURL];
//    self.imageView = EGOimageView;    
    
    
}

-(void)imageViewLoadedImage:(EGOImageView *)loadedImageView{
    [self setImageView:loadedImageView];
}

-(void)imageViewFailedToLoadImage:(EGOImageView *)imageView error:(NSError *)error{
    
    NSLog(@"there has been a problem loading that comic");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Loading Comic" 
                                                   message:@"There has been an error loading the selected comic" 
                                                  delegate:self 
                                         cancelButtonTitle:@"OK" 
                                         otherButtonTitles:nil, nil];
    
    [alert show];
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return imageView;
}
-(void)hudWasHidden{
    
    [progress removeFromSuperViewOnHide];
}
#pragma mark - View lifecycle


//- (void)loadView
//{
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    progress = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:progress];
    progress.delegate = self;
    progress.labelText = @"Loading XKCD...";    
    [progress show:YES];
    
    save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(addToFavourites)];
    //magnify = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:nil];
    
    self.navigationItem.rightBarButtonItems =[NSArray arrayWithObjects:save, nil];

    
    EGOimageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder.png"] delegate:self];
    
    EGOimageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
   
}

-(void)addToFavourites{
    
    [Engine setFavourites:aComic];
        save.enabled = NO;
    
      
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait); // || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
