//
//  ZJBasicInfoTableViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/23.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "ZJBasicInfoTableViewController.h"
#import "ALCustomColoredAccessory.h"
#import "ZJBaiscHeaderView.h"
#import "ZJBIOneViewCell.h"
#import "ZJBITwoViewCell.h"
#import "Masonry.h"
#import "ZJDetailTableViewCell.h"

#define RATIO SCREEN_WIDTH/375.0

@interface ZJBasicInfoTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSMutableIndexSet *expandedSections;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

/// 社保卡相关属性
// 头像
@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UIImageView *bank;
@property (strong, nonatomic) UIImageView *authentication;
@property (strong, nonatomic) UILabel *number;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *identifierNumber;
@property (strong, nonatomic) UILabel *year;
@property (strong, nonatomic) UILabel *month;
@property (strong, nonatomic) UILabel *account;
@property (strong, nonatomic) UILabel *bankSearveNum;




@end

@implementation ZJBasicInfoTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    return [[UIStoryboard storyboardWithName:@"ZJBasicInfo" bundle:nil] instantiateInitialViewController];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"基本信息";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 17.0/25 * SCREEN_WIDTH);
    self.tableView.tableHeaderView = self.headerView;
    [self setCard];
    
    

    static NSString *CellIdentifier = @"Cell";
    [self.tableView registerClass:[UITableViewCell self] forCellReuseIdentifier:CellIdentifier];
    
    
    
    
    if (!_expandedSections)
    {
        _expandedSections = [[NSMutableIndexSet alloc] init];
    }
    [self initDic];
    
}

- (void)setCard{
    self.avatar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic-照片"]];
    self.avatar.frame = CGRectMake(16*RATIO, 59*RATIO, 62*RATIO, 62*1.2*RATIO);
    [self.headerImageView addSubview:self.avatar];
    
    self.bank = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic-中国银行"]];
    self.bank.frame = CGRectMake(16*RATIO, 18*RATIO, 100*RATIO, 34*RATIO);
    self.bank.contentMode = UIViewContentModeScaleAspectFit;
    [self.headerImageView addSubview:self.bank];
    
    self.name = [[UILabel alloc]initWithFrame:CGRectMake(155*RATIO, 55*RATIO, 160*RATIO, 26*RATIO)];
    self.name.text = @"王宝宝";
    self.name.textColor = [UIColor colorWithHex:@"333333" andAlpha:1.0];
    self.name.font = [UIFont systemFontOfSize:12];
    [self.headerImageView addSubview:self.name];
    
    self.number = [[UILabel alloc]initWithFrame:CGRectMake(155*RATIO, 83*RATIO, 160*RATIO, 26*RATIO)];
    self.number.text = @"111222333444555666";
    self.number.textColor = [UIColor colorWithHex:@"333333" andAlpha:1.0];
    self.number.font = [UIFont systemFontOfSize:12];
    [self.headerImageView addSubview:self.number];
    
    self.identifierNumber = [[UILabel alloc]initWithFrame:CGRectMake(155*RATIO, 112*RATIO, 160*RATIO, 26*RATIO)];
    self.identifierNumber.text = @"JSL003214567";
    self.identifierNumber.textColor = [UIColor colorWithHex:@"333333" andAlpha:1.0];
    self.identifierNumber.font = [UIFont systemFontOfSize:12];
    [self.headerImageView addSubview:self.identifierNumber];
    
    self.year = [[UILabel alloc]initWithFrame:CGRectMake(157*RATIO, 149*RATIO, 30*RATIO, 26*RATIO)];
    self.year.text = @"****";
    self.year.textColor = [UIColor colorWithHex:@"333333" andAlpha:1.0];
    self.year.font = [UIFont systemFontOfSize:12];
    [self.headerImageView addSubview:self.year];
    
    self.month = [[UILabel alloc]initWithFrame:CGRectMake(234*RATIO, 149*RATIO, 30*RATIO, 26*RATIO)];
    self.month.text = @"**";
    self.month.textColor = [UIColor colorWithHex:@"333333" andAlpha:1.0];
    self.month.font = [UIFont systemFontOfSize:12];
    [self.headerImageView addSubview:self.month];
    
    self.account = [[UILabel alloc]initWithFrame:CGRectMake(80*RATIO, 180*RATIO, 292*RATIO, 26*RATIO)];
    self.account.text = @"621756  88888888888888";
    self.account.textColor = [UIColor colorWithHex:@"333333" andAlpha:1.0];
    self.account.font = [UIFont systemFontOfSize:21*RATIO];
    [self.headerImageView addSubview:self.account];
    
    self.authentication = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic-金融已认证"]];
    self.authentication.frame = CGRectMake((375-75)*RATIO, 137*RATIO, 48*RATIO, 48*RATIO);
    [self.headerImageView addSubview:self.authentication];
    
    self.bankSearveNum = [[UILabel alloc]initWithFrame:CGRectMake(145*RATIO, 225.8*RATIO, 75*RATIO, 10*RATIO)];
    self.bankSearveNum.text = @"交通银行 95559";
    self.bankSearveNum.textColor = RGBColor(20, 20, 20);
    self.bankSearveNum.font = [UIFont boldSystemFontOfSize:7*RATIO];
    [self.headerImageView addSubview:self.bankSearveNum];
    
    
    
    
}

