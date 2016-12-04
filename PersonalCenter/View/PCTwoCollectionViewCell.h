//
//  PCTwoCollectionViewCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/23.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCTwoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (void)setCellData:(NSDictionary *)dic;


@end
