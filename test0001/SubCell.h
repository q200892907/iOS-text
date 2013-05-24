//
//  SubCell.h
//  test0001
//
//  Created by Chenlei on 13-5-22.
//  Copyright (c) 2013年 Chenlei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class EGOImageView;
@interface SubCell : UITableViewCell{
    EGOImageView *imageView;
    UILabel *name;
    UILabel *brief;
}

-(void)setImage:(NSString*)str;
-(void)setName:(NSString*)str;
-(void)setBrief:(NSString*)str;

@end
