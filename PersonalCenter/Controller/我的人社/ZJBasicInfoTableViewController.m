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
#import "ZJBIThreeViewCell.h"
#import "Masonry.h"
#import "ZJDetailTableViewCell.h"
#import "ZJInsuranceTableViewCell.h"
#import "ZJInsuranceHeaderTableViewCell.h"
#import "ZJHealthVisitHeaderCell.h"
#import "ZJHealthVisitCell.h"
#import "ZJHealthRegistrationCell.h"
#import "ZJHealthRegisterHeaderCell.h"
#import "ZJUnemploymentCell.h"
#import "ZJUnemploymentHeaderCell.h"
#import "GTMBase64.h"
#import "GTMDefines.h"
// 模型
#import "MJExtension.h"
#import "ZJOverview.h"
#import "ZJBasicInfo.h"
#import "ZJInsurance.h"
#import "ZJHealthVisit.h"
#import "ZJHealthRegistration.h"
#import "ZJHealthReimbursement.h"
#import "ZJEndowmentModel.h"
#import "ZJIndustrialModel.h"
#import "ZJBirthModel.h"
#import "ZJRedundancyModel.h"



//#import ""

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
// 模型
@property (strong, nonatomic) ZJOverview *overView;
@property (strong, nonatomic) ZJBasicInfo *basicInfo;
@property (strong, nonatomic) ZJEndowmentModel *endowmentModel;
@property (strong, nonatomic) ZJBirthModel *birthModel;
@property (strong, nonatomic) ZJRedundancyModel *redundancyModel;
@property (strong, nonatomic) ZJIndustrialModel *industrialModel;


// 数组
// 基本信息
@property (nonatomic, copy)NSMutableArray *sectionOneArr;
// 参保信息
@property (strong, nonatomic) NSMutableArray *insuranceArray;
// 医疗保险
@property (strong, nonatomic) NSMutableArray *healthVisitArray;
@property (strong, nonatomic) NSMutableArray *healthRegistrationArray;
@property (strong, nonatomic) NSMutableArray *healthReimbursementArray;
// 养老保险
@property (strong, nonatomic) NSMutableArray *endowementArray;
// 工伤保险
@property (strong, nonatomic) NSMutableArray *industrialArray;
// 失业保险
@property (strong, nonatomic) NSMutableArray *redundancyArray;
// 生育保险
@property (strong, nonatomic) NSMutableArray *birthArray;

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
    [self requestOverview];
    
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
    self.account.text = @"62****  ********888888";
    self.account.textColor = [UIColor colorWithHex:@"333333" andAlpha:1.0];
    self.account.font = [UIFont systemFontOfSize:21*RATIO];
    [self.headerImageView addSubview:self.account];
    
    self.authentication = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic-金融已认证"]];
    self.authentication.frame = CGRectMake((375-75)*RATIO, 137*RATIO, 48*RATIO, 48*RATIO);
    [self.headerImageView addSubview:self.authentication];
    
    self.bankSearveNum = [[UILabel alloc]initWithFrame:CGRectMake(145*RATIO, 225.8*RATIO, 75*RATIO, 10*RATIO)];
    self.bankSearveNum.text = @"合作银行 *****";
    self.bankSearveNum.textColor = RGBColor(20, 20, 20);
    self.bankSearveNum.font = [UIFont boldSystemFontOfSize:7*RATIO];
    [self.headerImageView addSubview:self.bankSearveNum];
    
    
    
    
}

