//
//  ZJHealthRegisterHeaderCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/2.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJHealthRegisterHeaderCell.h"

@implementation ZJHealthRegisterHeaderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ZJHealthRegisterHeaderCell";
    ZJHealthRegisterHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZJHealthRegisterHeaderCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
    _firstLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10*RATIO, 4, 70*RATIO, 44)];
    _secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(80*RATIO, 4, 90*RATIO, 44)];
    _thirdLabel  = [[UILabel alloc]initWithFrame:CGRectMake(170*RATIO, 4, 70*RATIO, 44)];
    _fourthLabel = [[UILabel alloc]initWithFrame:CGRectMake(240*RATIO, 4, 70*RATIO, 44)];
    _fifthLabel  = [[UILabel alloc]initWithFrame:CGRectMake(310*RATIO, 4, 60*RATIO, 44)];
    
    
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
    
    // 居中显示
    //    _firstLabel.textAlignment = NSTextAlignmentCenter;
    _secondLabel.textAlignment = NSTextAlignmentCenter;
    _thirdLabel.textAlignment = NSTextAlignmentCenter;
    _fourthLabel.textAlignment = NSTextAlignmentCenter;
    _fifthLabel.textAlignment = NSTextAlignmentCenter;
    
    
    _firstLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
    _secondLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
    _thirdLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
    _fourthLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
    _fifthLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
    
    _firstLabel.text = @"登记类型";
    _secondLabel.text = @"登记医院";
    _thirdLabel.text = @"起始日期";
    _fourthLabel.text = @"结束日期";
    _fifthLabel.text = @"有效标志";
    
    _firstLabel.numberOfLines = 0;
    _secondLabel.numberOfLines = 0;
    _thirdLabel.numberOfLines = 0;
    _fourthLabel.numberOfLines = 0;
    _fifthLabel.numberOfLines = 0;
    
    [self addSubview:_firstLabel];
    [self addSubview:_secondLabel];
    [self addSubview:_thirdLabel];
    [self addSubview:_fourthLabel];
    [self addSubview:_fifthLabel];
    
    
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
