//
//  ZJAuthenticationViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/1.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "ZJAuthenticationViewController.h"
#import "ZJAuthenticationCell.h"
#import "ZJModifyMailViewController.h"
#import "ZJModifPhoneNumberViewController.h"
#import "ZJRealNameAuthenticationViewController.h"

@interface ZJAuthenticationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)NSArray * imageArray;
@property (strong, nonatomic)NSArray * titleArray;

@end

@implementation ZJAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = [[NSArray alloc]initWithObjects:@"icon-手机",@"icon-邮箱认证",@"icon-实名认证", nil];
    self.titleArray = [[NSArray alloc]initWithObjects:@"手机认证",@"邮箱认证",@"实名认证",nil];
    self.title = @"账户认证";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT ) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
  
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        
//    }
//    cell.backgroundColor = [UIColor redColor];
    ZJAuthenticationCell * cell = [ZJAuthenticationCell cellWithTableView:tableView];
    cell.icon.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.title.text = self.titleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    

    //打开数据库
    [[DataBaseHandle shareDataBaseHandleInit] openDB];
    NSArray * arr =   [[DataBaseHandle shareDataBaseHandleInit] selectStudent];
    notificationIdInfo *info = [arr lastObject];

    if (indexPath.row == 0) {
        
        cell.subTitle.text = info.phone ? info.phone : @"";
        
        NSString *phoneFlag = info.phoneFlag ? info.phoneFlag : @"";
        
        NSLog(@"phoneFlag: %@",phoneFlag);
        if ([phoneFlag isEqualToString:@"1"]) {
            cell.authLabel.text = @"已认证";
            cell.authImage.image = [UIImage imageNamed:@"icon-已认证"];
//            cell.userInteractionEnabled = NO;
        }else{
            cell.authLabel.text = @"未认证";
            cell.authImage.image = [UIImage imageNamed:@"icon-未认证"];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }else if (indexPath.row == 1){

        cell.subTitle.text = info.mail ? info.mail : @"";
        
        NSString *mailFlag = info.mailFlag ? info.mailFlag : @"";
        if ([mailFlag isEqualToString:@"1"]) {
            cell.authLabel.text = @"已认证";
            cell.authImage.image = [UIImage imageNamed:@"icon-已认证"];
//            cell.userInteractionEnabled = NO;
        }else{
            cell.authLabel.text = @"未认证";
            cell.authImage.image = [UIImage imageNamed:@"icon-未认证"];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }else{
     
        NSString *idCard = info.idCard;
        NSString *name =  info.name;
        
        NSString *detailText = [NSString stringWithFormat:@"%@ %@",name,idCard];

        cell.subTitle.text = detailText ? detailText : @"";
        
        NSString *identityFlag = info.identityFlag;
        if ([identityFlag isEqualToString:@"1"]) {
            cell.authLabel.text = @"已认证";
            cell.authImage.image = [UIImage imageNamed:@"icon-已认证"];
#warning - todo
//            cell.userInteractionEnabled = NO;
        }else{
            cell.authLabel.text = @"未认证";
            cell.authImage.image = [UIImage imageNamed:@"icon-未认证"];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //打开数据库
    [[DataBaseHandle shareDataBaseHandleInit] openDB];
    NSArray * arr =   [[DataBaseHandle shareDataBaseHandleInit] selectStudent];
    notificationIdInfo *info = [arr lastObject];
    NSString *phoneFlag = info.phoneFlag ? info.phoneFlag : @"";
    NSString *mailFlag = info.mailFlag ? info.mailFlag : @"";
    NSString *identityFlag = info.identityFlag;
    
    
    if (indexPath.row == 0) {
        
        if ([phoneFlag isEqualToString:@"1"]){
            [ZJHudExtension showText:@"手机已认证" view:self.view];
        }else{
            ZJModifPhoneNumberViewController *phoneVC = [[ZJModifPhoneNumberViewController alloc]init];
            phoneVC.title = @"手机认证";
            [self.navigationController pushViewController:phoneVC animated:YES];
        }
       
    }else if (indexPath.row == 1){
        if ([mailFlag isEqualToString:@"1"]) {
            [ZJHudExtension showText:@"邮箱已认证" view:self.view];
        }else{
            ZJModifyMailViewController *mailVC = [[ZJModifyMailViewController alloc]init];
            mailVC.title = @"邮箱认证";
            [self.navigationController pushViewController:mailVC animated:YES];
        }
        
       
    }else{
        if ([identityFlag isEqualToString:@"1"]) {
            [ZJHudExtension showText:@"已实名认证" view:self.view];
        }else{
            ZJRealNameAuthenticationViewController *authVC = [[ZJRealNameAuthenticationViewController alloc]init];
            [self.navigationController pushViewController:authVC animated:YES];
 
        }
        
    }
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
