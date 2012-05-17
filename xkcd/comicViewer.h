//
//  comicViewer.h
//  xkcd
//
//  Created by Denis on 07/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comic.h"
#import "MBProgressHUD.h"
#import "EGOImageView.h"
#import "EGOImageLoader.h"
#import "xkcdEngine.h"
#import "transcriptViewController.h"

@interface comicViewer : UIViewController < MBProgressHUDDelegate,UIScrollViewDelegate, EGOImageViewDelegate >{
    
    UIScrollView *scrollView;
    EGOImageView *imageView;
    UITextView  *title;
    UITextView  *transcript;
    Comic *aComic;
    MBProgressHUD *progress;
    EGOImageView *EGOimageView;
    UIView *transcriptView;
    UIBarButtonItem *save;
    xkcdEngine *Engine;
    transcriptViewController *infoView;
    CGSize size;

    
}

@property (strong, nonatomic) Comic *aComic;
@property (strong, nonatomic) EGOImageView *imageView;
@property (nonatomic, strong) MKNetworkOperation *operation;


- (void)BackgroundImageLoadingwithURL:(NSString *)url;
- (void)toggleNavBar:(UITapGestureRecognizer *)gesture;
@end