- (void)initDic{
    NSDictionary * dic01 = @{@"icon":@"icon-基本信息",
                             @"title":@"基本信息"};
    NSDictionary * dic02 = @{@"icon":@"icon-参保信息",
                             @"title":@"参保信息"};
    NSDictionary * dic03 = @{@"icon":@"icon-医疗保险",
                             @"title":@"医疗保险"};
    NSDictionary * dic04 = @{@"icon":@"icon-养老保险",
                             @"title":@"养老保险"};
    NSDictionary * dic05 = @{@"icon":@"icon-工伤保险",
                             @"title":@"工伤保险"};
    NSDictionary * dic06 = @{@"icon":@"icon-失业保险",
                             @"title":@"失业保险"};
    NSDictionary * dic07 = @{@"icon":@"icon-生育保险",
                             @"title":@"生育保险"};
    NSDictionary * dic08 = @{@"icon":@"icon-考试培训",
                             @"title":@"考试培训"};
    
    self.itemDataArr = [[NSMutableArray alloc]initWithObjects:dic01, dic02, dic03, dic04, dic05, dic06, dic07, dic08, nil];
    
    
//    NSDictionary * dic11 = @{@"title":@"性别",
//                             @"subTitle":@"女"};
//    NSDictionary * dic12 = @{@"title":@"出生日期",
//                             @"subTitle":@"1956年5月4日"};
//    NSDictionary * dic13 = @{@"title":@"国籍",
//                             @"subTitle":@"中国"};
//    NSDictionary * dic14 = @{@"title":@"民族",
//                             @"subTitle":@"汉族"};
//    NSDictionary * dic15 = @{@"title":@"电话",
//                             @"subTitle":@"12345678901"};
//    NSDictionary * dic16 = @{@"title":@"家庭住址",
//                             @"subTitle":@"镇江市"};
//    self.sectionOneArr = [[NSMutableArray alloc]initWithObjects:dic11,dic12,dic13,dic14,dic15,dic16, nil];
    
}

- (void)initBasicInfo{
    NSDictionary * dic11 = @{@"title":@"性别",
                             @"subTitle":self.basicInfo.aac004?self.basicInfo.aac004:@""};
    NSDictionary * dic12 = @{@"title":@"出生日期",
                             @"subTitle":self.basicInfo.aac006?self.basicInfo.aac006:@""};
    NSDictionary * dic13 = @{@"title":@"国籍",
                             @"subTitle":self.basicInfo.aac163?self.basicInfo.aac163:@""};
    NSDictionary * dic14 = @{@"title":@"民族",
                             @"subTitle":self.basicInfo.aac005?self.basicInfo.aac005:@""};
    NSDictionary * dic15 = @{@"title":@"电话",
                             @"subTitle":self.basicInfo.aae005?self.basicInfo.aae005:@""};
    NSDictionary * dic16 = @{@"title":@"家庭住址",
                             @"subTitle":self.basicInfo.aae006?self.basicInfo.aae006:@""};
    self.sectionOneArr = [[NSMutableArray alloc]initWithObjects:dic11,dic12,dic13,dic14,dic15,dic16, nil];
}

- (void)initEndowement{
    //aae140	养老保险类型
    //aac063	待遇享受类型
    //aae044	退休时所在单位或街道村组
    //bac180	退休时间或待遇享受开始年月
    //aae019	享受定期待遇金额
    NSDictionary * dic41 = @{@"title":@"养老保险类型",
                             @"subTitle":self.endowmentModel.aae140?self.endowmentModel.aae140:@""};
    NSDictionary * dic42 = @{@"title":@"待遇享受类型",
                             @"subTitle":self.endowmentModel.aac063?self.endowmentModel.aac063:@""};
    NSDictionary * dic43 = @{@"title":@"退休时所在单位或街道村组",
                             @"subTitle":self.endowmentModel.aae044?self.endowmentModel.aae044:@""};
    NSDictionary * dic44 = @{@"title":@"退休时间或待遇享受开始年月",
                             @"subTitle":self.endowmentModel.bac180?self.endowmentModel.bac180:@""};
    NSDictionary * dic45 = @{@"title":@"享受定期待遇金额",
                             @"subTitle":self.endowmentModel.aae019?self.endowmentModel.aae019:@""};
    self.endowementArray = [[NSMutableArray alloc]initWithObjects:dic41,dic42,dic43,dic44,dic45,nil];

}

