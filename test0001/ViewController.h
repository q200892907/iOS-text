//
//  ViewController.h
//  test0001
//
//  Created by Chenlei on 13-5-22.
//  Copyright (c) 2013年 Chenlei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface ViewController : UITableViewController<ASIHTTPRequestDelegate>

@property (nonatomic,retain) NSMutableArray *arr;
@property (nonatomic,retain) NSMutableString *str;
@property (nonatomic,retain) NSMutableDictionary *dic;
-(void)JSON;

@end
