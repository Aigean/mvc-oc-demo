//
//  ZJSettingsTableViewController.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/23.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import "ZJSettingsTableViewController.h"
#import "ZJLoginViewController.h"

#define ZJAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]



@interface ZJSettingsTableViewController ()<UITableViewDataSource, UITableViewDelegate>
//@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *itemDataArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ZJSettingsTableViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    return [[UIStoryboard storyboardWithName:@"ZJSetting" bundle:nil] instantiateInitialViewController];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"设置";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

}

- (void)viewDidLoad{
    [super viewDidLoad];
//    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
//    [self.view addSubview:tableView];
//    self.tableView = tableView;
//    [self.tableView registerClass:[UITableViewCell self] forCellReuseIdentifier:ID];
    
    UIButton * logOut = [[UIButton alloc]initWithFrame:CGRectMake(20, 160, SCREEN_WIDTH - 40, 49)];
    [self.tableView addSubview:logOut];
    logOut.backgroundColor = [UIColor colorWithHex:@"35c7fa" andAlpha:1.0];
    [logOut setTitle:@"退出登录" forState:UIControlStateNormal];
    [logOut addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self cellData];
}

- (void)logOut{
    NSLog(@"%@",ZJAccountPath);
    // 清空归档数据
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:ZJAccountPath]) {
        [defaultManager removeItemAtPath:ZJAccountPath error:nil];
    }
    ZJLoginViewController *login = [[ZJLoginViewController alloc]init];
    [self presentViewController:login animated:YES completion:nil];
}
- (void)cellData{
    NSString *chece = [NSString stringWithFormat:@"%.2fM",[self filePath]];
    NSLog(@"----%@",chece);
    
    NSDictionary *dic01 = @{
                            @"icon":@"icon-字体",
                            @"title":@"字体",
                            @"subTitle":@"默认"};
    NSDictionary *dic02 = @{
                            @"icon":@"icon-清空缓存",
                            @"title":@"清空缓存",
                            @"subTitle":chece};
//    NSDictionary *dic03 = @{
//                            @"icon":@"icon-版本检测",
//                            @"title":@"版本检测",
//                            @"subTitle":@"V1.0版本"};
    self.itemDataArr = [[NSMutableArray alloc]initWithObjects:dic01, dic02, nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];

    }
    NSDictionary * dic = [self.itemDataArr objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[dic objectForKey:@"icon"]];
    cell.textLabel.text = [dic objectForKey:@"title"];
    cell.detailTextLabel.text = [dic objectForKey:@"subTitle"];

    return  cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [ZJHudExtension showText:@"功能开发中..." view:self.view];
    }
    if (indexPath.row == 1) {
        [self clearFile];
    }
}
// 显示缓存大小
-( float )filePath
{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    return [ self folderSizeAtPath :cachPath];
    
}
//1:首先我们计算一下 单个文件的大小

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    
    return 0 ;
    
}
//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）

- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    return folderSize/( 1024.0 * 1024.0 );
    
}




// 清理缓存

- (void)clearFile
{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
    NSLog ( @"cachpath = %@" , cachPath);
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            
        }
        
    }
    
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
    
}
-(void)clearCachSuccess
{
    [self cellData];
    NSLog ( @" 清理成功 " );
    [ZJHudExtension showText:@"清理成功" view:self.view];
    
    NSIndexPath *index=[NSIndexPath indexPathForRow:1 inSection:0];//刷新
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
}



@end