// 工伤保险数据源
- (void)initIndustrial{
//    ext001	定期伤残津贴
//    ext002	定期护理费
//    aae044	最近一次发生工伤所在单位
//    ext003	最近一次医疗报销费金额
//    ext004	最近一次领取伤残补助金金额
    NSDictionary * dic51 = @{@"title":@"定期伤残津贴",
                             @"subTitle":self.industrialModel.ext001?self.industrialModel.ext001:@""};
    NSDictionary * dic52 = @{@"title":@"定期护理费",
                             @"subTitle":self.industrialModel.ext002?self.industrialModel.ext002:@""};
    NSDictionary * dic53 = @{@"title":@"最近一次发生工伤所在单位",
                             @"subTitle":self.industrialModel.aae044?self.industrialModel.aae044:@""};
    NSDictionary * dic54 = @{@"title":@"最近一次医疗报销费金额",
                             @"subTitle":self.industrialModel.ext003?self.industrialModel.ext003:@""};
    NSDictionary * dic55 = @{@"title":@"最近一次领取伤残补助金金额",
                             @"subTitle":self.industrialModel.ext004?self.industrialModel.ext004:@""};
    self.industrialArray = [[NSMutableArray alloc]initWithObjects:dic51,dic52,dic53,dic54,dic55, nil];
    
}
- (void)initBirth{
    
//    aae044	参保单位名称
//    amc026	生育类别
//    amc020	生育日期
//    akb021	生育所在医院名称
//    bmc013	生育医疗费
//    amc030	生育津贴
//    bme008	产前检查费
//    bmc014	一次性营养费
    NSDictionary * dic71 = @{@"title":@"参保单位名称",
                             @"subTitle":self.birthModel.aae044?self.birthModel.aae044:@""};
    NSDictionary * dic72 = @{@"title":@"生育类别",
                             @"subTitle":self.birthModel.amc026?self.birthModel.amc026:@""};
    NSDictionary * dic73 = @{@"title":@"生育日期",
                             @"subTitle":self.birthModel.amc020?self.birthModel.amc020:@""};
    NSDictionary * dic74 = @{@"title":@"生育所在医院名称",
                             @"subTitle":self.birthModel.akb021?self.birthModel.akb021:@""};
    NSDictionary * dic75 = @{@"title":@"生育医疗费",
                             @"subTitle":self.birthModel.bmc013?self.birthModel.bmc013:@""};
    NSDictionary * dic76 = @{@"title":@"生育津贴",
                             @"subTitle":self.birthModel.amc030?self.birthModel.amc030:@""};
    NSDictionary * dic77 = @{@"title":@"产前检查费",
                             @"subTitle":self.birthModel.bme008?self.birthModel.bme008:@""};
    NSDictionary * dic78 = @{@"title":@"一次性营养费",
                             @"subTitle":self.birthModel.bmc014?self.birthModel.bmc014:@""};
    self.birthArray = [[NSMutableArray alloc]initWithObjects:dic71,dic72,dic73,dic74,dic75,dic76,dic77,dic78,nil];
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
    return 8;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self tableView:tableView canCollapseSection:section])
    {
        if ([_expandedSections containsIndex:section])
        {
            if (section == 0){
                return self.sectionOneArr.count + 1;
            }
            if (section == 1) {
                return self.insuranceArray.count + 2;
            }
            if (section == 2){
                return self.healthVisitArray.count + self.healthRegistrationArray.count + self.healthReimbursementArray.count + 4 + 3;
            }
            if (section == 3) {
                return self.endowementArray.count + 1;
            }
            if (section == 4) {
                return self.industrialArray.count + 1;
            }
            if (section == 5) {
                return self.redundancyArray.count + 2;
            }
            if (section == 6) {
                return self.birthArray.count + 1;
            }
                
            return 1; // return rows when expanded
        }
        
        return 1; // only top row showing
    }
    
    // Return the number of rows in the section.
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (!indexPath.row) //  处理index.section的内容
    {
        // 基本信息  参保信息   考试培训
        if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 7){
            static NSString *ID = @"cell01";
            ZJBIOneViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
            [cell setCellData:[_itemDataArr objectAtIndex:indexPath.section]];
            [self setArrow:cell didSelectRowAtIndexPath:indexPath];
            return cell;
        // 医疗保险
        }else if (indexPath.section == 2){
            static NSString *CellIdentifier = @"cell03";
            ZJBIThreeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            [cell setCellData:[_itemDataArr objectAtIndex:indexPath.section]];
           
            cell.accountOne.text = self.overView.health.bac013;
            cell.accountTwo.text = self.overView.health.bac014;
            
            [self setArrow:cell didSelectRowAtIndexPath:indexPath];
            return cell;
        }
        else{
            static NSString *CellIdentifier = @"cell02";
            ZJBITwoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            [cell setCellData:[_itemDataArr objectAtIndex:indexPath.section]];
            if (indexPath.section == 3) {
                cell.account.text = self.overView.endowment.aae019;
                cell.time.text = @"核定待遇";
            }
            if (indexPath.section == 4){
                cell.account.text = self.overView.industrial.aae019;
                cell.time.text = self.overView.industrial.aae002;
            }
            if (indexPath.section == 5) {
                cell.account.text = self.overView.redundancy.aae019;
                cell.time.text = self.overView.redundancy.aae002;
            }
            if (indexPath.section == 6) {
                cell.account.text = self.overView.birth.bmc019;
                cell.time.text = self.overView.birth.aae002;
            }
            [self setArrow:cell didSelectRowAtIndexPath:indexPath];
            return cell;
        }
        
    }
        else   //  处理index.row的内容
        {
            if (indexPath.section == 0) {
                static NSString *ID = @"sectionOne";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
                }
                cell.textLabel.text = [[self.sectionOneArr objectAtIndex:indexPath.row-1]objectForKey:@"title"];
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.textLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
                cell.textLabel.textColor = HEXRGBCOLOR(0x2877aa);
                
                cell.detailTextLabel.text = [[self.sectionOneArr objectAtIndex:indexPath.row-1]objectForKey:@"subTitle"];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14*RATIO];
                
                
                return cell;
            }
            if (indexPath.section == 1){

                
                if (indexPath.row > 1) {
                    ZJInsuranceTableViewCell *cell = [ZJInsuranceTableViewCell cellWithTableView:tableView];
                    ZJInsurance *model = self.insuranceArray[indexPath.row-2];
                    cell.model = model;
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                    return cell;
                }
                if (indexPath.row == 1) {
                    ZJInsuranceHeaderTableViewCell *cell = [ZJInsuranceHeaderTableViewCell cellWithTableView:tableView];
                  
                    return cell;
                }
                
                
            }
            if (indexPath.section == 2) {
                
                if (indexPath.row == 1 || indexPath.row == self.healthVisitArray.count + 3 || indexPath.row == self.healthVisitArray.count + self.healthReimbursementArray.count + 5) {
                    static NSString *ID = @"healthHeader";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
                    if (!cell) {
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
                    }
                    cell.backgroundColor = [UIColor clearColor];
                    cell.textLabel.textColor = RGBColor(117, 182, 79);
                    cell.textLabel.font = [UIFont systemFontOfSize:14*RATIO];
                    NSArray *arr = @[@"一次就诊信息",@"二次报销信息",@"医保登记信息"];
                    if (indexPath.row == 1) {
                        cell.textLabel.text = arr[0];
                    }
                    if (indexPath.row == self.healthVisitArray.count + 3) {
                        cell.textLabel.text = arr[1];
                    }
                    if (indexPath.row == self.healthVisitArray.count + self.healthReimbursementArray.count + 5) {
                        cell.textLabel.text = arr[2];
                    }
                    return cell;
                    
                    
                }
                // 一次二次蓝色title
                else if(indexPath.row == 2 || indexPath.row == self.healthVisitArray.count + 4){
                    ZJHealthVisitHeaderCell *cell = [ZJHealthVisitHeaderCell cellWithTableView:tableView];
                    return cell;
                    
                }
                // 一次就诊信息请求数据
                else if (indexPath.row > 2 && indexPath.row < self.healthVisitArray.count + 3){
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                    ZJHealthVisitCell *cell = [ZJHealthVisitCell cellWithTableView:tableView];
                    cell.model = self.healthVisitArray[indexPath.row - 3];
                    return cell;
                }
                // 二次报销信息请求数据
                else if (indexPath.row > self.healthVisitArray.count + 4 && indexPath.row < self.healthVisitArray.count + self.healthReimbursementArray.count + 5){
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                    ZJHealthVisitCell *cell = [ZJHealthVisitCell cellWithTableView:tableView];
                    cell.reModel = self.healthReimbursementArray[indexPath.row - self.healthVisitArray.count - 5];
                    return cell;
                    
                }
                // 医保登记蓝色title
                else if (indexPath.row == self.healthVisitArray.count + self.healthReimbursementArray.count + 6){
                    ZJHealthRegisterHeaderCell *cell = [ZJHealthRegisterHeaderCell cellWithTableView:tableView];
                    return cell;
                    
                    
                }
                // 医保登记信息请求数据
                else if(indexPath.row > self.healthVisitArray.count + self.healthReimbursementArray.count + 6 && indexPath.row <= self.healthVisitArray.count + self.healthReimbursementArray.count + self.healthRegistrationArray.count + 6){
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                    ZJHealthRegistrationCell *cell = [ZJHealthRegistrationCell cellWithTableView:tableView];
                    cell.model = self.healthRegistrationArray[indexPath.row - self.healthVisitArray.count - self.healthReimbursementArray.count - 7];
                    return cell;
                    
                    
                    
                }
                else{
                    return nil;
//                    static NSString *ID = @"health";
//                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//                    if (!cell) {
//                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
//                    }
////                    cell.textLabel.text = @"啦啦啦";
//                    return cell;
                }
            }
            // 养老保险数据
            if (indexPath.section == 3) {
                static NSString *ID = @"endownment";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
                }
                cell.textLabel.text = [[self.endowementArray objectAtIndex:indexPath.row-1]objectForKey:@"title"];
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.textLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
                cell.textLabel.textColor = HEXRGBCOLOR(0x2877aa);
                
                cell.detailTextLabel.text = [[self.endowementArray objectAtIndex:indexPath.row-1]objectForKey:@"subTitle"];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14*RATIO];
                
                
                return cell;
            }
            // 工伤保险
            if (indexPath.section == 4) {
                static NSString *ID = @"industrial";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
                }
                cell.textLabel.text = [[self.industrialArray objectAtIndex:indexPath.row-1]objectForKey:@"title"];
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.textLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
                cell.textLabel.textColor = HEXRGBCOLOR(0x2877aa);
                
                cell.detailTextLabel.text = [[self.industrialArray objectAtIndex:indexPath.row-1]objectForKey:@"subTitle"];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14*RATIO];
                
                
                return cell;
                
            }
            // 失业保险数据
            if (indexPath.section == 5) {
                if (indexPath.row > 1) {
                    ZJUnemploymentCell *cell = [ZJUnemploymentCell cellWithTableView:tableView];
//                     *model = self.insuranceArray[indexPath.row-2];
                    ZJRedundancyModel *model = self.redundancyArray[indexPath.row - 2];
                    cell.model = model;
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                    return cell;
                }
                if (indexPath.row == 1) {
                    ZJUnemploymentHeaderCell *cell = [ZJUnemploymentHeaderCell cellWithTableView:tableView];
                    
                    return cell;
                }
                
                
            }
            // 生育保险数据
            if (indexPath.section == 6) {
                static NSString *ID = @"birth";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
                }
                cell.textLabel.text = [[self.birthArray objectAtIndex:indexPath.row-1]objectForKey:@"title"];
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.textLabel.font = [UIFont boldSystemFontOfSize:14*RATIO];
                cell.textLabel.textColor = HEXRGBCOLOR(0x2877aa);
                
                cell.detailTextLabel.text = [[self.birthArray objectAtIndex:indexPath.row-1]objectForKey:@"subTitle"];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14*RATIO];
                
                
                return cell;            }
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
                if (indexPath.section == 0) {
                    NSLog(@"点击请求基本信息");
                    [self requestBasicInfo];
                }
                if (indexPath.section == 1) {
                    [self requestInsurance];
                }
                if (indexPath.section == 2) {
                    [self requsetHealth];
                }
                if (indexPath.section == 3){
                    [self requestEndowment];
                }
                if (indexPath.section == 4) {
                    [self requsetIndustrial];
                }
                if (indexPath.section == 5) {
                    [self requsetRedundancy];
                }
                if (indexPath.section == 6) {
                    [self requsetBirth];
                }
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.row == 1 || indexPath.row == self.healthVisitArray.count + 3 || indexPath.row == self.healthVisitArray.count + self.healthReimbursementArray.count + 5) {
            return 30;
        }else{
            return tableView.rowHeight;
        }
    }else{
        return tableView.rowHeight;
    }
    
}

