//
//  PersonalCenterViewController.m
//  ZhenjiangRenshe
//
//  Created by  周毅 on 16/8/4.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PCOneTableViewCell.h"
#import "PCTwoTableViewCell.h"
#import "ZJSettingsTableViewController.h"
#import "ZJBasicInfoTableViewController.h"
#import "ZJUserInfoViewController.h"
#import "ZJLoginViewController.h"
#import "notificationIdInfo.h"
#import "DataBaseHandle.h"
#import "NSString+Utilities.h"
@interface PersonalCenterViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *autonymBtn;
@property (weak, nonatomic) IBOutlet UIButton *basicInfoBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end



@implementation PersonalCenterViewController



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    return [[UIStoryboard storyboardWithName:@"PersonalCenter" bundle:nil] instantiateInitialViewController];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (!ACCESSTOKEN) {
        ZJLoginViewController * login = [[ZJLoginViewController alloc]init];
        //    [self.navigationController pushViewController:login animated:YES];
        [self presentViewController:login animated:YES completion:^{
            
        }];

    }
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人中心";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: [UIColor colorWithHex:@"00558E" andAlpha:1.0],
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:18]
                                                                    };
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHex:@"333333" andAlpha:1.0];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _headerView;
    
    // 切圆头像
    self.avatar.clipsToBounds = YES;
    self.avatar.layer.cornerRadius = 47.5;
    
    
   
    
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    处理头像点击事件
    self.avatar.userInteractionEnabled = YES;
    UITapGestureRecognizer *avatarTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avatarClick)];
    [self.avatar addGestureRecognizer:avatarTap];
    
     [self requset];
    
    
}

- (void)avatarClick{
    
}


#pragma mark - tableView DataSource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PCOneTableViewCell *cell = [PCOneTableViewCell cellWithTableView:tableView];
        cell.pcController = self;
        
        return cell;
    }else{
        PCTwoTableViewCell *cell = [PCTwoTableViewCell cellWithTableView:tableView];
        cell.pc2Controller = self;
        return cell;
    }
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 181;
    }else{
        return 0.48*SCREEN_WIDTH;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (IBAction)basicInfoClick:(UIButton *)sender {
    ZJUserInfoViewController * userInfo = [[ZJUserInfoViewController alloc]init];
    userInfo.returnAvatarBlock = ^(UIImage *showAvatar){
        self.avatar.image = showAvatar;
    };
    userInfo.returnFirstNameBlock = ^(NSString *showName){
        self.nameLabel.text = showName;
    };
    [self.navigationController pushViewController:userInfo animated:YES];
    
}

- (void)setting{
    ZJSettingsTableViewController *setting = [[ZJSettingsTableViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 网络请求
- (void)requset{
    

//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
//    
//    
//    ZJAccountModel *account = [ZJAccountTool account];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(PERSON) params:params controller:self success:^(id responseObject) {
        
        
        if(responseObject[@"code"]!=nil){
            NSLog(@"个人中心:%@",responseObject[@"code"]);
            
        }else{
            
            
            NSLog(@"%@",responseObject);
            self.nameLabel.text = responseObject[@"name"];
            
            NSData *decodedImageData = [[NSData alloc]initWithBase64EncodedString:responseObject[@"photo"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            if (![NSString isBlankString:responseObject[@"photo"]]) {
                self.avatar.image = [UIImage imageWithData:decodedImageData];
                //                NSLog(@"decode:%@",decodedImageData);
            }else{
                self.avatar.image = [UIImage imageNamed:@"pic-tx"];
            }
            if ([responseObject[@"identityFlag"] isEqual:@"0"]) {
                [self.autonymBtn setImage:[UIImage imageNamed:@"but-未实名"] forState:UIControlStateNormal];
                [self.autonymBtn setTitle:@"未实名" forState:UIControlStateNormal];
                
            }
            
            // 保存到数据库中
            [[DataBaseHandle shareDataBaseHandleInit] openDB];
            [[DataBaseHandle shareDataBaseHandleInit] createTable];

            notificationIdInfo * info  = [[notificationIdInfo alloc] init];
            
            info.image = [NSString isNilOrEmpty: responseObject[@"photo"]] ? @"" : responseObject[@"photo"];
            info.mail = [NSString isNilOrEmpty: responseObject[@"mail"]] ? @"" : responseObject[@"mail"];
            info.phone = [NSString isNilOrEmpty: responseObject[@"phone"]] ? @"" : responseObject[@"phone"];
            info.phoneFlag = [NSString isNilOrEmpty: responseObject[@"phoneFlag"]] ? @"" : responseObject[@"phoneFlag"];
            info.mailFlag = [NSString isNilOrEmpty: responseObject[@"mailFlag"]] ? @"" : responseObject[@"mailFlag"];
            info.idCard = [NSString isNilOrEmpty: responseObject[@"idCard"]] ? @"" : responseObject[@"idCard"];
            info.identityFlag = [NSString isNilOrEmpty: responseObject[@"identityFlag"]] ? @"" : responseObject[@"identityFlag"];
            info.name = [NSString isNilOrEmpty: responseObject[@"name"]] ? @"" : responseObject[@"name"];
            info.address = [NSString isNilOrEmpty: responseObject[@"address"]] ? @"" : responseObject[@"address"];
          
            
            [[DataBaseHandle shareDataBaseHandleInit] insertStudent:info];

            
            
            

            
//            [[NSUserDefaults standardUserDefaults]setObject:decodedImageData forKey:@"image"];
//            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"phone"] forKey:@"phone"];
//            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"phoneFlag"] forKey:@"phoneFlag"];
//            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"mail"] forKey:@"mail"];
//            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"mailFlag"] forKey:@"mailFlag"];
//            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"address"] forKey:@"address"];
//            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"name"] forKey:@"name"];
//            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"idCard"] forKey:@"idCard"];
//            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"identityFlag"] forKey:@"identityFlag"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
        }

        
    } failure:^(id error) {
        
    }];
    
    
}
@end
