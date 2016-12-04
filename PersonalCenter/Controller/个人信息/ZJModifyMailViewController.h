//
//  ZJModifyMailViewController.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/8.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReturnMailBlock) (NSString *showMail);
@interface ZJModifyMailViewController : UIViewController
@property (copy, nonatomic) NSString *mail;
@property (copy, nonatomic) ReturnMailBlock returnMailBlock;

@end
