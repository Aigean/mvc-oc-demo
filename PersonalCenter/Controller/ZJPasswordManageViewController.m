//
//  ZJPasswordManageViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/6.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJPasswordManageViewController.h"
#import "Masonry.h"
#import "ZJSecurityCodeTime.h"
#import "ZJRegularExpression.h"


@interface ZJPasswordManageViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *mailboxBtn;

@property (weak, nonatomic) IBOutlet UIImageView *mailOrPhoneImg;
@property (weak, nonatomic) IBOutlet UITextField *mailOrPhoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *getSecurityCodeBtn;

// userI'D
@property (copy, nonatomic) NSString *passUserId;

@property (nonatomic) int flag;


@end

@implementation ZJPasswordManageViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    return [[UIStoryboard storyboardWithName:@"ZJPasswordManage" bundle:nil] instantiateInitialViewController];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag = 1;
    /// 获取验证码边框
    self.getSecurityCodeBtn.layer.borderWidth = .5;
    self.getSecurityCodeBtn.layer.borderColor = HEXRGBCOLOR(0x35c7fa).CGColor;

}

- (IBAction)phoneClick:(id)sender {
    [sender setImage:[UIImage imageNamed:@"inco_手机"] forState:UIControlStateNormal];
    [sender setTitleColor:HEXRGBCOLOR(0x229eda) forState:UIControlStateNormal];
    [self.mailboxBtn setImage:[UIImage imageNamed:@"inco_邮箱_2"] forState:UIControlStateNormal];
    [self.mailboxBtn setTitleColor:HEXRGBCOLOR(0x636363) forState:UIControlStateNormal];
    //
    self.mailOrPhoneImg.image = [UIImage imageNamed:@"inco-手机-tb"];
    self.mailOrPhoneTextFiled.placeholder = @"手机号";
    self.securityCodeTextFiled.placeholder = @"手机验证码";
    self.mailOrPhoneTextFiled.text = nil;
    self.securityCodeTextFiled.text = nil;
    self.password.text = nil;
    self.confirmPassword.text = nil;
    self.flag = 1;
   
}
- (IBAction)mailClick:(id)sender {
    self.flag = 2;
    [sender setImage:[UIImage imageNamed:@"inco_邮箱"] forState:UIControlStateNormal];
    [sender setTitleColor:HEXRGBCOLOR(0x229eda) forState:UIControlStateNormal];
    [self.phoneBtn setImage:[UIImage imageNamed:@"inco_手机_2"] forState:UIControlStateNormal];
    [self.phoneBtn setTitleColor:HEXRGBCOLOR(0x636363) forState:UIControlStateNormal];
    //
    self.mailOrPhoneImg.image = [UIImage imageNamed:@"inco-邮箱-tb"];
    self.mailOrPhoneTextFiled.placeholder = @"邮箱";
    self.securityCodeTextFiled.placeholder = @"邮箱验证码";
    
    self.mailOrPhoneTextFiled.text = nil;
    self.securityCodeTextFiled.text = nil;
    self.password.text = nil;
    self.confirmPassword.text = nil;
    
    
}
- (IBAction)nextStepClick:(id)sender {
    [self requestPassword];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 验证码倒计时
- (IBAction)getSecurityCodeClick:(UIButton *)sender {
    [self requsetWhetherTheUserExists];

}
- (void)codeButtonClick
{

    NSString * phone =self.mailOrPhoneTextFiled.text;
  
    NSString * str = [NSString stringWithFormat:@"%@:%@",@"将发送验证码短信到这个号码",phone];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"确认手机号码"
                                                     message:str
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@"确定", nil];
    [alert show];
    
   
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        [ZJSecurityCodeTime countdown:_getSecurityCodeBtn];
        [self requestSecurityCode];
        
    }
}


