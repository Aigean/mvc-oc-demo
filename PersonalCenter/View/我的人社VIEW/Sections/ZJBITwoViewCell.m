//
//  ZJBITwoViewCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/5.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "ZJBITwoViewCell.h"

@implementation ZJBITwoViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(NSDictionary *)dic{
    self.iconImage.image = [UIImage imageNamed:[dic objectForKey:@"icon"]];
    self.titleLabel.text = [dic objectForKey:@"title"];
//    self.account.text = [dic objectForKey:@"account"];
//    self.time.text = [dic objectForKey:@"time"];
}



@end
