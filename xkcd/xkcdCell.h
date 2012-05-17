//
//  xkcdCell.h
//  xkcd
//
//  Created by Denis on 08/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comic.h"
@interface xkcdCell : UITableViewCell

@property (nonatomic, strong)  UILabel *comicTitle;
@property (nonatomic, strong)  UILabel *publishcDate;
@property (nonatomic, strong)  UILabel *comicNumber;

-(void) setComicData:(Comic *) singleComic;

@end
