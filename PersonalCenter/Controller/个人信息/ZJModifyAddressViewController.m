//
//  ZJModifyAddressViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/8.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJModifyAddressViewController.h"


@interface ZJModifyAddressViewController ()
@property (weak, nonatomic) IBOutlet UITextField *addressTextFiled;

@end

@implementation ZJModifyAddressViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    return [[UIStoryboard storyboardWithName:@"ZJModifyAddress" bundle:nil] instantiateInitialViewController];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"地址";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addressTextFiled.text = self.address;
    // Do any additional setup after loading the view.
}

- (IBAction)modifyButtonClick:(id)sender {
    [self requestAddress];
}

#pragma mark - request
- (void)requestAddress{
    
    if ([self.addressTextFiled.text length] <= 0) {
        SHOW_ALERT(@"地址不能为空");
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userId"] = USERID;
        params[@"address"] = self.addressTextFiled.text;
        
        [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(MAINTENANCE) params:params controller:self success:^(id responseObject) {
            if ([responseObject[@"code"] isEqualToString:@"0000"]) {
//                [[NSUserDefaults standardUserDefaults]setObject:self.addressTextFiled.text forKey:@"address"];
//                [[NSUserDefaults standardUserDefaults]synchronize];
                [[DataBaseHandle shareDataBaseHandleInit] openDB];
                NSArray * arr =   [[DataBaseHandle shareDataBaseHandleInit] selectStudent];
                notificationIdInfo *info = [arr lastObject];
                if (arr.count) {
                    info.address = self.addressTextFiled.text;
                    [[DataBaseHandle shareDataBaseHandleInit]updateStudent:info number:info.number];
                }
                self.returnAddressBlock(self.addressTextFiled.text);
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
