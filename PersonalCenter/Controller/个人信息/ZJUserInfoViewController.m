//
//  ZJUserInfoViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/24.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "ZJUserInfoViewController.h"
#import "ZJModifyNameViewController.h"
#import "ZJModifPhoneNumberViewController.h"
#import "ZJModifyMailViewController.h"
#import "ZJModifyAddressViewController.h"
#import "notificationIdInfo.h"
#import "DataBaseHandle.h"

@interface ZJUserInfoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *staticTableView;

@property(nonatomic,strong)UIActionSheet * actionSheet;
// 相册相机选择的图片


@property (strong, nonatomic) UIImage *pickerImage;



@end

@implementation ZJUserInfoViewController

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    self = [super initWithNibName:nibNameOrNil bundle:nil];
//    return [[UIStoryboard storyboardWithName:@"ZJUserInfo" bundle:nil] instantiateViewControllerWithIdentifier:@"ZJUserInfo"];
//}
- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    return [[UIStoryboard storyboardWithName:@"ZJUserInfo" bundle:nil] instantiateInitialViewController];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"用户信息";
      [self showInfo];
    
    
//    for (notificationIdInfo  * info in aa) {
//        
//        NSLog(@"%@",info.name);
//    }
//    NSString *time = @"20090912";
////    time = [time substringWithRange:NSMakeRange(0, 8)];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setDateFormat:@"yyyyMMdd"];
//    NSDate *date=[formatter dateFromString:time];
//   
//    NSDateFormatter *output = [[NSDateFormatter alloc]init];
//    output = formatter;
//    [output setDateFormat:@"yyyy-MM-dd"];
//   
//     NSString *str = [output stringFromDate:date];
//    NSLog(@"time：%@",date);
//    NSLog(@"time: %@",str);
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.avator.clipsToBounds = YES;
    self.avator.layer.cornerRadius = 14;
  
    
    
    
    // Do any additional setup after loading the view.
}

- (void)showInfo{
    
    // 手机号
    NSMutableArray * arr = [[DataBaseHandle shareDataBaseHandleInit] selectStudent];

    notificationIdInfo *info = [arr lastObject];
//    notificationIdInfo  * info = [arr objectAtIndex:0];
    
    
    
    NSString *phone = info.phone;
    if (phone) {
        phone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else{
        phone = @"";
    }
    self.phoneNumber.text = phone;
    // profile Image
    if (info.image) {
        NSData *imageData = [[NSData alloc]initWithBase64EncodedString:info.image options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.avator.image = [UIImage imageWithData:imageData];
    }else{
        self.avator.image = [UIImage imageNamed:@"pic-tx"];
    }
    

    self.name.text = info.name ?  info.name : @"";
    self.address.text = info.address ?  info.address : @"";
    self.mailAddress.text = info.mail ? info.mail : @"";
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Request
- (void)requst{
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {     // 修改头像
        [self modifyAvatar];
    }
    if (indexPath.row == 1) {     // 修改手机号
        ZJModifPhoneNumberViewController *phoneVC = [[ZJModifPhoneNumberViewController alloc]init];
        phoneVC.title = @"修改手机号";
        // 顺传
        phoneVC.phoneNumber = self.phoneNumber.text;
        // 逆传
        phoneVC.returnPhoneNumberBlock = ^(NSString * showPhoneNumber){
            
            self.phoneNumber.text = [showPhoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        };
        [self.navigationController pushViewController:phoneVC animated:YES];
    }
    if (indexPath.row == 2) {     // 修改邮箱
        ZJModifyMailViewController *emailVC = [[ZJModifyMailViewController alloc]init];
        emailVC.title = @"修改邮箱";
        // 顺传
        emailVC.mail = self.mailAddress.text;
        // 逆传
        emailVC.returnMailBlock = ^(NSString * showMail){
            self.mailAddress.text = showMail;
        };
        [self.navigationController pushViewController:emailVC animated:YES];
    }
    if (indexPath.row == 3) {     // 修改姓名
        ZJModifyNameViewController * nameVC = [[ZJModifyNameViewController alloc]init];
        // 顺传
        nameVC.labname = self.name.text;
        // 逆传
        nameVC.returnNameBlock = ^(NSString *showName){
            self.name.text = showName;
        };
        [self.navigationController pushViewController:nameVC animated:YES];
    }
    if (indexPath.row == 4) {      // 修改地址
        ZJModifyAddressViewController *addressVC = [[ZJModifyAddressViewController alloc]init];
        // 顺传
        addressVC.address = self.address.text;
        // 逆传
        addressVC.returnAddressBlock = ^(NSString *showAddress){
            self.address.text = showAddress;
        };
        [self.navigationController pushViewController:addressVC animated:YES];
    }
    
}

/**
 *  相册选择照片
 */
-(void)modifyAvatar{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil ,nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil ,nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
    
}
#pragma mark  delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;

            } else {
                return;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
       
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.pickerImage = image;
    
    
    [self requestAvatar];
    
}

- (void)requestAvatar{
 
    NSData *data = UIImageJPEGRepresentation(self.pickerImage, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    ZJAccountModel *account = [ZJAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = USERID;
    params[@"photo"] = encodedImageStr;
    
    [[ZYAFNetworking shareZYAFNetworking]PostRequestUrl:DOMAINNAME(MAINTENANCE) params:params controller:self success:^(id responseObject) {
        
       
        NSLog(@"avatar:%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"0000"]) {
            self.avator.image = self.pickerImage;
            
            
            [[DataBaseHandle shareDataBaseHandleInit] openDB];
            NSArray * arr =   [[DataBaseHandle shareDataBaseHandleInit] selectStudent];
            notificationIdInfo *info = [arr lastObject];
            if (arr.count) {
                info.image = encodedImageStr;
                [[DataBaseHandle shareDataBaseHandleInit]updateStudent:info number:info.number];  
            }

            self.returnAvatarBlock(self.avator.image);
            NSLog(@"%@",self.avator.image);
            
            
            
        }
        
    } failure:^(id error) {
        
    }];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];


    
    self.returnFirstNameBlock(self.name.text);
    NSLog(@"%@",self.name.text);
}

@end
