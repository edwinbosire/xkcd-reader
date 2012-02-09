//
//  SecondViewController.h
//  xkcd
//
//  Created by Denis on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/*
 This class simply displays all the data that has been downloaded via the engine
 and displays the info on a uitableview
 */

#import <UIKit/UIKit.h>
#import "comic.h"
#import "xkcdEngine.h"
#import "MBProgressHUD.h"



@interface AllComicsViewController : UIViewController <MBProgressHUDDelegate, UITableViewDelegate, UITableViewDataSource>{
    
    UITableView *myTableView;
    xkcdEngine *Engine;
    MBProgressHUD *progress;

}

@property (strong, nonatomic) NSMutableArray *comicCollection;

-(void)downloadFinished:(NSMutableArray*)comics;
-(void)startDownloadProcess;
@end
