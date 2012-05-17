//
//  ThemeListCell.h
//  AppTheme
//
//  Created by Tope on 13/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Comic.h"

@interface ThemeListCell : UITableViewCell{
    
    __weak IBOutlet UILabel *comicTitle;
    __weak IBOutlet UILabel *publishcDate;
    __weak IBOutlet UILabel *detailText;
    __weak IBOutlet UILabel *comicNumber;
}


-(void) setComicData:(Comic *) singleComic;
-(NSString*) getMonth:(NSNumber *)month;
@end
