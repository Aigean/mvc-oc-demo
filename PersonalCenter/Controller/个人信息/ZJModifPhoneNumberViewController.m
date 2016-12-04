//
//  ZJModifPhoneNumberViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/8.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJModifPhoneNumberViewController.h"
#import "ZJSecurityCodeTime.h"
#import "DataBaseHandle.h"
#import "notificationIdInfo.h"

@interface ZJModifPhoneNumberViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *securityCodeBtn;

@end

@implementation ZJModifPhoneNumberViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    return [[UIStoryboard storyboardWithName:@"ZJModifyPhoneNumber" bundle:nil] instantiateInitialViewController];
}

- (void)viewWillAppear:(BOOL)animated{
//    self.navigationItem.title = @"手机";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 获取验证码边框
    self.securityCodeBtn.layer.borderWidth = .5;
    self.securityCodeBtn.layer.borderColor = HEXRGBCOLOR(0x35c7fa).CGColor;
    /// 手机号
    self.phoneNumberTextFiled.text = self.phoneNumber;
    
}
#pragma mark - get security code.
- (IBAction)securityCodeClick:(id)sender {
    
    [self requestExist];
    
}

#pragma mark - 获取验证码请求
- (void)requestSecurityCode{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
   
    params[@"method"] = @"1";
    if ([self.title isEqualToString:@"修改手机号"]) {
        params[@"event"] = @"4";
    }
    if ([self.title isEqualToString:@"手机认证"]) {
        params[@"event"] = @"6";
    }
    
    params[@"address"] = self.phoneNumberTextFiled.text;
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(CODE) params:params controller:self success:^(id responseObject) {
        
        NSLog(@"改密码验证码：%@",responseObject);
        if([responseObject[@"code"]isEqualToString:@"0000"])  {
#warning todo
            
        }else{
            NSLog(@"%@",responseObject);
            
        }
        
        
    } failure:^(id error) {
        
    }];
}

- (IBAction)modifyButtonClick:(id)sender {
//    [self requestPhoneNumber];
    [self requestLast];
}

#pragma mark - 存在性检验
- (void)requestExist{
    
    if (![ZJRegularExpression validateMobile:self.phoneNumberTextFiled.text]) {
        SHOW_ALERT(@"手机号格式不正确");
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"phone"] = self.phoneNumberTextFiled.text;
        [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(EXISTS) params:params controller:self success:^(id responseObject) {
            NSLog(@"手机存在性检验%@",responseObject);
            if ([responseObject[@"exists"] isEqualToString:@"1"] ) {
                SHOW_ALERT(@"该手机号已被注册");
            }else if ([responseObject[@"exists"] isEqualToString:@"0"]) {
                
                NSString * phone =self.phoneNumberTextFiled.text;
                NSString * str = [NSString stringWithFormat:@"%@:%@",@"将发送验证码短信到这个号码",phone];
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"确认手机号码"
                                                                 message:str
                                                                delegate:self
                                                       cancelButtonTitle:@"取消"
                                                       otherButtonTitles:@"确定", nil];
                [alert show];
                
                
                
                
            }else{
                SHOW_ALERT(@"暂无法手机号验证");
            }
        } failure:^(id error) {
            
        }];
        

    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        [ZJSecurityCodeTime countdown:self.securityCodeBtn];
        [self requestSecurityCode];
    }
}

#pragma mark - 修改手机号网络请求
- (void)requestLast{
    if ([self.phoneNumberTextFiled.text length] <= 0) {
        SHOW_ALERT(@"手机号不能为空");
    }else if([self.securityCodeTextFiled.text length] <= 0 ){
        SHOW_ALERT(@"验证码不能为空");
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userId"] = USERID;
        params[@"phone"] = self.phoneNumberTextFiled.text;
        params[@"code"] = self.securityCodeTextFiled.text;
        
        [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(MAINTENANCE) params:params controller:self success:^(id responseObject) {
            if ([responseObject[@"code"] isEqualToString:@"0000"]) {
                [ZJHudExtension showText:@"修改成功" view:self.view];
//                [[NSUserDefaults standardUserDefaults]setObject:self.phoneNumberTextFiled.text forKey:@"phone"];
//                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[DataBaseHandle shareDataBaseHandleInit] openDB];
                NSArray * arr =   [[DataBaseHandle shareDataBaseHandleInit] selectStudent];
                notificationIdInfo *info = [arr lastObject];
                if (arr.count) {
                    info.phone = self.phoneNumberTextFiled.text;
                    info.phoneFlag = @"1";
                    [[DataBaseHandle shareDataBaseHandleInit]updateStudent:info number:info.number];
                }
                self.returnPhoneNumberBlock(self.phoneNumberTextFiled.text);
                [self.navigationController popViewControllerAnimated: YES];
                
            }else{
                NSLog(@"name:%@",responseObject[@"code"]);
                NSLog(@"%@",responseObject);
                
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
