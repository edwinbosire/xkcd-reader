//
//  Comic.h
//  xkcd
//
//  Created by Edwin on 20/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Comic : NSManagedObject

@property (nonatomic, retain) NSString * punchline;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * month;
@property (nonatomic, retain) NSNumber * tag;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * transcript;
@property (nonatomic, retain) NSNumber * day;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSNumber * favourite;

@end
