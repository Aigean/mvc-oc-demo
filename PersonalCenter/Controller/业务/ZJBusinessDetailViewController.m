//
//  ZJBusinessDetailViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/10/12.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJBusinessDetailViewController.h"
#import "TimeLineViewControl.h"
#import "ZJBussinessModel.h"
#import "ZJHandleTableViewCell.h"
#import "ZJLineTableViewCell.h"
#import "ZJHistoryModel.h"
#import "MJExtension.h"

@interface ZJBusinessDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak)UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *descriptionsArr;
@property (nonatomic, strong) NSMutableArray *topArr;

@end

@implementation ZJBusinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"办件进度";
    
    [self requstDetail];
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    

    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _descriptionsArr.count + _topArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        ZJHandleTableViewCell * cell = [ZJHandleTableViewCell cellWithTableView:tableView];
        cell.accessory.hidden = YES;
        
        ZJBussinessModel *model = [self.topArr objectAtIndex:indexPath.row];
        cell.model = model;
        if (self.status) {
            cell.status.text = self.status;
        }
        
//            cell.navTitle = self.navigationItem.title;
        return cell;
    }else{
        ZJLineTableViewCell *cell = [ZJLineTableViewCell cellWithTableView:tableView];
        ZJHistoryModel *model = [self.descriptionsArr objectAtIndex:indexPath.row - 1];
        cell.model = model;
        cell.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
      
        if (indexPath.row == _descriptionsArr.count) {
            cell.lineView.hidden = YES;
        }
        
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 105;
    }else{
        return 120;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 已评价的数据
- (void)requstDetail{

    
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
//    params[@"userId"] = [NSString stringWithFormat:@"%@",USERID];
    params[@"userId"] = USERID;
    params[@"businessId"] = self.businessId;
    NSLog(@"%@",self.businessId);
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(BUSINESSDETAIL) params:params controller:self success:^(id responseObject) {
        NSLog(@"流程：%@",responseObject);
        if (responseObject[@"code"] != nil) {
            NSLog(@"流程：%@",responseObject);
            
            [ZJHudExtension showText:@"处理失败" view:self.view];
//            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            _topArr = [[NSMutableArray alloc]init];
            ZJBussinessModel *model = [ZJBussinessModel mj_objectWithKeyValues:responseObject];
            [_topArr addObject:model];
            
            _descriptionsArr = [[NSMutableArray alloc]init];
            
            for (NSDictionary *dict in responseObject[@"history"]) {
                ZJHistoryModel *model = [ZJHistoryModel mj_objectWithKeyValues:dict];
                [_descriptionsArr addObject:model];
            }
            
//            [self progress];
//            NSLog(@"%@",_descriptionsArr);
            [self.tableView reloadData];
//            NSLog(@"流程：%@",responseObject);
        }
        
    } failure:^(id error) {
        
    }];
    
//    NSString *url = [NSString stringWithFormat:@"app/service/handlingDetail.action?accessToken=%@",account.accessToken];
//    [manager POST:DOMAINNAME(url) parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        
//        
//        if (responseObject[@"code"] != nil) {
//            NSLog(@"流程：%@",responseObject);
//            
//            [ZJHudExtension showText:@"处理失败" view:self.view];
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            [sHud hideAnimated:YES];
//            NSLog(@"流程：%@",responseObject);
//            self.star1.actualScore = [[NSString isBlankString:responseObject[@"progress"]] ? @"0.0" : responseObject[@"progress"] floatValue];
//            self.star2.actualScore = [[NSString isBlankString:responseObject[@"systemCommon"]] ? @"0.0" : responseObject[@"progress"] floatValue];
//            self.star3.actualScore = [[NSString isBlankString:responseObject[@"attitude"]] ? @"0.0" : responseObject[@"progress"] floatValue];
//            self.star4.actualScore = [[NSString isBlankString:responseObject[@"satisfaction"]] ? @"0.0" : responseObject[@"progress"] floatValue];
//            self.textView.text = [NSString isBlankString:responseObject[@"description"]] ? @"" : responseObject[@"description"];
//            
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        [ZJHudExtension showText:@"网络错误" view:self.view];
//    }];
//    
    
}

- (void)progress{
    
    //    NSArray *descriptions = @[@"state 1",@"state 2",@"state 3",@"state 4",@"very very long and very very detailed description 0f state 5"];
    TimeLineViewControl *timeline = [[TimeLineViewControl alloc] initWithTimeArray:nil
                                                           andTimeDescriptionArray:_descriptionsArr
                                                                  andCurrentStatus:4
                                                                          andFrame:CGRectMake(20, 130, self.view.frame.size.width - 30, 200)];
    //    timeline.center = self.view.center;
    [self.tableView addSubview:timeline];
    [self.tableView reloadData];
}


@end
