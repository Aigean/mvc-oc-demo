//
//  PCOneCollectionViewCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/22.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "PCOneCollectionViewCell.h"

@implementation PCOneCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



- (void)setCellData:(NSDictionary *)dic{
    self.titleLabel.text = [dic objectForKey:@"title"];
    self.subTitleLabel.text = [dic objectForKey:@"subTitle"];
    self.imageView.image = [UIImage imageNamed:[dic objectForKey:@"icon"]];
  
}
@end