#pragma mark - 请求概览
- (void)requestOverview{
    
    
////    
//    NSDictionary *dic = @{
//        @"card":@{
//            @"aac003": @"吴向东",
//            @"aae135": @"321102196808261010",
//            @"baz805": @"JSL000012698",
//            @"bac200": @"BAC200" //base64字符串不做示例
//        },
//        @"health":@{
//            @"bac013":@"100971.16",
//            @"bac014":@"0"
//        },
//        @"endowment": @{
//            @"aae019": @"1018.20"
//        },
//        @"industrial":@{
//            @"aae002": @"2016年09月",
//            @"aae019": @"1.00"
//        },
//        @"redundancy":@{
//            @"aae002": @"2016年11月",
//            @"aae019": @"1496.38"
//        },
//        @"birth":@{
//            @"aae002": @"2016年08月",
//            @"bmc019": @"10920.42"
//        }
//        };
//    NSLog(@"dic：%@",dic);
//    ZJOverview *overView = [ZJOverview mj_objectWithKeyValues:dic];
//    self.overView = overView;
//    
////    NSLog(@"name:%@",overView.card.aac003);
//    self.name.text = overView.card.aac003;
//    self.number.text = overView.card.aae135;
//    self.identifierNumber.text = overView.card.baz805;
//    [self.tableView reloadData];
//    NSLog(@"card:%@",overView.card);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;

    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(OVERVIEW) params:params controller:self success:^(id responseObject) {
        NSLog(@"overView---%@",responseObject);
        if (!responseObject[@"code"]) {
            ZJOverview *overView = [ZJOverview mj_objectWithKeyValues:responseObject];
            self.overView = overView;
            self.name.text = overView.card.aac003;
            self.number.text = overView.card.aae135;
            self.identifierNumber.text = overView.card.baz805;
            
            NSData *dateimage = [[NSData alloc]initWithBase64EncodedString: overView.card.bac200 options:NSDataBase64DecodingIgnoreUnknownCharacters];

            

            if (![NSString isBlankString:overView.card.bac200]) {
                self.avatar.image = [UIImage imageWithData:dateimage];

            }else{
//                self.avatar.image = [UIImage imageNamed:@"pic-tx"];
            }

            [self.tableView reloadData];
        }
        
    } failure:^(id error) {
        
    }];

    


}

