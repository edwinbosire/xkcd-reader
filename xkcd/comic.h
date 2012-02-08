//
//  comic.h
//  xkcd
//
//  Created by Denis on 06/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/*
 Data model for xkcd, no further explanation needed
 */

#import <Foundation/Foundation.h>

@interface comic : NSObject {
    

    NSString *publishDate;
    NSString *title;
    NSString *imageURL;
    NSString *transcript;
    NSString *tag;
}

@property (nonatomic, strong)  NSString *publishDate;
@property (nonatomic, strong)  NSString *title;
@property (nonatomic, strong)  NSString *imageURL;
@property (nonatomic, strong)  NSString *transcript;
@property (nonatomic, strong)  NSString *tag;

@end
