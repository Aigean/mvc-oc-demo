//
//  ZJModifyNameViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/8.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJModifyNameViewController.h"
#import "DataBaseHandle.h"
#import "notificationIdInfo.h"
@interface ZJModifyNameViewController ()


@end

@implementation ZJModifyNameViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    return [[UIStoryboard storyboardWithName:@"ZJModifyName" bundle:nil] instantiateInitialViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"姓名";
    self.name.text = _labname;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)modifyNameClick:(id)sender {
    [self requestName];
}
#pragma mark - request
- (void)requestName{
    if ([self.name.text length] <= 0) {
        SHOW_ALERT(@"姓名不能为空");
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userId"] = USERID;
        params[@"name"] = self.name.text;
        
        [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(MAINTENANCE) params:params controller:self success:^(id responseObject) {
            
            if ([responseObject[@"code"] isEqualToString:@"0000"]) {
//                [[NSUserDefaults standardUserDefaults]setObject:self.name.text forKey:@"name"];
//                [[NSUserDefaults standardUserDefaults]synchronize];
                self.returnNameBlock(self.name.text);
                [[DataBaseHandle shareDataBaseHandleInit] openDB];
                NSArray * arr =   [[DataBaseHandle shareDataBaseHandleInit] selectStudent];
                notificationIdInfo *info = [arr lastObject];
                if (arr.count) {
                    info.name = self.name.text;
                    [[DataBaseHandle shareDataBaseHandleInit]updateStudent:info number:info.number];
                }
                [self.navigationController popViewControllerAnimated: YES];
                
            }else{
                NSLog(@"name:%@",responseObject[@"code"]);
                NSLog(@"%@",responseObject);
            }
            
            
        } failure:^(id error) {
            
        }];

        
    }
}


@end
