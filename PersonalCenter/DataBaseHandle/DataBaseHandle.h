//
//  DataBaseHandle.h
//  UI17_Sqlite
//
//  Created by dlios on 15/2/3.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "notificationIdInfo.h"

#define notificationdb @"notification.sqlite"

#define notificationTable @"notification"
@interface DataBaseHandle : NSObject

+ (instancetype)shareDataBaseHandleInit;

- (void)openDB;
- (void)createTable;
- (void)insertStudent:(notificationIdInfo *)student;
- (void)updateStudent:(notificationIdInfo *)student number:(NSInteger)number;
- (void)updateStudent:(notificationIdInfo *)student number:(NSInteger)number nameStr:(NSString *)name;
- (void)updateNotificationIdInfo:(notificationIdInfo *)oldnotificationIdInfo  NewNotificationIdInfo:(notificationIdInfo*)newnotificationIdInfo number:(NSInteger)number;
- (BOOL)deleteStudent:(NSInteger)number;

- (NSMutableArray *)selectStudent;

- (void)closeDB;
- (void)DropTable;


@end