#pragma mark - 请求基本信息
- (void)requestBasicInfo{
    
 
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;
    

    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(BASE) params:params controller:self success:^(id responseObject) {
        NSLog(@"基本信息---%@",responseObject);
        if (!responseObject[@"code"]) {
            ZJBasicInfo *basicInfo = [ZJBasicInfo mj_objectWithKeyValues:responseObject];
            self.basicInfo = basicInfo;
            [self initBasicInfo];
            [self.tableView reloadData];
        }
        
    } failure:^(id error) {
        
    }];
    

}

#pragma mark - 请求参保信息
- (void)requestInsurance{

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(INSURANCE) params:params controller:self success:^(id responseObject) {
        NSLog(@"参保信息---%@",responseObject);
        if (!responseObject[@"code"]) {
           
            self.insuranceArray = [[NSMutableArray alloc]init];
            for (NSDictionary *dict in responseObject[@"list"]) {
                ZJInsurance *insurance = [ZJInsurance mj_objectWithKeyValues:dict];
                [self.insuranceArray addObject:insurance];
                
            }
            [self.tableView reloadData];

        }
        
    } failure:^(id error) {
        
    }];
}

- (void)requsetHealth{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(HEALTH) params:params controller:self success:^(id responseObject) {
        NSLog(@"医疗保险：----%@",responseObject);
        if (!responseObject[@"code"]) {
            _healthVisitArray = [[NSMutableArray alloc]init];
            _healthRegistrationArray = [[NSMutableArray alloc]init];
            _healthReimbursementArray = [[NSMutableArray alloc]init];
            
            for (NSDictionary *dict in responseObject[@"visit"]) {
                ZJHealthVisit *healthVisit = [ZJHealthVisit mj_objectWithKeyValues:dict];
                [_healthVisitArray addObject:healthVisit];
            }
            for (NSDictionary *dict in responseObject[@"reimbursement"]) {
                ZJHealthReimbursement *healthReimbursement = [ZJHealthReimbursement mj_objectWithKeyValues:dict];
                [_healthReimbursementArray addObject:healthReimbursement];
            }
            for (NSDictionary *dict in responseObject[@"registration"]) {
                ZJHealthRegistration *healthRegistraion = [ZJHealthRegistration mj_objectWithKeyValues:dict];
                [_healthRegistrationArray addObject:healthRegistraion];
            }
            [self.tableView reloadData];

        }
    } failure:^(id error) {
        
    }];
}

