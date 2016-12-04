//
//  ZJEstimateViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/30.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "ZJEstimateViewController.h"
#import "ZJHandleTableViewCell.h"
#import "ZJStarViewController.h"
#import "ZJBussinessModel.h"

@interface ZJEstimateViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *listArray;
@property (weak, nonatomic)MJRefreshBackNormalFooter *footer;
@property (assign, nonatomic)NSInteger pageNum;


@end

@implementation ZJEstimateViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    _listArray = [[NSMutableArray alloc]init];
    self.pageNum = 1;
    [self requestBusiness];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"用户评价";
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
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
    cell.navTitle = self.navigationItem.title;
    ZJBussinessModel *model = [self.listArray objectAtIndex:indexPath.row];
    cell.model = model;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJStarViewController *star = [[ZJStarViewController alloc]init];
    ZJBussinessModel *model = [self.listArray objectAtIndex:indexPath.row];
    star.businessId = model.businessId;
    star.evaluateFlag = [model.evaluateFlag intValue];
   
    [self.navigationController pushViewController:star animated:YES];
        

  
    
}

#pragma mark - request
- (void)requestBusiness{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;
    params[@"pageSize"] = @"10";
    params[@"pageNum"] = [NSString stringWithFormat:@"%li",(long)_pageNum];
    params[@"finishFlag"] = @"1";
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(BUSINESS) params:params controller:self success:^(id responseObject) {
        if(responseObject[@"code"]!=nil){
            NSLog(@"用户评价:%@",responseObject[@"code"]);
            NSLog(@"%@",responseObject);
            
        }else{
            NSLog(@"%@",responseObject);
            [self endRefresh];
            
//            self.listArray = [[NSMutableArray alloc]init];
            NSMutableArray *tempArr = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in responseObject[@"list"]) {
                ZJBussinessModel *model = [[ZJBussinessModel alloc]init];
                // Todo:
                if ([dic[@"finishFlag"] integerValue] == 1) {
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
        
    }];

}


@end
