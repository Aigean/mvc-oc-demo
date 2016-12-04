//
//  DataBaseHandle.m
//  UI17_Sqlite
//
//  Created by dlios on 15/2/3.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "DataBaseHandle.h"

@implementation DataBaseHandle

+ (instancetype)shareDataBaseHandleInit
{
    static DataBaseHandle *dataBaseHandle = nil;
    if (dataBaseHandle == nil) {
        
        dataBaseHandle = [[DataBaseHandle alloc] init];
    }
    
    return dataBaseHandle;
}


#pragma mark -- 使用数据库之前 先要往工程里导入库文件libsqlite3.0.dylib文件 然后引入sqlite3.h头文件

#pragma mark -- 打开数据库
//创建一个数据库对象
static sqlite3 *db;

- (void)openDB//自定义封装打开数据库方法
{
    //查询数据库路径的方法
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [array lastObject];
    NSString *sqlitePath = [filePath stringByAppendingPathComponent:notificationdb];
    
    NSLog(@"sqlitePath %@", sqlitePath);
    //打开数据库方法 sqlite3_open
    //参数1 指定数据库存储路径
    //参数2 数据库对象
    //这个方法实际就是将本地存储路径和数据库对象关联到了一起 当你将路径和对象传入方法里 方法就会用当前数据库对象在本地路径生成一个存放数据库表的文件
    if (db != nil) {
        NSLog(@"数据库已经打开");
        return;
    }
    //打开数据库方法
    int result = sqlite3_open(sqlitePath.UTF8String, &db);
    //根据返回值来判断数据库打开是否成功
    if (SQLITE_OK == result) {
        NSLog(@"数据库打开成功");
    } else {
        NSLog(@"数据库打开失败");
    }
    
}

#pragma mark -- 创建数据库表
- (void)createTable
{
    
    /*@property (nonatomic, assign) NSInteger number;
     
     @property (nonatomic, strong) NSData * image;
     @property (nonatomic, strong) NSString * phone;
     @property (nonatomic, strong) NSString * phoneFlag;
     @property (nonatomic, strong) NSString * mail;
     @property (nonatomic, strong) NSString * mailFlag;
     @property (nonatomic, strong) NSString * address;
     @property (nonatomic, strong) NSString *name;
     @property (nonatomic, strong) NSString *idCard;
     @property (nonatomic, strong) NSString *identityFlag;

     */
    
        //生成创建表的Sql语句

    NSString  *createSqlTab = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(number INTEGER PRIMARY KEY AUTOINCREMENT, image TEXT, phone TEXT,phoneFlag TEXT, mail TEXT,mailFlag TEXT,address TEXT,name TEXT,idCard TEXT,identityFlag TEXT)",notificationTable];
//    NSString *createSql = @"CREATE TABLE IF NOT EXISTS lanou25(number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, gender TEXT, age INTEGER)";
    //执行sql语句
    int result = sqlite3_exec(db, createSqlTab.UTF8String, NULL, NULL, nil);
    if (SQLITE_OK == result) {
        NSLog(@" notificationdb 创建表成功");
    } else {
        NSLog(@" notificationdb 创建表失败");
    }

}

#pragma mark -- 往数据库表中插入一个学生

- (void)insertStudent:(notificationIdInfo *)student


{
    
    /*@property (nonatomic, assign) NSInteger number;
     
     @property (nonatomic, strong) NSData * image;
     @property (nonatomic, strong) NSString * phone;
     @property (nonatomic, strong) NSString * phoneFlag;
     @property (nonatomic, strong) NSString * mail;
     @property (nonatomic, strong) NSString * mailFlag;
     @property (nonatomic, strong) NSString * address;
     @property (nonatomic, strong) NSString *name;
     @property (nonatomic, strong) NSString *idCard;
     @property (nonatomic, strong) NSString *identityFlag;
     
     */
    
    //创建插入学生的sql语句
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO notification(image, phone,phoneFlag,mail,mailFlag,address ,name,idCard,identityFlag) VALUES('%@', '%@', '%@','%@','%@', '%@', '%@','%@','%@')",  student.image, student.phone,student.phoneFlag, student.mail, student.mailFlag, student.address,student.name, student.idCard,student.identityFlag];
    //执行sql语句
    int result = sqlite3_exec(db, insertSql.UTF8String, NULL, NULL, nil);
    if (SQLITE_OK == result) {
        NSLog(@"插入表成功");
    } else {
        NSLog(@"插入表失败");
    }
    
}

#pragma mark -- 更新学生信息
- (void)updateStudent:(notificationIdInfo *)student number:(NSInteger)number
{
    
    
//    1.创建更新学生的sql语句
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET name ='%@', mail = '%@', phone = '%@', address = '%@', phoneFlag = '%@', mailFlag = '%@', identityFlag = '%@', image = '%@' WHERE number = '%ld'",notificationTable, student.name,student.mail,student.phone,student.address,student.phoneFlag,student.mailFlag,student.identityFlag,student.image,number];
    
    NSLog(@"updateSql %@",updateSql);
    //2.执行sql语句
    int result = sqlite3_exec(db, updateSql.UTF8String, NULL, NULL, nil);
    if (SQLITE_OK == result) {
        NSLog(@"更改成功");
    } else {
        NSLog(@"更改失败");
    }
    
}