#pragma mark - 请求养老保险
- (void)requestEndowment{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(ENDOWMENT) params:params controller:self success:^(id responseObject) {
        NSLog(@"养老保险--------%@",responseObject);
        if (!responseObject[@"code"]) {
            ZJEndowmentModel *model = [ZJEndowmentModel mj_objectWithKeyValues:responseObject[@"treatment"]];
            self.endowmentModel  = model;
            [self initEndowement];
            [self.tableView reloadData];
        }
        
    } failure:^(id error) {
        
    }];
}

#pragma mark - 请求工伤保险
- (void)requsetIndustrial{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(INDUSTRIAL) params:params controller:self success:^(id responseObject) {
        NSLog(@"工伤保险----%@",responseObject);
        if (!responseObject[@"code"]) {
        ZJIndustrialModel *model = [ZJIndustrialModel mj_objectWithKeyValues:responseObject];
            self.industrialModel = model;
            [self initIndustrial];
            [self.tableView reloadData];
        
        }
        
    } failure:^(id error) {
        
    }];
}

#pragma mark - 请求失业保险
- (void)requsetRedundancy{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(REDUNDANCY) params:params controller:self success:^(id responseObject) {
        NSLog(@"失业保险----%@",responseObject);
        if (!responseObject[@"code"]) {
            
            
            self.redundancyArray = [[NSMutableArray alloc]init];
            for (NSDictionary *dict in responseObject[@"list"]) {
                ZJRedundancyModel *model = [ZJRedundancyModel mj_objectWithKeyValues:dict];
                [self.redundancyArray addObject:model];
                
            }
            [self.tableView reloadData];
        }
        
    } failure:^(id error) {
        
    }];

    
}
#pragma mark - 请求生育保险
- (void)requsetBirth{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(BIRTH) params:params controller:self success:^(id responseObject) {
        NSLog(@"生育保险----%@",responseObject);
        if (!responseObject[@"code"]) {
            ZJBirthModel *model = [ZJBirthModel mj_objectWithKeyValues:responseObject];
            self.birthModel = model;
            [self initBirth];
            [self.tableView reloadData];
            //            ZJIndustrialModel *model = [ZJIndustrialModel mj_objectWithKeyValues:responseObject[@""]];
        }
        
    } failure:^(id error) {
        
    }];
}
@end