- (void)initDic{
    NSDictionary * dic01 = @{@"icon":@"icon-基本信息",
                             @"title":@"基本信息",
                             @"account":@"",
                             @"time":@"",
                             @"account01":@"",
                             @"account02":@""};
    NSDictionary * dic02 = @{@"icon":@"icon-参保信息",
                             @"title":@"参保信息",
                             @"account":@"",
                             @"time":@"",
                             @"account01":@"",
                             @"account02":@""};
    NSDictionary * dic03 = @{@"icon":@"icon-养老保险",
                             @"title":@"养老保险",
                             @"account":@"3265",
                             @"time":@"2016/07应缴",
                             @"account01":@"",
                             @"account02":@""};
    NSDictionary * dic04 = @{@"icon":@"icon-医疗保险",
                             @"title":@"医疗保险",
                             @"account":@"10",
                             @"time":@"2016/07应缴",
                             @"account01":@"",
                             @"account02":@""};
    NSDictionary * dic05 = @{@"icon":@"icon-工伤保险",
                             @"title":@"工伤保险",
                             @"account":@"20",
                             @"time":@"2016/07应缴",
                             @"account01":@"",
                             @"account02":@""};
    NSDictionary * dic06 = @{@"icon":@"icon-失业保险",
                             @"title":@"失业保险",
                             @"account":@"30",
                             @"time":@"2016/07应缴",
                             @"account01":@"",
                             @"account02":@""};
    NSDictionary * dic07 = @{@"icon":@"icon-生育保险",
                             @"title":@"生育保险",
                             @"account":@"40",
                             @"time":@"2016/07应缴",
                             @"account01":@"",
                             @"account02":@""};
    NSDictionary * dic08 = @{@"icon":@"icon-求职招聘",
                             @"title":@"求职招聘",
                             @"account":@"",
                             @"time":@"",
                             @"account01":@"",
                             @"account02":@""};
    NSDictionary * dic09 = @{@"icon":@"icon-考试培训",
                             @"title":@"考试培训",
                             @"account":@"",
                             @"time":@"",
                             @"account01":@"",
                             @"account02":@""};
    self.itemDataArr = [[NSMutableArray alloc]initWithObjects:dic01, dic02, dic03, dic04, dic05, dic06, dic07, dic08, dic09, nil];
    
    
    NSDictionary * dic11 = @{@"title":@"性别",
                             @"subTitle":@"女"};
    NSDictionary * dic12 = @{@"title":@"出生日期",
                             @"subTitle":@"1956年5月4日"};
    NSDictionary * dic13 = @{@"title":@"国籍",
                             @"subTitle":@"中国"};
    NSDictionary * dic14 = @{@"title":@"民族",
                             @"subTitle":@"汉族"};
    NSDictionary * dic15 = @{@"title":@"电话",
                             @"subTitle":@"12345678901"};
    NSDictionary * dic16 = @{@"title":@"家庭住址",
                             @"subTitle":@"镇江市"};
    self.sectionOneArr = [[NSMutableArray alloc]initWithObjects:dic11,dic12,dic13,dic14,dic15,dic16, nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    if (section>=0) return YES;
    
    return NO;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self tableView:tableView canCollapseSection:section])
    {
        if ([_expandedSections containsIndex:section])
        {
            if (section == 0){
                return 7;
            }
                
            return 6; // return rows when expanded
        }
        
        return 1; // only top row showing
    }
    
    // Return the number of rows in the section.
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        if (!indexPath.row)
        {
           
            
//            if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 7 || indexPath.section == 8){
//                static NSString *ID = @"cell01";
//                ZJBIOneViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
//                [cell setCellData:[_itemDataArr objectAtIndex:indexPath.section]];
//                [self setArrow:cell didSelectRowAtIndexPath:indexPath];
//                return cell;
//            }else{
                static NSString *CellIdentifier = @"cell02";
                ZJBITwoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                [cell setCellData:[_itemDataArr objectAtIndex:indexPath.section]];

                [self setArrow:cell didSelectRowAtIndexPath:indexPath];
                return cell;
//            }
            
        }
        else
        {
            if (indexPath.section == 0) {
                static NSString *ID = @"sectionOne";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
                }
                cell.textLabel.text = [[self.sectionOneArr objectAtIndex:indexPath.row-1]objectForKey:@"title"];
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.detailTextLabel.text =  [[self.sectionOneArr objectAtIndex:indexPath.row-1]objectForKey:@"subTitle"];
                cell.textLabel.textColor = HEXRGBCOLOR(0x2877aa);
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                return cell;
            }
            if (indexPath.section == 1){
                ZJDetailTableViewCell * cell = [ZJDetailTableViewCell cellWithTableView:tableView];
                if (indexPath.row == 1) {
                    cell.firstLabel.textColor = HEXRGBCOLOR(0x2877aa);
                    cell.secondLabel.textColor = HEXRGBCOLOR(0x2877aa);
                    cell.thirdLabel.textColor = HEXRGBCOLOR(0x2877aa);
                    cell.fourthLabel.textColor = HEXRGBCOLOR(0x2877aa);
                }
                if (indexPath.row > 1) {
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                }
                return cell;
                
            }
           
            static NSString *CellIdentifier = @"Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell.textLabel.text = [NSString stringWithFormat:@"Sub Row %ld",(long)indexPath.row];
            cell.accessoryView = nil;
            return cell;
            
            

        }

}
- (void)setArrow:(UITableViewCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_expandedSections containsIndex:indexPath.section])
    {
        cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeUp];
    }
    else
    {
        cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeDown];
    }

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)// 点击section
        {
            // only first row toggles exapand/collapse
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            NSInteger section = indexPath.section;
            BOOL currentlyExpanded = [_expandedSections containsIndex:section];
            NSInteger rows;
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            if (currentlyExpanded)
            {
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [_expandedSections removeIndex:section];
                
            }
            else
            {
                [_expandedSections addIndex:section];
                rows = [self tableView:tableView numberOfRowsInSection:section];
            }
            
            for (int i=1; i<rows; i++)
            {
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i
                                                               inSection:section];
                [tmpArray addObject:tmpIndexPath];
            }
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (currentlyExpanded)
            {
                [tableView deleteRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                
                cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeDown];
                
            }
            else
            {
                [tableView insertRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                cell.accessoryView =  [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeUp];
                
            }
        }
        else {
            NSLog(@"Selected Section is %ld and subrow is %ld ",(long)indexPath.section ,(long)indexPath.row);
            
        }
        
    }
    else{
        //        DetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        //        [self.navigationController pushViewController:controller animated:YES];
        
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
@end
