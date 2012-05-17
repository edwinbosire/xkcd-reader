//
//  favouriteViewController.h
//  xkcd
//
//  Created by Edwin on 20/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comic.h"
#import "xkcdEngine.h"
#import "ThemeListCell.h"


@interface favouriteViewController : UITableViewController{
    xkcdEngine *Engine;
    Comic *comic;

}

@property (strong, nonatomic) NSMutableArray *favCollection;

- (void)retrieveData;

@end