// health
//{
    //    {
    //        “account”： {
    //            “bac013”：“971.16”，
    //            “bac014”: “0”
    //        }，
    //        “visit”： [{
    //            “akb021”：“镇江市第二人民医院”，
    //            “akc194”	: “2016年07月27日”，
    //            “aka078” : “门(急)诊”，
    //            “akc264” : “142.78”
    //        }，
    //                  //可能有多条数据
    //                  ]，
    //        “reimbursement”： [{
    //            “akb021”：“结算中心”，
    //            “ake058”	: “2016年04月12日 10时47分59秒”，
    //            “bkc106” : “特报”，
    //            “bae039” : “135.20”
    //        }，
    //                          //可能有多条数据
    //                          ] ，
    //        “registration”： [{
    //            “aka083”：AKA083，
    //            “akb021”	: AKB021，
    //            “aae030” : AAE030，
    //            “aae031” : AAE031，
    //            “aae100”：
    //        }，
    //    //可能有多条数据
    //    ]
    //    }
    //
    //    NSDictionary *dic = @{
    //                          @"account":@{
    //                              @"bac013":@"971.16",
    //                              @"bac014":@"0"
    //                          },
    //                          @"visit":@[@{
    //                                       @"akb021":@"镇江市第二人民医院",
    //                                       @"akc194":@"2016年07月27日",
    //                                       @"aka078":@"门(急)诊",
    //                                       @"akc264":@"142.78"
    //                                       },
    //                                     @{
    //                                         @"akb021":@"镇江市第二人民医院",
    //                                         @"akc194":@"2016年07月27日",
    //                                         @"aka078":@"门(急)诊",
    //                                         @"akc264":@"142.78"
    //                                         }],
    //                          @"reimbursement": @[@{
    //                                          @"akb021":@"结算中心",
    //                                          @"ake058":@"2016年04月12日 10时47分59秒",
    //                                          @"bkc106":@"特报",
    //                                          @"bae039":@"135.20"
    //                                      }],
    //                          @"registration": @[@{
    //                                          @"aka083":@"AKA083",
    //                                          @"akb021":@"AKB021",
    //                                          @"aae030":@"AAE030",
    //                                          @"aae031":@"AAE031",
    //                                          @"aae100":@"AAE100"
    //                                      }
    //                                  //可能有多条数据
    //                                  ]
    //
    //                          };
    //    _healthVisitArray = [[NSMutableArray alloc]init];
    //    _healthRegistrationArray = [[NSMutableArray alloc]init];
    //    _healthReimbursementArray = [[NSMutableArray alloc]init];
    //
    //    for (NSDictionary *dict in dic[@"visit"]) {
    //        ZJHealthVisit *healthVisit = [ZJHealthVisit mj_objectWithKeyValues:dict];
    //        [_healthVisitArray addObject:healthVisit];
    //    }
    //    for (NSDictionary *dict in dic[@"reimbursement"]) {
    //        ZJHealthReimbursement *healthReimbursement = [ZJHealthReimbursement mj_objectWithKeyValues:dict];
    //        [_healthReimbursementArray addObject:healthReimbursement];
    //    }
    //    for (NSDictionary *dict in dic[@"registration"]) {
    //        ZJHealthRegistration *healthRegistraion = [ZJHealthRegistration mj_objectWithKeyValues:dict];
    //        [_healthRegistrationArray addObject:healthRegistraion];
    //    }
    
 
