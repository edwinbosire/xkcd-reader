//
//  Comic.m
//  xkcd
//
//  Created by Edwin on 20/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Comic.h"


@implementation Comic

@dynamic punchline;
@dynamic imageURL;
@dynamic month;
@dynamic tag;
@dynamic title;
@dynamic transcript;
@dynamic day;
@dynamic year;
@dynamic favourite;



-(NSString *)description{
    
    return self.title;
}
@end
