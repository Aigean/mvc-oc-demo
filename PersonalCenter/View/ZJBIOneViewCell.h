//
//  ZJBIOneViewCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/25.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJBIOneViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (void)setCellData:(NSDictionary *)dic;

@end
