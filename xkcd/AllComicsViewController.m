//
//  SecondViewController.m
//  xkcd
//
//  Created by Denis on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AllComicsViewController.h"
#import "comicViewer.h"
#import "xkcdCell.h"


#define XKCDSPECIFIC @"614/info.0.json"
#define XKCD_URL(__COMICNUMBER__) [NSString stringWithFormat:@"%@/info.0.json", __COMICNUMBER__]


@implementation AllComicsViewController
@synthesize comicCollection;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"All", @"All");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = CGRectMake(0, 47, 320, 370);
    myTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource =self;
    
    [self.view addSubview:myTableView];
    comicCollection = [[NSMutableArray alloc] init ];
    
    progress = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:progress];
    progress.delegate = self;
    progress.labelText = @"Loading XKCD...";    
    [progress show:YES];
    
    
    
    Engine = [[xkcdEngine alloc] initWithHostName:@"xkcd.com" customHeaderFields:nil];
    [Engine useCache];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int x=400; x<615; x++) {
        
        NSString *currentTag = [NSString stringWithFormat:@"%i",x];
        
        [Engine getCurrentComicWithURL:XKCD_URL([currentTag urlEncodedString]) onCompletion:^(comic *aComic){
            
            [tempArray addObject:aComic];
            
            if (x==614) [self downloadFinished:tempArray];
            
        }];
    }
    
    
    
}

-(void)downloadFinished:(NSMutableArray*)comics{
    
    
    [comics sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:NO]]];
    [comicCollection removeAllObjects];
    comicCollection = comics;
    [myTableView reloadData];
    [progress hide:YES];
}
-(void)hudWasHidden{
    
    [progress removeFromSuperViewOnHide];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View methods
#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // [self.comicCollection valueForKey:[[self.comicCollection allKeys] objectAtIndex:section ] count];
    return [self.comicCollection  count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    xkcdCell *cell =nil;
    cell = (xkcdCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[xkcdCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    comic *singleComic = [self.comicCollection objectAtIndex:indexPath.row];
    [cell setComicData:singleComic];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    comic *singleComic = [self.comicCollection objectAtIndex:indexPath.row];
    comicViewer *ComicView = [[comicViewer alloc] initWithNibName:nil bundle:nil];
    
    ComicView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ComicView animated:YES];
    ComicView.aComic = singleComic;
    
}

@end