//- (void)updateNotificationIdInfo:(notificationIdInfo *)oldnotificationIdInfo  NewNotificationIdInfo:(notificationIdInfo*)newnotificationIdInfo number:(NSInteger)number
//{
//    
//    
//    //    1.创建更新学生的sql语句
//    NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET name ='%@' mail = '%@' phone = '%@' address = '%@'  WHERE number = '%ld'",notificationTable, newnotificationIdInfo.name,newnotificationIdInfo.phone,ne];
//    
//    NSLog(@"updateSql %@",updateSql);
//    //2.执行sql语句
//    int result = sqlite3_exec(db, updateSql.UTF8String, NULL, NULL, nil);
//    if (SQLITE_OK == result) {
//        NSLog(@"更改成功");
//    } else {
//        NSLog(@"更改失败");
//    }
//    
//}

#pragma mark -- 删除一个学生
- (BOOL)deleteStudent:(NSInteger)number
{
    
    BOOL  isDelete = NO;;
    
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE number = '%ld'",notificationTable, (long)number];
    //执行
    int result = sqlite3_exec(db, deleteSql.UTF8String, NULL, NULL, nil);
    if (SQLITE_OK == result) {
        NSLog(@"删除成功");
        isDelete = YES;
    } else {
        isDelete = NO;

        NSLog(@"删除失败");
    }
    
    return isDelete;
    
}

#pragma mark -- 查询所有学生信息
- (NSMutableArray *)selectStudent
{
    //方法的逻辑就是
    //1 先从本地数据库中取出所有数据
    //2 将取出的每条数值 赋值给model属性
    //3 最终model对象存入数组中 返回给需要的类
    
    NSString *selectSql = [NSString stringWithFormat: @"SELECT * FROM %@",notificationTable];
    //查询前的准备工作
    //参数1 数据库对象
    //参数2 查询语句
    //参数3 查新语句字数限制 -1为不限制
    //参数4 数据库跟随指针对象
    //参数5 nil
    //创建数据库跟随指针 用来遍历数据库表中得每行数据
    sqlite3_stmt *stmt = nil;
    //sqlite3_prepare_v2其实就是将数据库对象 sql语句 跟随指针三者关联到一起 来共同完成查询操作
    int result = sqlite3_prepare_v2(db, selectSql.UTF8String, -1, &stmt, nil);
    //创建存放学生对象的大数组
    NSMutableArray *array = [NSMutableArray array];
    
    if (SQLITE_OK == result) {
        NSLog(@"查询准备成功");
        //开始循环遍历查询数据库每一行
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //当跟随指针指向的行的数据符合你得查询条件 就在while里返回
            //逐列取出每列的数据
            int number = sqlite3_column_int(stmt, 0);
            const unsigned char *image = sqlite3_column_text(stmt, 1);
//            const unsigned char *notificationContent = sqlite3_column_text(stmt, 2);
            const unsigned char * phone = sqlite3_column_text(stmt, 2);
            const unsigned char * phoneFlag = sqlite3_column_text(stmt, 3);
            const unsigned char * mail = sqlite3_column_text(stmt, 4);
            const unsigned char * mailFlag = sqlite3_column_text(stmt, 5);
            const unsigned char * address = sqlite3_column_text(stmt, 6);
            const unsigned char * name = sqlite3_column_text(stmt, 7);
            const unsigned char * idCard = sqlite3_column_text(stmt, 8);
            const unsigned char * identityFlag = sqlite3_column_text(stmt, 9);
     

            
            /*@property (nonatomic, assign) NSInteger number;
             
             @property (nonatomic, strong) NSData * image;
             @property (nonatomic, strong) NSString * phone;
             @property (nonatomic, strong) NSString * phoneFlag;
             @property (nonatomic, strong) NSString * mail;
             @property (nonatomic, strong) NSString * mailFlag;
             @property (nonatomic, strong) NSString * address;
             @property (nonatomic, strong) NSString *name;
             @property (nonatomic, strong) NSString *idCard;
             @property (nonatomic, strong) NSString *identityFlag;
             
             */
            NSUInteger number1 = number;
            
            NSString *image1 = [NSString stringWithUTF8String:(const char *)image];

            NSString *phone1 = [NSString stringWithUTF8String:(const char *)phone];
            
            NSString *phoneFlag1 = [NSString stringWithUTF8String:(const char *)phoneFlag];

            NSString *mail1 = [NSString stringWithUTF8String:(const char *)mail];
            NSString *mailFlag1 = [NSString stringWithUTF8String:(const char *)mailFlag];
            NSString *address1 = [NSString stringWithUTF8String:(const char *)address];
            NSString *name1 = [NSString stringWithUTF8String:(const char *)name];
            NSString *idCard1 = [NSString stringWithUTF8String:(const char *)idCard];
            NSString *identityFlag1 = [NSString stringWithUTF8String:(const char *)identityFlag];

            
            
            
            notificationIdInfo *stu = [[notificationIdInfo alloc] init];
            stu.number= number1;
            stu.image = image1;
            stu.phone = phone1;
            stu.phoneFlag = phoneFlag1;
            stu.mail= mail1;
            stu.mailFlag = mailFlag1;
            stu.address = address1;
            stu.name = name1;
            stu.idCard =idCard1;
            stu.identityFlag = identityFlag1;
            
            [array addObject:stu];
            
        }
        
    } else {
        NSLog(@"查询失败");
    }
    
    return array;
    
}

-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}
#pragma mark -- 关闭数据库 查询后就会失败
- (void)closeDB
{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"关闭数据库成功");
        db = nil;
    } else {
        NSLog(@"关闭数据库失败");
    }
}

#pragma mark -- 清空数据库表
- (void)DropTable
{
    NSString *dropSql = [NSString stringWithFormat:@"DROP TABLE %@",notificationTable];
    int result = sqlite3_exec(db, dropSql.UTF8String, NULL, NULL, nil);
    if (SQLITE_OK == result) {
        NSLog(@"清除表成功");
    } else {
        NSLog(@"清除表失败");
    }
    
    
}

@end























