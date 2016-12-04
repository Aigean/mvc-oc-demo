//
//  ZJUnemploymentCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/3.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJUnemploymentCell.h"

@implementation ZJUnemploymentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ZJUnemploymentCell";
    ZJUnemploymentCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZJUnemploymentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
    _firstLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0*RATIO, 4, 50*RATIO, 44)];
    _secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(50*RATIO, 4, 50*RATIO, 44)];
    _thirdLabel  = [[UILabel alloc]initWithFrame:CGRectMake(100*RATIO, 4, 68*RATIO, 44)];
    _fourthLabel = [[UILabel alloc]initWithFrame:CGRectMake(168*RATIO, 4, 80*RATIO, 44)];
    _fifthLabel  = [[UILabel alloc]initWithFrame:CGRectMake(248*RATIO, 4, 80*RATIO, 44)];
    _sixthLabel =  [[UILabel alloc]initWithFrame:CGRectMake(328*RATIO, 4, 47*RATIO, 44)];
    
    
    //        _firstLabel.backgroundColor = RandomColor;
    //        _secondLabel.backgroundColor = RandomColor;
    //        _thirdLabel.backgroundColor = RandomColor;
    //    _fourthLabel.backgroundColor = RandomColor;
    
    // 字体颜色
    self.firstLabel.textColor = HEXRGBCOLOR(0x333333);
    self.secondLabel.textColor = HEXRGBCOLOR(0x333333);
    self.thirdLabel.textColor = HEXRGBCOLOR(0x333333);
    self.fourthLabel.textColor = HEXRGBCOLOR(0x333333);
    self.fifthLabel.textColor = HEXRGBCOLOR(0x333333);
    self.sixthLabel.textColor = HEXRGBCOLOR(0x333333);
    
    // 居中显示
    _firstLabel.textAlignment = NSTextAlignmentCenter;
    _secondLabel.textAlignment = NSTextAlignmentCenter;
    _thirdLabel.textAlignment = NSTextAlignmentCenter;
    _fourthLabel.textAlignment = NSTextAlignmentCenter;
    _fifthLabel.textAlignment = NSTextAlignmentCenter;
    _sixthLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    _firstLabel.font = [UIFont systemFontOfSize:14*RATIO];
    _secondLabel.font = [UIFont systemFontOfSize:14*RATIO];
    _thirdLabel.font = [UIFont systemFontOfSize:14*RATIO];
    _fourthLabel.font = [UIFont systemFontOfSize:14*RATIO];
    _fifthLabel.font = [UIFont systemFontOfSize:14*RATIO];
    _sixthLabel.font = [UIFont systemFontOfSize:14*RATIO];
    
    _firstLabel.text = @"应享受月份";
    _secondLabel.text = @"失业保险金";
    _thirdLabel.text = @"医疗保险";
    _fourthLabel.text = @"开始时间";
    _fifthLabel.text = @"截止时间";
    _sixthLabel.text = @"已享受月份";
    
    _firstLabel.numberOfLines = 0;
    _secondLabel.numberOfLines = 0;
    _thirdLabel.numberOfLines = 0;
    _fourthLabel.numberOfLines = 0;
    _fifthLabel.numberOfLines = 0;
    _sixthLabel.numberOfLines = 0;
    
    [self addSubview:_firstLabel];
    [self addSubview:_secondLabel];
    [self addSubview:_thirdLabel];
    [self addSubview:_fourthLabel];
    [self addSubview:_fifthLabel];
    [self addSubview:_sixthLabel];
    
}

- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color{
    
}


- (void)setModel:(ZJRedundancyModel *)model{
    _model = model;
    //ajc097	应享受月份
    //aae129	失业保险金
    //bdc205	医疗保险
    //aae210	开始时间
    //aic301	截止时间
    //ajc098	已享受月份
    self.firstLabel.text = model.ajc097;
    self.secondLabel.text = model.aae129;
    self.thirdLabel.text = model.bdc205;
    self.fourthLabel.text = model.aae210;
    self.fifthLabel.text = model.aic301;
    self.sixthLabel.text = model.ajc098;
    
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
