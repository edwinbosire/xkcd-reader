//
//  xkcdEngine.m
//  xkcd
//
//  Created by Denis on 06/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "xkcdEngine.h"
#import "comic.h"


@implementation xkcdEngine
@synthesize currentComic;
@synthesize operation;

- (void)getCurrentComicWithURL:(NSString*)URL onCompletion:(ComicResponseBlock) receivedComic onError:(MKNKErrorBlock) errorBlock;{
    
    self.operation = [self operationWithPath:URL params:nil httpMethod:@"GET"];
    
    
    [self.operation onCompletion:^(MKNetworkOperation *completedOperation){

      
        if([completedOperation isCachedResponse]) {
            NSLog(@"cached response returned");
            
          
        }
        else {
            NSLog(@"fresh data loaded");
            NSDictionary *response = [completedOperation responseJSON];
            currentComic = [[comic alloc] init];
            
            currentComic.title = [response objectForKey:@"title"];
            currentComic.imageURL = [response objectForKey:@"img"];
            currentComic.transcript = [response objectForKey:@"alt"];
            currentComic.tag = [response objectForKey:@"num"];
            
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setDay:[[response objectForKey:@"date"] intValue]];
            [components setMonth:[[response objectForKey:@"month"]intValue]];
            [components setYear:[[response objectForKey:@"year"]intValue] ];
            
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDate *date = [gregorian dateFromComponents:components];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd MMM, yyyy"];
            
            NSString *date2 = [formatter stringFromDate:date];
            currentComic.publishDate = date2;
            
            receivedComic(currentComic);  
            
        }
        
    }onError:^(NSError *error){
        NSLog(@"there has been an error %@", error);
        errorBlock(error);
                    }];
    
    
    [self enqueueOperation:self.operation];
    
    
}

- (void)getComicCollection:(NSString*)URL onCompletion:(ComicCollectionResponseBlock) receivedComics{
    
    self.operation = [self operationWithPath:URL params:nil httpMethod:@"GET"];
    [self.operation onCompletion:^(MKNetworkOperation *completedOperation){
        NSDictionary *response = [completedOperation responseJSON];
        
        if (!response) {
            return;
        }
        currentComic = [[comic alloc] init];
        NSMutableArray *comicArray = [[NSMutableArray alloc] init ];
        
        currentComic.title = [response objectForKey:@"title"];
        currentComic.imageURL = [response objectForKey:@"img"];
        currentComic.transcript = [response objectForKey:@"alt"];
        currentComic.tag = [response objectForKey:@"num"];

        
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setDay:[[response objectForKey:@"date"] intValue]];
        [components setMonth:[[response objectForKey:@"month"]intValue]];
        [components setYear:[[response objectForKey:@"year"]intValue] ];
        
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *date = [gregorian dateFromComponents:components];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMM, yyyy"];
        
        NSString *date2 = [formatter stringFromDate:date];
        currentComic.publishDate = date2;
        
        [comicArray addObject:currentComic];
        currentComic = nil;
        
        receivedComics(comicArray);
        
        if([completedOperation isCachedResponse]) {
            // NSLog(@"Data from cache %@", [completedOperation responseJSON]);
        }
        else {
            //NSLog(@"Data from server %@", [completedOperation responseString]);
        }
    }onError:^(NSError *error){
        NSLog(@"there has been an error %@", error);
    }];
    
    [self enqueueOperation:self.operation];
    [self useCache];
    
}

@end
