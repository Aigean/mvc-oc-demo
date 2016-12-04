//
//  PCOneCollectionViewCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/22.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCOneCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;


- (void)setCellData:(NSDictionary *)dic;

@end
