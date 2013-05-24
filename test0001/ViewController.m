//
//  ViewController.m
//  test0001
//
//  Created by Chenlei on 13-5-22.
//  Copyright (c) 2013年 Chenlei. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"
#import "SubViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize arr;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initializatio
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title =@"创意分类";
    [self JSON];
}

-(void)JSON{
    NSString * url = @"http://www.zhongchou.cn/mobile/index.php?ctl=index&act=getDealCate&cnt=1";
    NSURL * queryUrl = [[NSURL alloc]initWithString:url];
    ASIHTTPRequest *req=[[ASIHTTPRequest alloc] initWithURL:queryUrl];
    [queryUrl release];
    req.delegate = self;
    [req startAsynchronous];
    [req release];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    if (arr!=nil) {
        [arr release];
        arr=nil;
    }
    NSData *data =[request responseData];
    NSError *error;
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    //arr = [[NSMutableArray alloc]init];
    arr = [dic objectForKey:@"data"];
    [arr retain];
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    Cell *cell = (Cell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSInteger row=[indexPath row];
    [cell setCellTitle:[[arr objectAtIndex:row] objectForKey:@"name"]];
    NSString *string=[NSString stringWithString:[[arr objectAtIndex:row] objectForKey:@"appimg"]];
    string=[string substringFromIndex:1];
    NSString *str=[NSString stringWithFormat:@"http://www.zhongchou.cn%@",string];
    [cell setImage:str];
    [cell setCellDetailTextLabel:[[arr objectAtIndex:row] objectForKey:@"cnt"]];
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    NSInteger row=[indexPath row];
    
    SubViewController *subViewController=[[SubViewController alloc] initWithStyle:UITableViewStyleGrouped andDic:[arr objectAtIndex:row] andCellRow:row];
    [subViewController setTitle:[[arr objectAtIndex:row] objectForKey:@"name"]];
    [self.navigationController pushViewController:subViewController animated:YES];
    [subViewController release];
}

-(void)dealloc{
    [arr release];
    [super dealloc];
}

@end
