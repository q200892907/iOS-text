//
//  Cell.m
//  Travel
//
//  Created by 陈磊 on 13-3-1.
//  Copyright (c) 2013年 T88. All rights reserved.
//

#import "SubCell.h"
#import "EGOImageView.h"
@implementation SubCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加图片
        self.contentView.backgroundColor = [UIColor clearColor];
        imageView=[[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"Default.png"]];
        imageView.frame=CGRectMake(5, 5, 40, 40);
        [self.contentView addSubview:imageView];
        
        //the title label
        name = [[UILabel alloc] initWithFrame:CGRectMake(50,5,265,40)];
        [self.contentView addSubview:name];
        name.backgroundColor= [UIColor clearColor];
        name.textColor = [UIColor blackColor];
        name.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
        
        brief = [[UILabel alloc] init];
        brief.numberOfLines=0;
        [self.contentView addSubview:brief];
        brief.backgroundColor= [UIColor clearColor];
        brief.textColor = [UIColor blackColor];
        brief.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    name.textColor = selected ? [UIColor orangeColor] : [UIColor blackColor];
    brief.textColor = selected ? [UIColor orangeColor] : [UIColor blackColor];
    // Configure the view for the selected state
}

-(void)setName:(NSString *)str
{
    name.text = str;
}

-(void)setImage:(NSString *)str{
    imageView.imageURL=[NSURL URLWithString:str];
}

-(void)setBrief:(NSString *)str{
    CGSize size=[str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(310, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    brief.frame=CGRectMake(5, 50, 310, size.height);
    brief.text=str;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
}

-(void)dealloc{
    [imageView release];
    [brief release];
    [name release];
    [super dealloc];
}
@end
