//
//  ZJModifyNameViewController.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/8.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnNameBlock)(NSString *showName);
@interface ZJModifyNameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (copy, nonatomic) NSString *labname;
@property (copy, nonatomic) ReturnNameBlock returnNameBlock;
@end
