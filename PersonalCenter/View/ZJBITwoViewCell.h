//
//  ZJBITwoViewCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/5.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJBITwoViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *time;
- (void)setCellData:(NSDictionary *)dic;
@end
