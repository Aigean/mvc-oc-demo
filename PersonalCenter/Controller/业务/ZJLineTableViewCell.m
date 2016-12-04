//
//  ZJLineTableViewCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/9.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJLineTableViewCell.h"


@implementation ZJLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initCell];
    // Initialization code
}

- (void)initCell{
    self.circleView.clipsToBounds = YES;
    self.circleView.layer.cornerRadius = 15;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ZJLineTableViewCell";
    ZJLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZJLineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //         从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZJLineTableViewCell" owner:nil options:nil] lastObject];
        //        [self initsubview];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setModel:(ZJHistoryModel *)model{
    _model = model;
    self.headlineLabel.text = model.statusName;
    self.dateLabel.text = model.optTime;
    if ([model.flag isEqualToString:@"0"]) {
        self.lineView.backgroundColor = HEXRGBCOLOR(0xc7c7c7);
        self.circleView.backgroundColor = HEXRGBCOLOR(0xc7c7c7);
        self.headlineLabel.textColor = HEXRGBCOLOR(0xc7c7c7);
    }
}



@end
