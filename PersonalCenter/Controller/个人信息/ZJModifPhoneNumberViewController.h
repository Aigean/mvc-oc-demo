//
//  ZJModifPhoneNumberViewController.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/8.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReturnPhoneNumberBlock)(NSString *showPhoneNumber);
@interface ZJModifPhoneNumberViewController : UIViewController
@property (copy, nonatomic) NSString *phoneNumber;
@property (copy, nonatomic) ReturnPhoneNumberBlock returnPhoneNumberBlock;
@end
