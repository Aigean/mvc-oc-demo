//
//  ZJInsuranceHeaderTableViewCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/2.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJInsuranceHeaderTableViewCell.h"

@implementation ZJInsuranceHeaderTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ZJInsuranceHeaderTableViewCell";
    ZJInsuranceHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZJInsuranceHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
    self.firstLabel.textColor = HEXRGBCOLOR(0x2877aa);
    self.secondLabel.textColor = HEXRGBCOLOR(0x2877aa);
    self.thirdLabel.textColor = HEXRGBCOLOR(0x2877aa);
    // 居中显示
//    _firstLabel.textAlignment = NSTextAlignmentCenter;
    _secondLabel.textAlignment = NSTextAlignmentCenter;
    _thirdLabel.textAlignment = NSTextAlignmentCenter;
    //    _fourthLabel.textAlignment = NSTextAlignmentCenter;
    
    _firstLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
    _secondLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
    _thirdLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
