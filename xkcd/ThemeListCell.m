//
//  ThemeListCell.m
//  AppTheme
//
//  Created by Tope on 13/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThemeListCell.h"


@implementation ThemeListCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setComicData:(Comic *) singleComic{
    
    comicTitle.text = singleComic.title;
    comicNumber.text = [NSString stringWithFormat:@"#%@", singleComic.tag];
    
    NSString *date = [NSString stringWithFormat:@"%@-%@-%@", singleComic.day, [self getMonth:singleComic.month], singleComic.year];
    
    publishcDate.text = date;
    
    detailText.text = singleComic.transcript;
    
        
}

-(NSString*) getMonth:(NSNumber *)monthNum{
    NSString *month = [[NSString alloc] init ];
    
    if (monthNum.intValue == 1) {
        month = @"JAN";
    } else if (monthNum.intValue == 2) {
        month = @"FEB";
    } else if (monthNum.intValue == 3) {
        month = @"MAR";
    } else if (monthNum.intValue == 4) {
        month = @"APR";
    } else if (monthNum.intValue == 5) {
        month = @"MAY";
    } else if (monthNum.intValue == 6) {
        month = @"JUN";
    } else if (monthNum.intValue == 7) {
        month = @"JUL";
    } else if (monthNum.intValue == 8) {
        month = @"AUG";
    } else if (monthNum.intValue == 9) {
        month = @"SEPT";
    } else if (monthNum.intValue == 10) {
        month = @"OCT";
    } else if (monthNum.intValue == 11) {
        month = @"NOV";
    } else if (monthNum.intValue == 12) {
        month = @"DEC";
    }
    
    return month;
}
@end
