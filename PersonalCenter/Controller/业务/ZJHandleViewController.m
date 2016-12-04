//
//  ZJHandleViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/24.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "ZJHandleViewController.h"
#import "ZJHandleTableViewCell.h"
#import "ZJBusinessDetailViewController.h"

@interface ZJHandleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (weak, nonatomic)MJRefreshBackNormalFooter *footer;
@property (assign, nonatomic)NSInteger pageNum;
@end

@implementation ZJHandleViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"已办理";
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    
    self.listArray = [[NSMutableArray alloc]init];
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
//    cell.navTitle = self.navigationItem.title;
    ZJBussinessModel *model = [self.listArray objectAtIndex:indexPath.row];
    cell.navTitle = self.navigationItem.title;
    cell.model = model;
    
    NSLog(@"cell:%@",self.navigationItem.title);
    return cell;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZJBusinessDetailViewController * bs = [[ZJBusinessDetailViewController alloc]init];
    ZJBussinessModel *model = [self.listArray objectAtIndex:indexPath.row];
    bs.businessId = model.businessId;
    bs.status = @"已办理";
    [self.navigationController pushViewController:bs animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
#pragma mark - request
- (void)requestBusiness{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;
    params[@"pageSize"] = @"10";
    params[@"pageNum"] = [NSString stringWithFormat:@"%li",(long)self.pageNum];
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(BUSINESS) params:params controller:self success:^(id responseObject) {
        if(responseObject[@"code"]!=nil){
            NSLog(@"已办理:%@",responseObject[@"code"]);
            NSLog(@"%@",responseObject);
            
        }else{
            NSLog(@"%@",responseObject);
            [self endRefresh];
//            
//            self.listArray = [[NSMutableArray alloc]init];
//            for (NSDictionary *dic in responseObject[@"list"]) {
//                ZJBussinessModel *model = [[ZJBussinessModel alloc]init];
//                if ([dic[@"finishFlag"] integerValue] == 1) {
//                    [model setValuesForKeysWithDictionary:dic];
//                    [self.listArray addObject:model];
//                }
//                
//            }
//            [self.tableView reloadData];
       
            NSMutableArray * tempArr = [[NSMutableArray alloc] init];
            ZJBussinessModel *model = [[ZJBussinessModel alloc]init];

            for (NSDictionary *dict in responseObject[@"list"]) {
                if ([dict[@"finishFlag"] integerValue] == 1) {
                    [model setValuesForKeysWithDictionary:dict];
                    [tempArr addObject:model];
                }
                
            }
            if (tempArr.count == 0) {
                [_footer setTitle:@"已加载全部" forState:MJRefreshStateIdle];
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
