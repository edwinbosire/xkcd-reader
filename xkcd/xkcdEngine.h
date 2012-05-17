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
#import <RestKit/RestKit.h>
#import <CoreData/CoreData.h>

@class Comic;

@interface xkcdEngine : MKNetworkEngine <RKObjectLoaderDelegate>
   


- (NSArray*)retrieveComics;
- (void) initializeStorage;

-(void)removeFromFavaourites:(Comic*)notFav;
- (void)setFavourites:(Comic*)fav;
- (NSArray*)retrieveFavouritesComics;

- (void)loadData;
@end
