//
//  comicViewer.h
//  xkcd
//
//  Created by Denis on 07/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comic.h"
#import "MBProgressHUD.h"


@interface comicViewer : UIViewController < MBProgressHUDDelegate,UIScrollViewDelegate>{
    
    UIScrollView *scrollView;
    UIImageView *imageView;
    UITextView  *title;
    UITextView  *transcript;
    comic *aComic;
    MBProgressHUD *progress;

    
}

@property (strong, nonatomic) comic *aComic;
@property (strong, nonatomic) UIImageView *imageView;

- (void)BackgroundImageLoadingwithURL:(NSString *)url;
@end
