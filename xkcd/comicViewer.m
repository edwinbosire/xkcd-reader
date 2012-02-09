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
@implementation comicViewer
@synthesize aComic;
@synthesize imageView;
@synthesize operation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, 320, 410)];
        [scrollView setBackgroundColor:[UIColor clearColor]];
        scrollView.minimumZoomScale = 0.5;
        scrollView.maximumZoomScale = 1.5;
        scrollView.delegate =self;
        scrollView.contentSize = CGSizeMake(320, 460);
        
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

-(void)setAComic:(comic *)newComic{
    
    if (aComic) {
        aComic = nil;
    }
    aComic = newComic;
    self.title = aComic.title;
    [self BackgroundImageLoadingwithURL:aComic.imageURL];
}

-(void)setImageView:(UIImageView *)newImageView{
    
    if (imageView) {
        imageView = nil;
    }
    
    //lets calculate the dimensions and positioning of the image
    //this allows us to centre the image in the screen
    
    float xPadding=0;
    float yPadding=0;
    float imageWidth = newImageView.bounds.size.width;
    float imageHeight = newImageView.bounds.size.height;
    
    if (imageWidth < 320) {
        xPadding = (320 - imageWidth)/2;
    }
    if (imageHeight < 369){
        yPadding = (369 - imageHeight)/2;
    }
    
    imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(xPadding, yPadding, newImageView.bounds.size.width, newImageView.bounds.size.height);
    imageView.contentMode = UIViewContentModeTop;
    
    imageView.image = newImageView.image;
    
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [[UIColor grayColor]CGColor];
    [scrollView addSubview:imageView];
    scrollView.contentSize = CGSizeMake(newImageView.image.size.width, newImageView.image.size.height+50);
    [scrollView setNeedsDisplay];
    
    [progress hide:YES];
}
- (void)BackgroundImageLoadingwithURL:(NSString *)url{
    
//    dispatch_queue_t backgroundQueue = dispatch_queue_create("uk.co.edwinb.xkcd", NULL);
//    
//    dispatch_async(backgroundQueue, ^{
//        NSURL *properURL = [NSURL URLWithString:url];
//        NSData *imageData = [NSData dataWithContentsOfURL:properURL];
//        UIImage *image = [UIImage imageWithData:imageData];
//        UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            [self setImageView:imgView];
//            
//        });
//    });
    
    MKNetworkEngine *imageEngine = [[MKNetworkEngine alloc] initWithHostName:@"xkcd.com" customHeaderFields:nil];
    
    self.operation = [imageEngine imageAtURL:[NSURL URLWithString:url] onCompletion:^(UIImage *fetchedImage, NSURL *imageURL, BOOL isInCache){
        
        if([url isEqualToString:[imageURL absoluteString]]) {
            
            if (isInCache) {
                [self.imageView setImage:fetchedImage];
            } else {
                UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                loadedImageView.frame = self.imageView.frame;
                loadedImageView.alpha = 0;
                [scrollView addSubview:loadedImageView];
                [UIView animateWithDuration:0.4
                                 animations:^
                 {
                     loadedImageView.alpha = 1;
                     self.imageView.alpha = 0;
                 }
                                 completion:^(BOOL finished)
                 {
                     self.imageView.image = fetchedImage;
                     self.imageView.alpha = 1;
                     [loadedImageView removeFromSuperview];
                 }];
            }
        }
    }];
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    progress = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:progress];
    progress.delegate = self;
    progress.labelText = @"Loading XKCD...";    
    [progress show:YES];
    
    
    
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
