//
//  ZJMessageDetailViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/4.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJMessageDetailViewController.h"

@interface ZJMessageDetailViewController ()

@end

@implementation ZJMessageDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    return [[UIStoryboard storyboardWithName:@"ZJMessageDetail" bundle:nil] instantiateInitialViewController];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationItem.title = @"消息通知";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];                                                                                                                                                                                                                                                                    
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)request{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = [NSString stringWithFormat:@"%@",USERID];
    params[@"messageId"] = self.menuId;
    
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(READ) params:params controller:self success:^(id responseObject) {
        
        if(responseObject[@"code"]!=nil){
            NSLog(@"消息读取:%@",responseObject[@"code"]);
            NSLog(@"%@",responseObject);
            
        }else{
            self.headLineLabel.text = responseObject[@"title"];
            self.contentLabel.text = [NSString stringWithFormat:@"    %@",responseObject[@"desc"]];
//            self.contentLabel.text = @"啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦";
        
            NSLog(@"读取%@",responseObject);
            
        }
        
        
    } failure:^(id error) {
        
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
