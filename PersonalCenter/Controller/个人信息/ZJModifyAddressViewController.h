//
//  ZJModifyAddressViewController.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/8.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef void (^ReturnNameBlock)(NSString *showName);
typedef void (^ReturnAddressBlock)(NSString *showAddress);
@interface ZJModifyAddressViewController : UIViewController
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) ReturnAddressBlock returnAddressBlock;

@end
