//
//  ZJUserInfoViewController.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/24.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnAvatarBlock)(UIImage *showAvatar);
typedef void (^ReturnFirstNameBlock)(NSString *showName);
@interface ZJUserInfoViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *avator;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *mailAddress;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (copy, nonatomic) ReturnAvatarBlock returnAvatarBlock;
@property (copy, nonatomic) ReturnFirstNameBlock returnFirstNameBlock;
@end
