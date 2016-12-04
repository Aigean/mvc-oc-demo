//
//  ZJStarViewController.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/30.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlaceholderTextView;
@class HYBStarEvaluationView;

@interface ZJStarViewController : UIViewController
@property (copy, nonatomic) NSString *businessId;

@property (weak, nonatomic)UIButton *button;
@property (weak, nonatomic)PlaceholderTextView *textView;
@property (weak, nonatomic)HYBStarEvaluationView *starView;
// 是否评价Flag
@property (assign, nonatomic)int evaluateFlag;

@end

