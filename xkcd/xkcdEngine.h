//
//  xkcdEngine.h
//  xkcd
//
//  Created by Denis on 06/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


/*
 a sub-class of MKNetworkEngine, it handles all the heavy remote data lifting
 there could be 10's of improvement appended to this class, but i cba, coz it works
 */

@class comic;

@interface xkcdEngine : MKNetworkEngine{
   
    __strong comic *currentComic;
    
}

@property (nonatomic, strong) comic *currentComic;
@property (nonatomic, strong) MKNetworkOperation *operation;

typedef void (^ComicResponseBlock)(comic* aComic);

typedef void (^ComicCollectionResponseBlock)(NSMutableArray* allComics);

- (void)getCurrentComicWithURL:(NSString*)URL onCompletion:(ComicResponseBlock) receivedComic onError:(MKNKErrorBlock) error;;
- (void)getComicCollection:(NSString*)URL onCompletion:(ComicCollectionResponseBlock) receivedComics;

@end
