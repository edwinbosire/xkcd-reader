//
//  xkcdEngine.m
//  xkcd
//
//  Created by Denis on 06/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "xkcdEngine.h"
#import "comic.h"
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>


@implementation xkcdEngine
//@synthesize operation;


- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}
/*
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
*/

/*
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
*/

- (void)initializeStorage{
    
    // Initialize RestKit
	RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://xkcd.com/"];
//    objectManager.serializationMIMEType = RKMIMETypeJSON;
//    objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"XKCDDataStore.sqlite"];
    // Enable automatic network activity indicator management
    objectManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
    // Initialize object store
#ifdef RESTKIT_GENERATE_SEED_DB
    NSString *seedDatabaseName = nil;
    NSString *databaseName = RKDefaultSeedDatabaseFileName;
#else
    NSString *seedDatabaseName = RKDefaultSeedDatabaseFileName;
    NSString *databaseName = @"XKCDDataStore.sqlite";
#endif
    
    objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:databaseName usingSeedDatabaseName:seedDatabaseName managedObjectModel:nil delegate:self];
    
    
    // Setup our object mappings    [@"remote response", @"dataModel"]
    RKManagedObjectMapping* comicMapping = [RKManagedObjectMapping mappingForClass:[Comic class]];
    [comicMapping setPrimaryKeyAttribute:@"tag"];
    [comicMapping mapKeyPathsToAttributes:
     
     @"title", @"title",
     @"img", @"imageURL",  
     @"alt", @"transcript", 
     @"transcript",@"punchline",
     @"month", @"month",  
     @"day", @"day",
     @"year",@"year",
    
     @"num", @"tag",

     nil];
    
    
    [objectManager.mappingProvider setMapping:comicMapping forKeyPath:@"Comic"];
    
    
#ifdef RESTKIT_GENERATE_SEED_DB
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelInfo);
    RKLogConfigureByName("RestKit/CoreData", RKLogLevelTrace);
    RKManagedObjectSeeder* seeder = [RKManagedObjectSeeder objectSeederWithObjectManager:objectManager];
    
    // Seed the database with instances of Articles from a snapshot of the RestKit news clone
    [seeder seedObjectsFromFile:@"RKSeedDataBase.sqlite" withObjectMapping:newsArticleMapping];
    
    
    
    // Finalize the seeding operation and output a helpful informational message
    [seeder finalizeSeedingAndExit];
    
#endif
}


- (void)loadData {
    // Load the object model via RestKit	
    RKObjectManager* objectManager = [RKObjectManager sharedManager];
    
    //1)get the latest comic
    NSError *error = nil;
    NSData *latestComic  = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://xkcd.com/info.0.json"]
                                                 options:NSDataReadingMapped
                                                   error:&error];
    
    NSLog(@"error %@", error);
    if (error) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                        message:@"Sorry, There Has Been A Network Problem"
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else{
        
                
    NSDictionary *latestDict = [NSJSONSerialization JSONObjectWithData:latestComic options:0 error:nil];
    NSNumber *currentIssue = [latestDict objectForKey:@"num"];
    
    //2)compare latest comic number
    Comic *comparisonComic;
    if ([self retrieveComics].count > 0) {  //check if we have nil records 
         comparisonComic = [[self retrieveComics] objectAtIndex:0];
    }else{ //if no other comics saved, start from 0
        comparisonComic.tag = 0;
    }
    
    //if this is the latest issue, dont continue, at the moment current issue >1000
    if (comparisonComic.tag == currentIssue) {
        return;
    }
    //3)retrieve all comics between the newest in db and the latest online.
    
    NSInteger x;
    for ( x =(comparisonComic.tag).integerValue ; x <= currentIssue.integerValue; ++x) {
        
        NSString *resourcePath = [NSString stringWithFormat:@"/%i/info.0.json", x];
        [objectManager loadObjectsAtResourcePath:resourcePath delegate:self block:^(RKObjectLoader* loader) {
            
            loader.objectMapping = [objectManager.mappingProvider objectMappingForClass:[Comic class]];
        }];
    }
        
    }
    
}


#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    
   // NSLog(@"downloaded data: %@",objects);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ComicReady" object:nil];
    
	
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    
    NSLog(@"url %@", objectLoader);
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                     message:@"There Is A Network Problem, Please Try Reloading Later"
                                                    delegate:nil 
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	NSLog(@"Hit error: %@", error);
}

- (NSArray*)retrieveComics{
    
    
    NSFetchRequest* request = [Comic fetchRequest];
    NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
    
    return [Comic objectsWithFetchRequest:request];
    
}

- (NSArray*)retrieveFavouritesComics{
    
    
    NSFetchRequest* request = [Comic fetchRequest];
    NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"favourite == 1"];
    [request setPredicate:predicate];
    
    return [Comic objectsWithFetchRequest:request];
    
}
- (void)setFavourites:(Comic*)fav{
    
    
    NSFetchRequest* request = [Comic fetchRequest];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"tag == %i", fav.tag.integerValue];
    [request setPredicate:predicate];
    
    Comic *item = [[Comic objectsWithFetchRequest:request] lastObject];
    if (item) {
        [item setFavourite:[NSNumber numberWithBool:YES]];
        
        NSError *error=nil;
        
        [[Comic managedObjectContext] save:&error];
        if (error) {
            NSLog(@"error saving favourite item");
        }else{
            NSLog(@"save successful");
        }
    }
    
    
}



-(void)removeFromFavaourites:(Comic*)notFav{
    
    
    NSFetchRequest* request = [Comic fetchRequest];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"tag == %i", notFav.tag.integerValue];
    [request setPredicate:predicate];
    
    Comic *item = [[Comic objectsWithFetchRequest:request] lastObject];
    if (item) {
        [item setFavourite:[NSNumber numberWithBool:NO]];
        
        NSError *error=nil;
        
        [[Comic managedObjectContext] save:&error];
        if (error) {
            NSLog(@"error saving favourite item");
        }else{
            NSLog(@"save successful");
        }
    }
    
}

@end
