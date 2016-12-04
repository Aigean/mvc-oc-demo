//
//  ZJEstimateTableViewCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/30.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "ZJEstimateTableViewCell.h"

@implementation ZJEstimateTableViewCell

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
    static NSString *ID = @"handle";
    ZJEstimateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZJEstimateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //         从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZJHandleTableViewCell" owner:nil options:nil] lastObject];
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
