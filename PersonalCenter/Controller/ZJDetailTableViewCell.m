//
//  ZJDetailTableViewCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/12.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJDetailTableViewCell.h"

@implementation ZJDetailTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DetailCell";
    ZJDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZJDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    _firstLabel  = [[UILabel alloc]initWithFrame:CGRectMake(8*RATIO, 4, 100*RATIO, 36)];
    _secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(115*RATIO, 4, 62*RATIO, 36)];
    _thirdLabel  = [[UILabel alloc]initWithFrame:CGRectMake(185*RATIO, 4, 86*RATIO, 36)];
    _fourthLabel = [[UILabel alloc]initWithFrame:CGRectMake(278*RATIO, 4, 87*RATIO, 36)];
    
//    _firstLabel.backgroundColor = RandomColor;
//    _secondLabel.backgroundColor = RandomColor;
//    _thirdLabel.backgroundColor = RandomColor;
//    _fourthLabel.backgroundColor = RandomColor;
    
    _firstLabel.textAlignment = NSTextAlignmentCenter;
    _secondLabel.textAlignment = NSTextAlignmentCenter;
    _thirdLabel.textAlignment = NSTextAlignmentCenter;
    _fourthLabel.textAlignment = NSTextAlignmentCenter;
    
    _firstLabel.font = [UIFont systemFontOfSize:14*RATIO];
    _secondLabel.font = [UIFont systemFontOfSize:14*RATIO];
    _thirdLabel.font = [UIFont systemFontOfSize:14*RATIO];
    _fourthLabel.font = [UIFont systemFontOfSize:14*RATIO];
    
    _firstLabel.text = @"机关事业单位养老保险";
    _secondLabel.text = @"缴费状态";
    _thirdLabel.text = @"单位缴费比例或定额标准";
    _fourthLabel.text = @"个人缴费比例或定额标准";
    
    _firstLabel.numberOfLines = 0;
    _secondLabel.numberOfLines = 0;
    _thirdLabel.numberOfLines = 0;
    _fourthLabel.numberOfLines = 0;
    
    [self addSubview:_firstLabel];
    [self addSubview:_secondLabel];
    [self addSubview:_thirdLabel];
    [self addSubview:_fourthLabel];

    
}

- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color{
    
}


// 模型赋值
//-(void)setModel:(ActivityModel *)model
//{
//    
//    _model = model;
//    [self.leftbutton sd_setBackgroundImageWithURL:[NSURL URLWithString: IMG(model.ImageActivityLeft)] forState:UIControlStateNormal];
//    [self.topbutton sd_setBackgroundImageWithURL:[NSURL URLWithString: IMG(model.ImageActivityLeft)] forState:UIControlStateNormal];
//    [self.bottombutton sd_setBackgroundImageWithURL:[NSURL URLWithString:IMG(model.ImageActivityBottom)] forState:UIControlStateNormal];
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
