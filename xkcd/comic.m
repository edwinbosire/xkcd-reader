//
//  comic.m
//  xkcd
//
//  Created by Denis on 06/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "comic.h"

@implementation comic

@synthesize publishDate;
@synthesize title;
@synthesize imageURL;
@synthesize transcript;
@synthesize tag;

- (id)init {
    self = [super init];
    if (self) {
        //nothing to init at the moment
    }
    return self;
}
@end
