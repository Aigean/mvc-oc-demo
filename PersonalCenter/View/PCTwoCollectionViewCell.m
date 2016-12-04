//
//  PCTwoCollectionViewCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/23.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "PCTwoCollectionViewCell.h"

@implementation PCTwoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



- (void)setCellData:(NSDictionary *)dic{
    self.titleLabel.text = [dic objectForKey:@"name"];
    self.image.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
}

@end
