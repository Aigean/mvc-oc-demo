//
//  ZJStarViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/30.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "ZJStarViewController.h"
#import "HYBStarEvaluationView.h"
#import "PlaceholderTextView.h"

@interface ZJStarViewController ()<DidChangedStarDelegate>

//@property (weak, nonatomic)HYBStarEvaluationView *starView;
@property (strong, nonatomic)HYBStarEvaluationView *star1;
@property (strong, nonatomic)HYBStarEvaluationView *star2;
@property (strong, nonatomic)HYBStarEvaluationView *star3;
@property (strong, nonatomic)HYBStarEvaluationView *star4;
//@property (weak, nonatomic)PlaceholderTextView *textView;


@end

@implementation ZJStarViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_evaluateFlag == 1) {
        self.view.userInteractionEnabled = false;
        [self requstEstimate];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户评价";
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"办理速度",@"系统易用性",@"服务态度",@"结果满意度"];
    for (int i = 0; i < 4; i++) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + i * (6.0/25 * SCREEN_WIDTH), SCREEN_WIDTH, 6.0/25 * SCREEN_WIDTH)];

        UIView * lineOne = [[UIView alloc]initWithFrame:CGRectMake(20, 15, SCREEN_WIDTH/2 - 95, 1)];
        
        lineOne.backgroundColor = HEXRGBCOLOR(0xcfcfcf);
        UIView * lineTwo = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 + 75, 15, SCREEN_WIDTH/2 - 95, 1)];
        lineTwo.backgroundColor = HEXRGBCOLOR(0xcfcfcf);
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 75, 8, 150, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        label.textColor = HEXRGBCOLOR(0x2877AA);
        label.font = [UIFont systemFontOfSize:12];
        
        
         HYBStarEvaluationView *starView = [[HYBStarEvaluationView alloc]initWithFrame:CGRectMake(35, 35, SCREEN_WIDTH - 70, 30) numberOfStars:5 isVariable:YES];
        starView.tag = i * 100 + 100;
        self.starView = starView;
        starView.actualScore = 0;
        starView.fullScore = 5;
        starView.delegate = self;
        
        if (starView.tag == 100) {
            _star1 = [self.starView viewWithTag:100];
        }
        if (starView.tag == 200) {
            _star2 = [self.starView viewWithTag:200];
        }
        if (starView.tag == 300) {
            _star3 = [self.starView viewWithTag:300];
        }
        if (starView.tag == 400) {
            _star4 = [self.starView viewWithTag:400];
        }
        
        [self.view addSubview:view];
        [view addSubview:lineOne];
        [view addSubview:lineTwo];
        [view addSubview:label];
        [view addSubview:starView];
    }
    
    PlaceholderTextView * textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(20, 4 * (6.0/25 * SCREEN_WIDTH)+70 , SCREEN_WIDTH - 40, 100)];
    textView.layer.borderWidth = 1;
    textView.layer.borderColor =HEXRGBCOLOR(0xcfcfcf).CGColor;
    textView.placeholder = @"输入您的建议，建议在200字以内。";
    textView.placeholderColor = HEXRGBCOLOR(0x999999);
    self.textView = textView;
    [self.view addSubview:textView];
//    if (self.evaluateFlag == 1) {
//        self.textView.userInteractionEnabled = false;
//    }
    
    if (self.evaluateFlag == 0){
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 68, SCREEN_WIDTH - 40, 48)];
        [btn setTitle:@"评价" forState:UIControlStateNormal];
        btn.backgroundColor = RGBColor(63, 200, 247);
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    
  
    // Do any additional setup after loading the view.
}
- (void)btnClick{
    [self requst];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 代理方法
- (void)didChangeStar {
    NSLog(@"1这次星级为 %f",_star1.actualScore);
    NSLog(@"2这次星级为 %f",_star2.actualScore);
    NSLog(@"3这次星级为 %f",_star3.actualScore);
    NSLog(@"4这次星级为 %f",_star4.actualScore);
    
}

// 未评价的数据
- (void)requst{
    

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;
    params[@"businessId"] = self.businessId;
    params[@"progress"] = [NSString stringWithFormat:@"%d", (int)self.star1.actualScore];
    params[@"systemCommon"] = [NSString stringWithFormat:@"%d",(int)self.star2.actualScore];
    params[@"attitude"] = [NSString stringWithFormat:@"%d",(int)self.star3.actualScore];
    params[@"satisfaction"] = [NSString stringWithFormat:@"%d",(int)self.star4.actualScore];
    params[@"description"] = self.textView.text;
    NSLog(@"text%@",_textView.text);
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(SATISFACTION) params:params controller:self success:^(id responseObject) {
        NSLog(@"评价：%@",responseObject);
        
        if ([responseObject[@"code"] isEqualToString:@"0000"]) {
            [ZJHudExtension showText:@"评价成功" view:self.view];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [ZJHudExtension showText:@"服务错误" view:self.view];
            
        }

    } failure:^(id error) {
        
    }];
   
}
// 已评价的数据
- (void)requstEstimate{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"userId"] = USERID;
    params[@"businessId"] = self.businessId;
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(BUSINESSDETAIL) params:params controller:self success:^(id responseObject) {
        if (responseObject[@"code"] != nil) {
            NSLog(@"已评价：%@",responseObject);
            [ZJHudExtension showText:@"服务错误" view:self.view];

        }else{

            NSLog(@"已评价：%@",responseObject);
            self.star1.actualScore = [[NSString isBlankString:responseObject[@"progress"]] ? @"0.0" : responseObject[@"progress"] floatValue];
            self.star2.actualScore = [[NSString isBlankString:responseObject[@"systemCommon"]] ? @"0.0" : responseObject[@"progress"] floatValue];
            self.star3.actualScore = [[NSString isBlankString:responseObject[@"attitude"]] ? @"0.0" : responseObject[@"progress"] floatValue];
            self.star4.actualScore = [[NSString isBlankString:responseObject[@"satisfaction"]] ? @"0.0" : responseObject[@"progress"] floatValue];
            self.textView.text = [NSString isBlankString:responseObject[@"description"]] ? @"" : responseObject[@"description"];
            self.textView.placeholder = @"您未填写文字描述";
            
        }

    } failure:^(id error) {
        
    }];
 
    
    
   
    
}

@end
