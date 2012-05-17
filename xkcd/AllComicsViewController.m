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
#import "ThemeListCell.h"

#define XKCDSPECIFIC @"614/info.0.json"
#define XKCD_URL(__COMICNUMBER__) [NSString stringWithFormat:@"%@/info.0.json", __COMICNUMBER__]


@implementation AllComicsViewController
@synthesize comicCollection;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.title = NSLocalizedString(@"All", @"All");
        self.tabBarItem.image = [UIImage imageNamed:@"skull-n-bones"];
        [self.view setBackgroundColor:[UIColor blackColor]];
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
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource =self;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:myTableView];
    comicCollection = [[NSMutableArray alloc] init ];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-mesh.jpg"]];
    
    progress = [[MBProgressHUD alloc] initWithView:self.view];
    [progress setMode:MBProgressHUDModeDeterminate];
    [self.view addSubview:progress];
    progress.delegate = self;
    progress.labelText = @"Loading XKCD...";    
    [progress show:YES];
    
//    [self startDownloadProcess];
    Engine = [[xkcdEngine alloc] init];
    
    [Engine initializeStorage];
    [Engine loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(retrieveData) name:@"ComicReady" object:nil];

    [self retrieveData];
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{

    return (toInterfaceOrientation == UIInterfaceOrientationPortrait); // || interfaceOrientation == UIInterfaceOrientationLandscapeRight);

}
#pragma mark -
#pragma mark - Download XKCD

- (void)retrieveData{
    
    
    comicCollection = (NSMutableArray*)[Engine retrieveComics];
    if (comicCollection) {
        [progress hide:YES];
        [myTableView reloadData];
        
    }
    
}



- (void)startDownloadProcess{
//    NSMutableDictionary *headerFields = [NSMutableDictionary dictionary]; 
//    [headerFields setValue:@"iOS" forKey:@"x-client-identifier"];
//    
//    Engine = [[xkcdEngine alloc] initWithHostName:@"xkcd.com" customHeaderFields:headerFields];
//    [Engine useCache];
//    
//    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
//    for (int x=400; x<615; x++) {
//        
//        NSString *currentTag = [NSString stringWithFormat:@"%i",x];
//        
//        [Engine getCurrentComicWithURL:XKCD_URL([currentTag urlEncodedString]) onCompletion:^(Comic *aComic) {
//            
//            [tempArray addObject:aComic];
//            
//            if (x==614) [self downloadFinished:tempArray];
//            
//        }
//                               onError:^(NSError *error){
//                                   
//                                   NSLog(@"%@\t%@\t%@\t%@", [error localizedDescription], [error localizedFailureReason], 
//                                         [error localizedRecoveryOptions], [error localizedRecoverySuggestion]);
//                                   
//                               }];
//        
//        [Engine.operation onDownloadProgressChanged:^(double progressStatus){
//            
//            NSLog(@"download Progress %.2f ", progressStatus*100);
//            [progress setProgress:progressStatus];
//        }];
//    }
    
    
    
}

- (void)downloadFinished:(NSMutableArray*)comics{
    
    
    [comics sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:NO]]];
    [comicCollection removeAllObjects];
    comicCollection = comics;
    [myTableView reloadData];
    [progress hide:YES];
}

- (void)hudWasHidden{
    
    [progress removeFromSuperViewOnHide];
}




#pragma mark -
#pragma mark - AutoRotate




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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    static NSString *CellIdentifier = @"Cell";
    ThemeListCell *cell =nil;
    cell = (ThemeListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ThemeListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    Comic *singleComic = [self.comicCollection objectAtIndex:indexPath.row];
    [cell setComicData:singleComic];
    
    return cell;
    */
    
    static NSString *CellIdentifier = @"Cell";    
    ThemeListCell *cell = (ThemeListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"ThemeListCell" owner:self options:nil];
        
        for(id currentObject in objects)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (ThemeListCell *)currentObject;
                break;
            }
        }
        
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    Comic *singleComic = [self.comicCollection objectAtIndex:indexPath.row];
    [cell setComicData:singleComic];
    return cell;
     
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    Comic *singleComic = [self.comicCollection objectAtIndex:indexPath.row];
    comicViewer *ComicView = [[comicViewer alloc] initWithNibName:nil bundle:nil];
    
    ComicView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ComicView animated:YES];
    ComicView.aComic = singleComic;
    
}

@end