#pragma mark - request
// 判断用户是否存在
- (void)requsetWhetherTheUserExists{
 
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.flag == 1){
        params[@"phone"] = _mailOrPhoneTextFiled.text;
        if ([ZJRegularExpression validateMobile:_mailOrPhoneTextFiled.text]) {
            [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(EXISTS) params:params controller:self success:^(id responseObject) {
                NSLog(@"存在性检验%@",responseObject);
                if(responseObject[@"code"]!=nil){
                    NSLog(@"用户是否存在code:%@",responseObject[@"code"]);
                    NSLog(@"用户是否存在response:%@",responseObject);
                    [ZJHudExtension showText:@"服务器处理失败" view:self.view];
                    
                }else if([responseObject[@"exists"] isEqualToString:@"1"]){
                    NSLog(@"用户是否存在：%@",responseObject);
                    _passUserId = responseObject[@"userId"];
                    
                    
//                    [self requestSecurityCode];
                    
                        if (self.flag == 1){
                           [self codeButtonClick];
                        }
                        else{
                           
                                NSString * str = @"已发送验证码短到您的邮箱";
                                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"邮箱验证"
                                                                                 message:str
                                                                                delegate:self
                                                                       cancelButtonTitle:@"确定"
                                                                       otherButtonTitles:nil, nil];
                                [alert show];
                                [ZJSecurityCodeTime countdown:_getSecurityCodeBtn];
                                [self requestSecurityCode];
                         
                        }
                    
                }else if([responseObject[@"exists"] isEqualToString:@"0"]){
                    SHOW_ALERT(@"用户不存在");
                    
                }
                
            } failure:^(id error) {
                
            }];
            
        }
        else{
            SHOW_ALERT(@"手机号格式不正确");
        }
    }
    if (self.flag == 2){
        params[@"mail"] = _mailOrPhoneTextFiled.text;
        
        if ([ZJRegularExpression validateEmail:_mailOrPhoneTextFiled.text]) {
            [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(EXISTS) params:params controller:self success:^(id responseObject) {
                NSLog(@"存在性检验%@",responseObject);
                if(responseObject[@"code"]!=nil){
                    NSLog(@"用户是否存在code:%@",responseObject[@"code"]);
                    NSLog(@"用户是否存在response:%@",responseObject);
                    [ZJHudExtension showText:@"服务器处理失败" view:self.view];
                    
                }else if([responseObject[@"exists"] isEqualToString:@"1"]){
                    NSLog(@"用户是否存在：%@",responseObject);
                    _passUserId = responseObject[@"userId"];
                    
                    [self requestSecurityCode];
                    
                }else if([responseObject[@"exists"] isEqualToString:@"0"]){
                    SHOW_ALERT(@"用户不存在");
                }
            } failure:^(id error) {
                
            }];

        }else{
            SHOW_ALERT(@"邮箱格式不正确");
        }
    }
    
    
}
- (void)requestSecurityCode{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
   
    if (self.flag == 1) {
        params[@"method"] = @"1";
    }
    if (self.flag == 2) {
        params[@"method"] = @"2";
    }
   
    if ([self.title isEqualToString:@"密码管理"]) {
        params[@"event"] = @"2";
    }
    if ([self.title isEqualToString:@"密码重置"]) {
        params[@"event"] = @"3";
    }
    params[@"address"] = self.mailOrPhoneTextFiled.text;
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(CODE) params:params controller:self success:^(id responseObject) {
        
        NSLog(@"改密码验证码：%@",responseObject);
        if([responseObject[@"code"]isEqualToString:@"0000"])  {
#warning todo
            
        }else{
            NSLog(@"%@",responseObject);
            SHOW_ALERT(@"验证码发送失败");
            
        }

        
    } failure:^(id error) {
        
    }];
}
- (void)requestPassword{

    

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"userId"] = self.passUserId;
    NSLog(@"passUserId:%@",self.passUserId);
    if (self.flag == 1) {
        params[@"phone"] = self.mailOrPhoneTextFiled.text;
    }
    if (self.flag == 2) {
        params[@"mail"] = self.mailOrPhoneTextFiled.text;
    }
    
    params[@"code"] = self.securityCodeTextFiled.text;
    
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(PASSWORD) params:params controller:self success:^(id responseObject) {
        
        if ([responseObject[@"code"]isEqualToString:@"0000"]) {
#warning Todo
            [ZJHudExtension showText:@"修改成功" view:self.view];
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }else{
            SHOW_ALERT(responseObject[@"msg"]);
        }
    } failure:^(id error) {
        
    }];
    
   
}

@end