//}
// 参保信息

//    {
//        “list”： [{
//            “aae140”: “企业基本养老保险” ,
//            “aaa042”: “12%”,
//            “aaa041”: “8%”
//        }，
//                 //可能有多条数据
//                 ]
//    }
//    NSDictionary *dic = @{
//                          @"list":@[
//                                  @{
//                                      @"aae140":@"企业基本养老保险",
//                                      @"aaa042":@"12%",
//                                      @"aaa041":@"8%"
//                                      },
//                                  @{
//                                      @"aae140":@"失业保险",
//                                      @"aaa042":@"12%",
//                                      @"aaa041":@"8%"
//                                      },
//                                  @{
//                                      @"aae140":@"统战结合医疗保险",
//                                      @"aaa042":@"12%",
//                                      @"aaa041":@"8%"
//                                      }
//                                  ]
//                          };
//    self.insuranceArray = [[NSMutableArray alloc]init];
//    for (NSDictionary *dict in dic[@"list"]) {
//        ZJInsurance *insurance = [ZJInsurance mj_objectWithKeyValues:dict];
//        [self.insuranceArray addObject:insurance];
//
//    }
//    [self.tableView reloadData];


////    {
////        “aac004”: “男”，
////        “aac006”: “1968年08月26日”，
////        “aac163”: “中国”，
////        “aac005”: “汉族”，
////        “aae005”: “85238920”，
////        “aae006”: “镇江市中山东路381号中山石化办公室”
////    }
//
//    NSDictionary *dic = @{
//                          @"aac004":@"男",
//                          @"aac006":@"1968年08月26日",
//                          @"aac163":@"中国",
//                          @"aac005":@"汉族",
//                          @"aae005":@"85238920",
//                          @"aae006":@"镇江市中山东路381号中山石化办公室"
//                          };
//    ZJBasicInfo *basicInfo = [ZJBasicInfo mj_objectWithKeyValues:dic];
//    NSLog(@"basicinfo:%@",basicInfo);
//    self.basicInfo = basicInfo;
//    [self initBasicInfo];
//    [self.tableView reloadData];
