//
//  Cell.m
//  Travel
//
//  Created by 陈磊 on 13-3-1.
//  Copyright (c) 2013年 T88. All rights reserved.
//

#import "Cell.h"
#import "EGOImageView.h"
@implementation Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加图片
        self.contentView.backgroundColor = [UIColor clearColor];
        imageView=[[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"Default.png"]];
        [self.contentView addSubview:imageView];
        //the title label
        mCellTtleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44.0, 20.0, self.contentView.bounds.size.width - 44.0, 21.0)];
        [self.contentView addSubview:mCellTtleLabel];
        mCellTtleLabel.backgroundColor= [UIColor clearColor];
        mCellTtleLabel.textColor = [UIColor blackColor];
        mCellTtleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:21.0];
        mCellDetailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(44.0, 20.0, self.contentView.bounds.size.width - 44.0, 21.0)];
        [self.contentView addSubview:mCellDetailTextLabel];
        mCellDetailTextLabel.backgroundColor= [UIColor clearColor];
        mCellDetailTextLabel.textColor = [UIColor blackColor];
        mCellDetailTextLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:21.0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    mCellTtleLabel.textColor = selected ? [UIColor orangeColor] : [UIColor blackColor];
    mCellDetailTextLabel.textColor = selected ? [UIColor orangeColor] : [UIColor blackColor];
    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    float imageY = 4.0;
    float heightOfImageLayer  = self.bounds.size.height - imageY*2.0;
    heightOfImageLayer = floorf(heightOfImageLayer);
    imageView.frame = CGRectMake(4.0, imageY, heightOfImageLayer, heightOfImageLayer);
    mCellTtleLabel.frame = CGRectMake(heightOfImageLayer+10.0, (floorf(heightOfImageLayer/2.0 - (21/2.0f))+4.0), self.contentView.bounds.size.width-heightOfImageLayer+10.0, 21.0);
    mCellDetailTextLabel.frame=CGRectMake(heightOfImageLayer+200.0, (floorf(heightOfImageLayer/2.0 - (21/2.0f))+4.0), self.contentView.bounds.size.width-heightOfImageLayer+10.0, 21.0);
}

-(void)setCellTitle:(NSString*)title
{
    mCellTtleLabel.text = title;
}

-(void)setImage:(NSString *)str{
    imageView.imageURL=[NSURL URLWithString:str];
}

-(void)setCellDetailTextLabel:(NSString*)detail{
    mCellDetailTextLabel.text=detail;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
}

-(void)dealloc{
    [imageView release];
    [mCellDetailTextLabel release];
    [mCellTtleLabel release];
    [super dealloc];
}

@end
