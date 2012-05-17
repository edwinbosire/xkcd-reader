//
//  favouriteViewController.m
//  xkcd
//
//  Created by Edwin on 20/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "favouriteViewController.h"
#import "comicViewer.h"
#import "xkcdCell.h"

@implementation favouriteViewController
@synthesize favCollection;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
    Engine = [[xkcdEngine alloc] init];
  
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-mesh.jpg"]];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(retrieveData) name:@"ComicReady" object:nil];
    
    
}


- (void)retrieveData{
    
    
    favCollection = (NSMutableArray*)[Engine retrieveFavouritesComics];
    if (favCollection) {
        [self.tableView reloadData];
        
    }
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self retrieveData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [favCollection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    Comic *singleComic = [self.favCollection objectAtIndex:indexPath.row];
    [cell setComicData:singleComic];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [Engine removeFromFavaourites:[favCollection objectAtIndex:indexPath.row]];
        favCollection = (NSMutableArray*)[Engine retrieveFavouritesComics];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comic *singleComic = [self.favCollection objectAtIndex:indexPath.row];
    comicViewer *ComicView = [[comicViewer alloc] initWithNibName:nil bundle:nil];
    
    ComicView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ComicView animated:YES];
    ComicView.aComic = singleComic;
}

@end
