//
//  ZJMessageDetailViewController.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/4.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJMessageDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *headLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (copy, nonatomic) NSString *menuId;

@end
