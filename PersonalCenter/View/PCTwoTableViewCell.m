//
//  PCTwoTableViewCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/22.
//  Copyright © 2016年 Aigean. All rights reserved.
//
#import <objc/message.h>

#import "PCTwoTableViewCell.h"
#import "FirstViewController.h"
#import "LBXScanViewStyle.h"
#import "SubLBXScanViewController.h"
#import "PCTwoCollectionViewCell.h"
#import "ZJAuthenticationViewController.h"
#import "ZJPasswordManageViewController.h"
#import "ZJMessageNotificationViewController.h"
@interface PCTwoTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UINavigationBarDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PCTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initCell];
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
    static NSString *ID = @"PCCellTwo";
    PCTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[PCTwoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    return cell;
}

- (void)initCell{
    
    NSDictionary  * dic01 = @{
                              @"name":@"消息通知",
                              @"image":@"but-消息通知"};
    NSDictionary  * dic02 = @{
                              @"name":@"在线咨询",
                              @"image":@"but-在线咨询"};
    
    NSDictionary  * dic03 = @{
                              @"name":@"密码管理",
                              @"image":@"but-密码管理"};
    
    NSDictionary  * dic04 = @{
                              @"name":@"账户认证",
                              @"image":@"but-账户认证"};
    
    NSDictionary  * dic05   = @{
                                @"name":@"使用帮助",
                                @"image":@"but-使用帮助"};
    
    NSDictionary  * dic06   = @{
                                @"name":@"扫一扫",
                                @"image":@"but-扫一扫"};
    
    NSDictionary  * dic07   = @{
                                @"name":@"拨打12333",
                                @"image":@"but-拨打12333"};
    
    NSDictionary  * dic08   = @{
                                @"name":@"",
                                @"image":@""};
    self.itemDataArr = [[NSMutableArray alloc]initWithObjects:dic01, dic02, dic03, dic04, dic05, dic06, dic07, dic08, nil];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/4 - 0.75, SCREEN_WIDTH*0.24 - 0.75);
    flowLayout.minimumInteritemSpacing = .5;
    flowLayout.minimumLineSpacing = .5;
    
    //    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 88 * 3 + 2) collectionViewLayout:flowLayout];
    [_collectionView setCollectionViewLayout:flowLayout];
    _collectionView.backgroundColor = RGBColor(238, 238, 238);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
  
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
    return 8;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"PCTwoCollectionViewCell";

    PCTwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell setCellData:[_itemDataArr objectAtIndex:indexPath.row]];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ZJMessageNotificationViewController *msg = [[ZJMessageNotificationViewController alloc]init];
        [self.pc2Controller.navigationController pushViewController:msg animated:YES];
    }
    if (indexPath.row == 1) {
        
    }
    if (indexPath.row == 2) {
        ZJPasswordManageViewController * pass = [[ZJPasswordManageViewController alloc]init];
        pass.title = @"密码管理";
        [self.pc2Controller.navigationController pushViewController:pass animated:YES];
    }
    if (indexPath.row == 3) {
        ZJAuthenticationViewController * auth = [[ZJAuthenticationViewController alloc]init];
        [self.pc2Controller.navigationController pushViewController:auth animated:YES];
    }
    if (indexPath.row == 4) {
        
    }
    if (indexPath.row == 5) {
        NSArray * array = @[
                            @[@"模拟qq扫码界面",@"qqStyle"]
                            //                        @[@"模仿支付宝扫码区域",@"ZhiFuBaoStyle"],
                            //                        @[@"模仿微信扫码区域",@"weixinStyle"],
                            //                        @[@"无边框，内嵌4个角",@"InnerStyle"],
                            //                        @[@"4个角在矩形框线上,网格动画",@"OnStyle"],
                            //                        @[@"自定义颜色",@"changeColor"],
                            //                        @[@"只识别框内",@"recoCropRect"],
                            //                        @[@"改变尺寸",@"changeSize"],
                            //                        @[@"条形码效果",@"notSquare"],
                            //                        @[@"二维码/条形码生成",@"myQR"],
                            //                        @[@"相册",@"openLocalPhotoAlbum"]
                            ];
        
        NSString *methodName = [[array lastObject] lastObject];
        
        SEL normalSelector = NSSelectorFromString(methodName);
        if ([self respondsToSelector:normalSelector]) {
            
            ((void (*)(id, SEL))objc_msgSend)(self, normalSelector);
        }

//        FirstViewController * FirstView = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
//        
//        [self.pc2Controller.navigationController pushViewController:FirstView animated:YES];
//        
        

    }
    if (indexPath.row == 6) {
        [self phoneCall];
        
    }
   
}
// 拨打电话
- (void)phoneCall
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"呼叫12333"otherButtonTitles:nil, nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    
    [actionSheet showInView:self.pc2Controller.view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:12333"]]];
    }
}

//UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"您确定要呼叫:%@",phoneNum] preferredStyle:UIAlertControllerStyleAlert];
//UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
//    //    if (!phoneCallWebView ) {
//    //        phoneCallWebView = [[UIWebView alloc]initWithFrame:CGRectZero];//
//    //    }
//    //    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
//    
//    [[UIApplication sharedApplication] openURL:phoneURL];

#pragma mark -模仿qq界面
- (void)qqStyle
{
        //设置扫码区域参数设置
    
        //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.isNeedShowRetangle  =YES;
        //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
        //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
        //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
        //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
        //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
        //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
        //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
        //SubLBXScanViewController继承自LBXScanViewController
        //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [[SubLBXScanViewController alloc] initWithNibName:@"SubLBXScanViewController" bundle:nil];
    vc.style = style;
        //    vc. = strResult.imgScanned;
    
        //    vc.strScan = strResult.strScanned;
    
        //    vc.strCodeType = strResult.strBarCodeType;
    
    
    vc.isQQSimulator = YES;
    
    
    [self.pc2Controller.navigationController pushViewController:vc animated:YES];
}

@end
