//
//  ZJUnderHandleViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/24.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "ZJUnderHandleViewController.h"
#import "ZJHandleTableViewCell.h"
#import "ZJBussinessModel.h"
#import "ZJBusinessDetailViewController.h"
@interface ZJUnderHandleViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak)UITableView *tableView;
// 获取信息列表
@property (strong, nonatomic)NSMutableArray *listArray;

@property (weak, nonatomic)MJRefreshBackNormalFooter *footer;
@property (assign, nonatomic)NSInteger pageNum;


@end

@implementation ZJUnderHandleViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"办理中";
}
- (NSMutableArray *)listArray{
    if (_listArray == nil) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self requestBusiness];
    
    //  下拉刷下
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        self.listArray = [[NSMutableArray alloc]init];
        self.pageNum = 1;
        [self requestBusiness];
    }];
    // 上拉加载更多
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNum++;
        [self requestBusiness];
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
    
    ZJHandleTableViewCell * cell = [ZJHandleTableViewCell cellWithTableView:tableView];
    ZJBussinessModel *model = [self.listArray objectAtIndex:indexPath.row];
    cell.model = model;
    cell.navTitle = self.navigationItem.title;
    return cell;
}

#pragma mark - request
- (void)requestBusiness{
  
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;
    params[@"pageSize"] = @"10";
    params[@"pageNum"] = [NSString stringWithFormat:@"%ld",(long)_pageNum];
    
    NSLog(@"userID:%@",USERID);
    NSLog(@"Token:%@",ACCESSTOKEN);
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(BUSINESS) params:params controller:self success:^(id responseObject) {
        if(responseObject[@"code"]!=nil){
            NSLog(@"已办理:%@",responseObject[@"code"]);
            NSLog(@"%@",responseObject);
            
        }else{
            NSLog(@"%@",responseObject);
            [self endRefresh];
            
            
//            self.listArray = [[NSMutableArray alloc]init];
            NSMutableArray * tempArr = [[NSMutableArray alloc] init];

            for (NSDictionary *dic in responseObject[@"list"]) {
                ZJBussinessModel *model = [[ZJBussinessModel alloc]init];
                if ([dic[@"finishFlag"] integerValue] == 0) {
                    [model setValuesForKeysWithDictionary:dic];
                    [tempArr addObject:model];
                }
                
            }
            if (tempArr.count == 0) {
                [_footer setTitle:@"已加载全部" forState:MJRefreshStateIdle];
            }
            [self.listArray addObjectsFromArray:tempArr];
            [tempArr removeAllObjects];
            [self.tableView reloadData];
            
        }

        
    } failure:^(id error) {
        NSLog(@"办理中出错：%@",error);
        
    }];
    
   
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZJBusinessDetailViewController * bs = [[ZJBusinessDetailViewController alloc]init];
    ZJBussinessModel *model = [self.listArray objectAtIndex:indexPath.row];
    bs.businessId = model.businessId;
//    bs.status = model.statusName;
//    bs.date = model.
    [self.navigationController pushViewController:bs animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
