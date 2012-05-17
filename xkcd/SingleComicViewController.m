//
//  FirstViewController.m
//  xkcd
//
//  Created by Denis on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SingleComicViewController.h"
#import "xkcdEngine.h"
#import "comic.h"

#define XKCDURL @"info.0.json"
#define XKCDXML @"http://xkcd.com/rss.xml"
#define XKCDSPECIFIC @"614/info.0.json"

@implementation SingleComicViewController
@synthesize comicImage;
@synthesize engine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Latest", @"Latest");
        self.tabBarItem.image = [UIImage imageNamed:@"singleComic"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView.contentSize = CGSizeMake(470 , 300);
    scrollView.scrollEnabled = YES;
    
    //bring up the progressHUD
    
    progress = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:progress];
    progress.delegate = self;
    progress.labelText = @"Loading XKCD...";    
    [progress show:YES];

    [self downloadComic];


}

-(void)downloadComic{
//    engine = [[xkcdEngine alloc] initWithHostName:@"xkcd.com" customHeaderFields:nil];
//    
//    
//    [engine getCurrentComicWithURL:XKCDSPECIFIC onCompletion:^(comic *aComic){
//        
//        comic *latestComic = [[comic alloc] init];
//        latestComic = aComic;
//        comicImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:latestComic.imageURL]]];
//        transcripts.text = latestComic.transcript;
//        comicTitle.text = latestComic.title;
//        
//        [progress hide:YES];
//        
//        
//    }onError:^(NSError *error){
//        
//        NSLog(@"%@\t%@\t%@\t%@", [error localizedDescription], [error localizedFailureReason], 
//             [error localizedRecoveryOptions], [error localizedRecoverySuggestion]);
//     
//     
//    } ];
    

}
-(void)hudWasHidden{
    
    [progress removeFromSuperViewOnHide];
}
- (void)viewDidUnload
{
    [self setComicImage:nil];
    comicImage = nil;
    comicTitle = nil;
    transcripts = nil;
    scrollView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)_scrollView{
    
    return [scrollView.subviews objectAtIndex:0];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"scrolling performed");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
