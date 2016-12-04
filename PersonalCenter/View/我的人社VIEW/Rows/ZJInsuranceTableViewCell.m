//
//  ZJInsuranceTableViewCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/1.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJInsuranceTableViewCell.h"

@implementation ZJInsuranceTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DetailCell";
    ZJInsuranceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZJInsuranceTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor clearColor];
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    _firstLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10*RATIO, 4, 155*RATIO, 36)];
    _secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(165*RATIO, 4, 105*RATIO, 36)];
    _thirdLabel  = [[UILabel alloc]initWithFrame:CGRectMake(270*RATIO, 4, 105*RATIO, 36)];
//    _fourthLabel = [[UILabel alloc]initWithFrame:CGRectMake(278*RATIO, 4, 87*RATIO, 36)];
    
//        _firstLabel.backgroundColor = RandomColor;
//        _secondLabel.backgroundColor = RandomColor;
//        _thirdLabel.backgroundColor = RandomColor;
    //    _fourthLabel.backgroundColor = RandomColor;
    // 字体颜色
    _firstLabel.textColor = HEXRGBCOLOR(0x333333);
    _secondLabel.textColor = HEXRGBCOLOR(0x333333);
    _thirdLabel.textColor = HEXRGBCOLOR(0x333333);
    
   
    // 居中显示
//    _firstLabel.textAlignment = NSTextAlignmentCenter;
    _secondLabel.textAlignment = NSTextAlignmentCenter;
    _thirdLabel.textAlignment = NSTextAlignmentCenter;
//    _fourthLabel.textAlignment = NSTextAlignmentCenter;
    
    _firstLabel.font = [UIFont systemFontOfSize:14*RATIO];
    _secondLabel.font = [UIFont systemFontOfSize:14*RATIO];
    _thirdLabel.font = [UIFont systemFontOfSize:14*RATIO];
//    _fourthLabel.font = [UIFont systemFontOfSize:14*RATIO];
    
    _firstLabel.text = @"险种名称";
    _secondLabel.text = @"单位缴费比例";
    _thirdLabel.text = @"个人缴费比例";
//    _fourthLabel.text = @"个人缴费比例或定额标准";
    
    _firstLabel.numberOfLines = 0;
    _secondLabel.numberOfLines = 0;
    _thirdLabel.numberOfLines = 0;
//    _fourthLabel.numberOfLines = 0;
    
    [self addSubview:_firstLabel];
    [self addSubview:_secondLabel];
    [self addSubview:_thirdLabel];
//    [self addSubview:_fourthLabel];
    
    
}

- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color{
    
}


// 模型赋值

- (void)setModel:(ZJInsurance *)model{
    _model = model;
    self.firstLabel.text = model.aae140;
    self.secondLabel.text = model.aaa042;
    self.thirdLabel.text = model.aaa041;
}

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
