//
//  ZJMessageNotificationViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/10/12.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJMessageNotificationViewController.h"
#import "ZJMessageNotiTableViewCell.h"
#import "ZJMessageModel.h"
#import "MJExtension.h"
#import "ZJMessageDetailViewController.h"

@interface ZJMessageNotificationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property(assign, nonatomic)NSInteger pageNum;
@property (nonatomic, weak)MJRefreshBackNormalFooter *footer;

@end

@implementation ZJMessageNotificationViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.titleTextAttributes = @{
//                                                                    NSForegroundColorAttributeName: [UIColor colorWithHex:@"00558E" andAlpha:1.0],
//                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:18]
//                                                                    };
    self.listArray = [[NSMutableArray alloc]init];
    self.pageNum = 1;
    self.navigationItem.title = @"消息通知";
    [self requestMessage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //  下拉刷下
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        self.listArray = [[NSMutableArray alloc]init];
        self.pageNum = 1;
        [self requestMessage];
    }];
    // 上拉加载更多
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNum++;
        [self requestMessage];
    }];
    self.footer = footer;
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer = footer;


    
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZJMessageNotiTableViewCell * cell = [ZJMessageNotiTableViewCell cellWithTableView:tableView];
    
    ZJMessageModel *model =[self.listArray objectAtIndex:indexPath.row];
    cell.messageModel = model;

    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJMessageDetailViewController *DVC = [[ZJMessageDetailViewController alloc]init];
    ZJMessageModel *model = [self.listArray objectAtIndex:indexPath.row];
    DVC.menuId = model.messageId;
    [self.navigationController pushViewController:DVC animated:YES];
    
    
    
}
#pragma mark - request
- (void)requestMessage{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = [NSString stringWithFormat:@"%@",USERID];
    params[@"pageSize"] = @"10";
    params[@"pageNum"] = [NSString stringWithFormat:@"%ld",(long)self.pageNum];
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrlWithoutIndicator:DOMAINNAME(MESSAGE) params:params controller:self success:^(id responseObject) {
        
        if(responseObject[@"code"]!=nil){
            NSLog(@"消息通知:%@",responseObject[@"code"]);
            NSLog(@"%@",responseObject);
            
        }else{
            [self endRefresh];
            
            NSMutableArray * tempArr = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dict in responseObject[@"list"]) {
                ZJMessageModel *model = [ZJMessageModel mj_objectWithKeyValues:dict];
                [tempArr addObject:model];

            }
            if (tempArr.count == 0) {
            [_footer setTitle:@"已加载全部" forState:MJRefreshStateIdle];
//                self.tableView.footer
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
//                 [self.tableView.mj_footer endRefreshingWithNoMoreData];
                // 隐藏当前的上拉刷新控件
//                self.tableView.mj_footer.hidden = YES;

            }else{
                self.tableView.mj_footer.hidden = NO;

            }
            NSLog(@"%@",responseObject);
            [self.listArray addObjectsFromArray:tempArr];

            [tempArr removeAllObjects];
            [self.tableView reloadData];
            



        }

        
    } failure:^(id error) {
        
    }];
    

    
}



@end
