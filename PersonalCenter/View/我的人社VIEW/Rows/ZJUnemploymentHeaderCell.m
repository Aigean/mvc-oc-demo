//
//  ZJUnemploymentHeaderCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/3.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJUnemploymentHeaderCell.h"

@implementation ZJUnemploymentHeaderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ZJUnemploymentHeaderCell";
    ZJUnemploymentHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZJUnemploymentHeaderCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
    self.firstLabel.textColor = HEXRGBCOLOR(0x2877aa);
    self.secondLabel.textColor = HEXRGBCOLOR(0x2877aa);
    self.thirdLabel.textColor = HEXRGBCOLOR(0x2877aa);
    self.fourthLabel.textColor = HEXRGBCOLOR(0x2877aa);
    self.fifthLabel.textColor = HEXRGBCOLOR(0x2877aa);
    self.sixthLabel.textColor = HEXRGBCOLOR(0x2877aa);
    
    // 居中显示
    _firstLabel.textAlignment = NSTextAlignmentCenter;
    _secondLabel.textAlignment = NSTextAlignmentCenter;
    _thirdLabel.textAlignment = NSTextAlignmentCenter;
    _fourthLabel.textAlignment = NSTextAlignmentCenter;
    _fifthLabel.textAlignment = NSTextAlignmentCenter;
    _sixthLabel.textAlignment = NSTextAlignmentCenter;

    
    _firstLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
    _secondLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
    _thirdLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
    _fourthLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
    _fifthLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
    _sixthLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
    
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




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
