//
//  RecipeList.m
//  foody
//
//  Created by Tope on 01/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RecipeList.h"
#import "RecipeCell.h"
#import "RecipeDetail.h"
#import "Recipe.h"


@implementation RecipeList

@synthesize recipes;

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
    self.title = @"Dishes";

    [self loadRecipes];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipes count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"RecipeCell" owner:self options:nil];
        
        for(id currentObject in objects)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (RecipeCell *)currentObject;
                break;
            }
        }
        
    }

    Recipe *recipe = [recipes objectAtIndex:indexPath.row];
    
    [cell setDetailsWithRecipe:recipe];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // Configure the cell...
    
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    RecipeDetail *detail = [[RecipeDetail alloc] initWithNibName:@"RecipeDetail" bundle:nil];
    detail.recipe = [recipes objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

//JSONパース用のurl
-(void)loadRecipes
{
    //接続先を指定する
    NSString* url = @"http://api.punchfork.com/recipes?key=56d6e5d77b8f8f66&q=fish";
    
    //myJsonへデリゲートする
    Json *myJsonParser = [[Json alloc] init];
    
    //URLへデリゲートする
    [myJsonParser startLoadingObjectWithUrl:url andDelegate:self];
}


//JSONのパース
-(void)dataRequestCompletedWithJsonObject:(id)jsonObject
{
    NSDictionary *recipeDictionary = (NSDictionary*)jsonObject;
    
    NSArray* recipeArray = (NSArray*)[recipeDictionary objectForKey:@"recipes"];
    
    self.recipes = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dic in recipeArray) {
        
        Recipe *recipe = [[Recipe alloc] init];
        
        recipe.name = [dic objectForKey:@"title"];
        recipe.thumbNail = [dic objectForKey:@"thumb"];
        recipe.twitterShareCount = [[dic objectForKey:@"twc"] intValue];
        
        [recipes addObject:recipe];
    }
    [self.tableView reloadData];
}

@end
