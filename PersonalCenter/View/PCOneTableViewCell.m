//
//  PCOneTableViewCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/22.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "PCOneTableViewCell.h"
#import "PCOneCollectionViewCell.h"
#import "ZJHandleViewController.h"
#import "ZJUnderHandleViewController.h"
#import "ZJBasicInfoTableViewController.h"
#import "ZJEstimateViewController.h"
#import "WZLBadgeImport.h"
@interface PCOneTableViewCell()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PCOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initCell];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    
    [self initCell];
    return self;
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"PCCellOne";
    PCOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[PCOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    return cell;
}

- (void)initCell{
    NSDictionary *dic01 = @{
                            @"icon":@"but-我的人社",
                            @"title":@"我的人社",
                            @"subTitle":@"查看人社相关信息"};
    NSDictionary *dic02 = @{
                            @"icon":@"but-办理中",
                            @"title":@"办理中",
                            @"subTitle":@"查看正在办理的事项"};
    NSDictionary *dic03 = @{
                            @"icon":@"but-已办业务",
                            @"title":@"已办业务",
                            @"subTitle":@"查看已办理业务"};
    NSDictionary *dic04 = @{
                            @"icon":@"but-用户评价",
                            @"title":@"用户评价",
                            @"subTitle":@"对已办理的事项进行评价"};
    
    self.itemDataArr = [[NSMutableArray alloc]initWithObjects:dic01, dic02, dic03, dic04, nil];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 1) / 2, 90);
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing = 1;
    
//    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 88 * 3 + 2) collectionViewLayout:flowLayout];
    [_collectionView setCollectionViewLayout:flowLayout];
//    _collectionView.bounces = NO;
    _collectionView.scrollEnabled = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor colorWithHex:@"36B2EB" andAlpha:1.0f];
    
//    [self addSubview:_collectionView];
    
    // 加载plist
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SearveCollectionData" ofType:@"plist"];
//    _collectionArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
}

#pragma mark - collectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"PCOneCollectionViewCell";
    
    PCOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    [cell.imageView showBadgeWithStyle:WBadgeStyleNumber value:99 animationType:WBadgeAnimTypeShake];

    cell.backgroundColor = [UIColor colorWithHex:@"229EDA" andAlpha:1.0f];
    [cell setCellData:[_itemDataArr objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ZJBasicInfoTableViewController * basic = [[ZJBasicInfoTableViewController alloc] initWithNibName:@"ZJBasicInfo" bundle:nil];
        [self.pcController.navigationController pushViewController:basic animated:YES];
        
    }else if (indexPath.row == 1) {
        ZJUnderHandleViewController * underHandle = [[ZJUnderHandleViewController alloc]init];
        [self.pcController.navigationController pushViewController:underHandle animated:YES];
        
    }else if (indexPath.row == 2) {
        ZJHandleViewController * handle = [[ZJHandleViewController alloc]init];
        [self.pcController.navigationController pushViewController:handle animated:YES];
    }else{
        ZJEstimateViewController * estimate = [[ZJEstimateViewController alloc]init];
        [self.pcController.navigationController pushViewController:estimate animated:YES];

        
    }
    
}




@end
