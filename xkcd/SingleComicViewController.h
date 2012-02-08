//
//  FirstViewController.h
//  xkcd
//
//  Created by Denis on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 I should be beaten for including this code here, it is superflous, you can ignore it entirely
 */

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class xkcdEngine;

@interface SingleComicViewController : UIViewController<MBProgressHUDDelegate, UIScrollViewDelegate>{
    
    
    __weak IBOutlet UITextView *transcripts;
    __weak IBOutlet UITextView *comicTitle;
    __weak IBOutlet UIImageView *comicImage;
    MBProgressHUD *progress;
    __weak IBOutlet UIScrollView *scrollView;
    
    
     
}
@property (weak, nonatomic) IBOutlet UIImageView *comicImage;
@property (strong, nonatomic) xkcdEngine *engine;

-(void)downloadComic;

@end
