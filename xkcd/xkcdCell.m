//
//  xkcdCell.m
//  xkcd
//
//  Created by Denis on 08/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "xkcdCell.h"
@implementation xkcdCell

@synthesize comicNumber;
@synthesize publishcDate;
@synthesize comicTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.frame = CGRectMake(0, 0, 320, 55);
        comicTitle = [[UILabel alloc] initWithFrame:CGRectMake(3, 10, 250, 20)];
        comicNumber = [[UILabel alloc] initWithFrame:CGRectMake(270, 5, 50, 15)];
        publishcDate = [[UILabel alloc] initWithFrame:CGRectMake(220, 28, 100, 15)];
        
        [comicNumber setFont:[UIFont fontWithName:@"Helvetica" size:10]];
        [publishcDate setFont:[UIFont fontWithName:@"Helvetica" size:10]];
        [comicNumber setTextAlignment:UITextAlignmentRight];
        [publishcDate setTextAlignment:UITextAlignmentRight];
        
        
        [self addSubview:comicTitle];
        [self addSubview:comicNumber];
        [self addSubview:publishcDate];
        
    }
    return self;
}

//-(void)prepareForReuse{
//    self.comicTitle =nil;
//    self.comicNumber =nil;
//    self.publishcDate =nil;
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setComicData:(comic *) singleComic{
    
    self.comicTitle.text = singleComic.title;
    self.publishcDate.text = [singleComic publishDate];
    self.comicNumber.text = [NSString stringWithFormat:@"#%@", singleComic.tag];
    
    //NSLog(@"=======comic tag %@=======", singleComic.tag);

}

@end
