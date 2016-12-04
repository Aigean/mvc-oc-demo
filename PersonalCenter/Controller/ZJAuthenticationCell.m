//
//  ZJAuthenticationCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/6.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJAuthenticationCell.h"

@implementation ZJAuthenticationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"auth";
    ZJAuthenticationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZJAuthenticationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //         从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZJAuthenticationCell" owner:nil options:nil] lastObject];
        //        [self initsubview];
    }
    
    
    
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


@end
