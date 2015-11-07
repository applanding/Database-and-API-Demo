//
//  DatabaseHelper.h
//  TenderApps
//
//  Created by ETL on 02/09/15.
//  Copyright (c) 2015 ETL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDB.h"

@interface DatabaseHelper : NSObject

@property(strong,nonatomic) FMDatabase *db;
@property(strong,nonatomic) FMDatabaseQueue *queue; 
+ (DatabaseHelper *)sharedInstance;
-(void)checkAndCreateTables;
- (void) openDB;
- (void) closeDB;
-(void)executeQuery:(NSString *)query andCompletionBlock:(void(^)(FMResultSet *fResult))completionBlock;

-(void)CreateOrUpdateCMS:(NSString *)aboutus AndImportantNote:(NSString *)imp_note AndContactUs:(NSString *)contact_us andCompletionBlock:(void(^)(BOOL success))completionBlock;

-(void)CreateOrUpdateTenders:(NSMutableArray *)arr_Tenders andCompletionBlock:(void(^)(BOOL success , int newRecordCount))completionBlock;
-(void)DeleteArchives:(void(^)(BOOL success))completionBlockmethod;
-(void)LikeTender:(NSString *)str_srNo is_like:(BOOL)is_like andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)RemoveTender:(NSString *)str_srNo andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)ViewTender:(NSString *)str_srNo andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;

-(void)UpdateResultForTenders:(NSArray *)arr_Results andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
@end
