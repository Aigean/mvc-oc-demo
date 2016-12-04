//
//  ZJMessageNotiTableViewCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/10/12.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJMessageNotiTableViewCell.h"
#import "UILabel+LeftTop.h"

@implementation ZJMessageNotiTableViewCell

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
    static NSString *ID = @"msgmodel";
    ZJMessageNotiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZJMessageNotiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //         从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZJMessageNotiTableViewCell" owner:nil options:nil] lastObject];
        
        //        [self initsubview];
    }
    [cell.nameLabel textLeftTopAlign];
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setMessageModel:(ZJMessageModel *)messageModel{
    _messageModel = messageModel;
    if ([messageModel.statusId isEqualToString:@"0"]) {
        self.nameLabel.textColor = [UIColor redColor];
        self.lineView.backgroundColor = [UIColor redColor];
        
        self.nameLabel.text = [NSString stringWithFormat:@"●  %@",messageModel.title];
        
    }else{
        self.nameLabel.text = messageModel.title;
        
    }
    
    
    NSString *time = messageModel.lastTime;
    time = [time substringWithRange:NSMakeRange(0, 8)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date=[formatter dateFromString:time];
    NSDateFormatter *output = [[NSDateFormatter alloc]init];
    output = formatter;
    [output setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [output stringFromDate:date];
    self.dateLabel.text = str;
    
    
}

@end
