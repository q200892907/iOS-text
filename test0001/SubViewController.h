//
//  SubViewController.h
//  test0001
//
//  Created by Chenlei on 13-5-22.
//  Copyright (c) 2013年 Chenlei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "RefreshHeaderAndFooterView.h"
@interface SubViewController : UITableViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,RefreshHeaderAndFooterViewDelegate>

@property (nonatomic,assign) NSInteger cell_num;

- (id)initWithStyle:(UITableViewStyle)style andDic:(NSDictionary*)dic andCellRow:(NSInteger)row;
-(void)JSON;
@property (nonatomic,retain) NSMutableArray *arr1;
@property (nonatomic,retain) NSDictionary *dictionary;
@property NSInteger cellrow;
@property NSInteger max_id;
@property(nonatomic,assign)BOOL isFinal;

@property(nonatomic,strong)RefreshHeaderAndFooterView * refreshHeaderAndFooterView;
@property(nonatomic,assign)BOOL reloading;
@property(nonatomic,assign)BOOL isHeader;
@property(nonatomic,assign)BOOL isFooter;
- (void)doneLoadingViewData;
@end
