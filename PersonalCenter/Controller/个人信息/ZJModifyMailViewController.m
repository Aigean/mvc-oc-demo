//
//  ZJModifyMailViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/8.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJModifyMailViewController.h"
#import "ZJSecurityCodeTime.h"
#import "ZJRegularExpression.h"

@interface ZJModifyMailViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *securityCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextFiled;
@end

@implementation ZJModifyMailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    return [[UIStoryboard storyboardWithName:@"ZJModifyMail" bundle:nil] instantiateInitialViewController];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /// 获取验证码边框
    self.securityCodeButton.layer.borderWidth = .5;
    self.securityCodeButton.layer.borderColor = HEXRGBCOLOR(0x35c7fa).CGColor;
    /// 邮箱
    self.emailTextFiled.text = self.mail;
   
    
}
- (IBAction)modifyButtonClick:(id)sender {
    [self requestMail];
}
- (IBAction)securityButtonClick:(id)sender {
    if ([ZJRegularExpression validateEmail:self.emailTextFiled.text]) {
        // 存在性检验
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"mail"] = self.emailTextFiled.text;
        NSLog(@"%@",self.emailTextFiled.text);
        [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(EXISTS) params:params controller:self success:^(id responseObject) {
            NSLog(@"邮箱存在性检验:%@",responseObject);
            if ([responseObject[@"exists"] isEqualToString:@"0"]) {
                
                [self requsetCode];
             
                
                
            }
            if ([responseObject[@"exists"] isEqualToString:@"1"]) {
                SHOW_ALERT(@"该邮箱已被注册");
            }
            
        } failure:^(id error) {
            
        }];

    }else{
        SHOW_ALERT(@"邮箱格式不正确");
    }
    
    
}

#pragma mark - 获取验证码
- (void)requsetCode{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"method"] = @"2";
    if ([self.title isEqualToString:@"修改邮箱"]) {
        params[@"event"] = @"5";
    }
    if ([self.title isEqualToString:@"邮箱认证"]) {
        params[@"event"] = @"7";
    }
    params[@"address"] = self.emailTextFiled.text;
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(CODE) params:params controller:self success:^(id responseObject) {
        
        NSLog(@"发送邮箱验证码：%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"0000"]) {
            
            
            NSString * str = @"验证码已发送至您的邮箱";
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"验证邮箱"
                                                             message:str
                                                            delegate:self
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil, nil];
            [alert show];
            // 执行倒计时
            [ZJSecurityCodeTime countdown:self.securityCodeButton];
            
        }else{
            SHOW_ALERT(@"验证码发送失败");
        }
    } failure:^(id error) {
        
    }];
}


- (void)requestMail{
    if ([self.emailTextFiled.text length] <= 0) {
        SHOW_ALERT(@"电子邮箱不能为空");
    }else if([self.securityCodeTextFiled.text length] <= 0){
        SHOW_ALERT(@"验证码不能为空");
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userId"] = USERID;
        params[@"mail"] = self.emailTextFiled.text;
        params[@"code"] = self.securityCodeTextFiled.text;
        [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(MAINTENANCE) params:params controller:self success:^(id responseObject) {
            
            if ([responseObject[@"code"] isEqualToString:@"0000"]) {

                [[DataBaseHandle shareDataBaseHandleInit] openDB];
                NSArray * arr =   [[DataBaseHandle shareDataBaseHandleInit] selectStudent];
                
                
                notificationIdInfo *info = [arr lastObject];
                if (arr.count) {
                    info.mail = self.emailTextFiled.text;
                    info.mailFlag = @"1";
                    [[DataBaseHandle shareDataBaseHandleInit]updateStudent:info number:info.number];
                }

                self.returnMailBlock(self.emailTextFiled.text);
                [self.navigationController popViewControllerAnimated: YES];
                
            }else{
                SHOW_ALERT(responseObject[@"msg"]);
            
                NSLog(@"修改邮箱%@",responseObject);
                
            }
            
        } failure:^(id error) {
            
        }];

    }
    
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
