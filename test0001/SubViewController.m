//
//  SubViewController.m
//  test0001
//
//  Created by Chenlei on 13-5-22.
//  Copyright (c) 2013年 Chenlei. All rights reserved.
//

#import "SubViewController.h"
#import "SubCell.h"

@interface SubViewController ()

@end

@implementation SubViewController
@synthesize dictionary,cellrow,arr1,refreshHeaderAndFooterView,reloading,isFooter,isHeader,isFinal,max_id;

- (id)initWithStyle:(UITableViewStyle)style andDic:(NSDictionary*)dic andCellRow:(NSInteger)row{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        dictionary=dic;
        cellrow=[[dictionary objectForKey:@"id"] intValue];
        max_id=[[dictionary objectForKey:@"cnt"] intValue];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (refreshHeaderAndFooterView==nil) {
        RefreshHeaderAndFooterView *view=[[RefreshHeaderAndFooterView alloc] initWithFrame:CGRectZero];
        view.delegate=self;
        [self.tableView addSubview:view];
        refreshHeaderAndFooterView=view;
        [view release];
    }
    isFooter=NO;
    isHeader=NO;
    isFinal=NO;
    [self JSON];
}

-(void)updateRefreshView{
    int height = MAX(self.tableView.bounds.size.height, self.tableView.contentSize.height);
    CGRect rect=CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, height);
    refreshHeaderAndFooterView.frame =rect;
}

-(void)doneLoadingViewData{
    if (!isFinal) {
        [NSThread detachNewThreadSelector:@selector(JSON)
                                 toTarget:self
                               withObject:nil];
    }else{
        [self performSelector:@selector(updateUI) withObject:nil];
    }
    [refreshHeaderAndFooterView RefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [refreshHeaderAndFooterView RefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [refreshHeaderAndFooterView RefreshScrollViewDidEndDragging:scrollView];
}


- (void)RefreshHeaderAndFooterDidTriggerRefresh:(RefreshHeaderAndFooterView*)view{
	self.reloading = YES;
    if (view.refreshHeaderView.state == PullRefreshLoading) {//下拉刷新动作的内容
        isHeader=YES;
        [self performSelector:@selector(doneLoadingViewData) withObject:nil afterDelay:3.0];
    }else if(view.refreshFooterView.state == PullRefreshLoading){//上拉加载更多动作的内容
        isFooter=YES;
        [self performSelector:@selector(doneLoadingViewData) withObject:nil afterDelay:3.0];
    }
}

- (BOOL)RefreshHeaderAndFooterDataSourceIsLoading:(RefreshHeaderAndFooterView*)view{
	return reloading; // should return if data source model is reloading
}

- (NSDate*)RefreshHeaderAndFooterDataSourceLastUpdated:(RefreshHeaderAndFooterView*)view{
    return [NSDate date];
}


-(void)JSON{
    NSLog(@"尝试修改");
    NSMutableString * url;
    if (isHeader==YES) {
        url =[NSMutableString stringWithFormat:@"http://www.zhongchou.cn/mobile/index.php?ctl=index&act=deals&id=%d&limit=%d",cellrow,arr1.count];
    }else if(isFooter==YES){
        url =[NSMutableString stringWithFormat:@"http://www.zhongchou.cn/mobile/index.php?ctl=index&act=deals&id=%d&start=%d",cellrow,arr1.count];
    }else{
        url =[NSMutableString stringWithFormat:@"http://www.zhongchou.cn/mobile/index.php?ctl=index&act=deals&id=%d",cellrow];
    }
    NSURL * queryUrl = [[NSURL alloc]initWithString:url];
    ASIHTTPRequest *req=[[ASIHTTPRequest alloc] initWithURL:queryUrl];
    [queryUrl release];
    req.delegate = self;
    [req startAsynchronous];
    [req release];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSData *data =[request responseData];
    NSError *error;
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *array=[dic objectForKey:@"data"];
    
    NSMutableArray *arr_old=[NSMutableArray arrayWithArray:arr1];
    if (arr1!=nil) {
        [arr1 release];
        arr1=nil;
    }
    if (isFooter==YES) {
        for (id obj in array) {
            [arr_old addObject:obj];
        }
        arr1=arr_old;
    }else{
        arr1 = (NSMutableArray*)array;
    }
    if (arr1.count>=max_id) {
        isFinal=YES;
    }
    [arr1 retain];
    
    [self.tableView reloadData];
    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
}

-(void)updateUI{
    isHeader=NO;
    isFooter=NO;
    reloading=NO;
    [self updateRefreshView];
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
    return [arr1 count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size=[[[arr1 objectAtIndex:indexPath.row] objectForKey:@"brief"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(310, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    return 50+size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SubCell*cell = (SubCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[SubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSInteger row=[indexPath row];
    [cell setName:[[arr1 objectAtIndex:row] objectForKey:@"name"]];
    NSString *string=[NSString stringWithString:[[arr1 objectAtIndex:row] objectForKey:@"image"]];
    string=[string substringFromIndex:1];
    NSString *str=[NSString stringWithFormat:@"http://www.zhongchou.cn%@",string];
    [cell setImage:str];
    [cell setBrief:[[arr1 objectAtIndex:row] objectForKey:@"brief"]];

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
    
}


-(void)viewDidUnload{
    refreshHeaderAndFooterView=nil;
}

-(void)dealloc{
    [arr1 release];
    [dictionary release];
    [refreshHeaderAndFooterView release];
    [super dealloc];
}

@end
