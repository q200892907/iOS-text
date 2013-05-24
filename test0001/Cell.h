//
//  Cell.h
//  test0001
//
//  Created by Chenlei on 13-5-22.
//  Copyright (c) 2013年 Chenlei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class EGOImageView;
@interface Cell : UITableViewCell{
    UILabel *mCellTtleLabel;
    UILabel *mCellDetailTextLabel;
    EGOImageView *imageView;
}
-(void)setCellTitle:(NSString*)title;
-(void)setImage:(NSString*)str;
-(void)setCellDetailTextLabel:(NSString*)detail;
@end
