//
//  ZJHandleTableViewCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/24.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "ZJHandleTableViewCell.h"
#import "NSDate+Common.h"

@implementation ZJHandleTableViewCell

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
    ZJHandleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZJHandleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

- (void)setModel:(ZJBussinessModel *)model{
    _model = model;
    
//    self.status.text = model.statusName;
    self.serviceNumber.text = [NSString stringWithFormat:@"%@", model.businessId];
    self.menuName.text = model.menuName;
    NSLog(@"%@",self.navTitle);
    if ([self.navTitle isEqualToString:@"已办理"]) {
        self.status.text = @"已办理";
    }
    else if ([self.navTitle isEqualToString:@"用户评价"]) {
        if ([model.evaluateFlag integerValue] == 0) {
            self.status.text = @"待评价";
        }
        if ([model.evaluateFlag integerValue] == 1) {
            self.status.textColor = HEXRGBCOLOR(0x74B749);
            self.status.text = @"已评价";
        }
    }else{
        self.status.text = model.statusName;
    }
    
    NSString *time = model.handleTime;
    time = [time substringWithRange:NSMakeRange(0, 8)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date=[formatter dateFromString:time];
    NSDateFormatter *output = [[NSDateFormatter alloc]init];
    output = formatter;
    [output setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [output stringFromDate:date];
    self.lastTime.text = str;
}


@end
