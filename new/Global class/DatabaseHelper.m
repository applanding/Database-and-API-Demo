//
//  DatabaseHelper.m
//  TenderApps
//
//  Created by ETL on 02/09/15.
//  Copyright (c) 2015 ETL. All rights reserved.
//

#import "DatabaseHelper.h"

@implementation DatabaseHelper

+ (DatabaseHelper *)sharedInstance
{
    static DatabaseHelper *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
       
        
    });
    return sharedInstance;
}
#pragma mark - Create Methods
-(void)checkAndCreateTables{
    
      
    

        /*-------------CMS_Master Query----------*/
        
        NSString *CMSCreateQuery =  @"CREATE TABLE IF NOT EXISTS CMS_Master"
        @"(id integer PRIMARY KEY AUTOINCREMENT,"
        @"aboutUs text,"
        @"importantNote text,"
        @"contactUs text)";
    
        /*-------------Tender Table Query----------*/
   
        NSString *TenderCreateQuery =  @"CREATE TABLE IF NOT EXISTS Tenders_Master"
        @"(id integer PRIMARY KEY AUTOINCREMENT,"
        @"tid text,"
        @"trid text,"
        @"srNo text,"
        @"tenderValueNumeric double,"
        @"tenderValueText text,"
        @"currency text,"
        @"closingDate text,"
        @"tenderDate text,"
        @"tenderDetail text,"
        @"buyer text,"
        @"subIndustry text,"
        @"companySubIndustry text,"
        @"department text,"
        @"city text,"
        @"state text,"
        @"country text,"
        @"continent text,"
        @"uploadedDate text,"
        @"isFresh bit DEFAULT(0),"
        @"isResultAvailable bit DEFAULT(0),"
        @"isCorrAvailable bit DEFAULT(0),"
        @"isDocAvailable bit DEFAULT(0),"
        @"isPqAvailable bit DEFAULT(0),"
        @"isViewed bit DEFAULT(0),"
        @"isFav bit DEFAULT(0),"
        @"isDelete bit DEFAULT(0),"
        @"custId text DEFAULT(0))";
//todo
    
//    if (![_db columnExists:@"subIndustry" inTableWithName:@"Tenders_Master"])
//    {
//        bool success = [_db executeUpdate:@"ALTER table Tenders_Master ADD COLUMN subIndustry text"];
//        
//            if (success){
//                //  NSLog(@"ALTER tblTenders isDocument created");
//            }
//            else{
//                //   NSLog(@"ALTER tblTenders isDocument failed query=%@",strQuery);
//            }
//    }
    
    
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL success = [db executeStatements:[NSString stringWithFormat:@"%@;%@;",CMSCreateQuery,TenderCreateQuery]];
        if(success){
           // NSLog(@"Table created successfully");
        }else{
           // NSLog(@"Table create failed");
        }
    }];
}
-(NSString *) checkAndCreateDatabase{
    
    NSString  *databasePath =[NSString stringWithFormat:@"%@",[Document_Directory stringByAppendingPathComponent:DB_TenderApps]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:databasePath];
    
    if(success)
    {
        return databasePath;
    }
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_TenderApps];
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    return databasePath;
    
}
#pragma mark - Execution Method
- (void) openDB
{
    @autoreleasepool {
        /* FMDatabase here is used to take the database path */
        _db  = [[FMDatabase alloc] initWithPath:[self checkAndCreateDatabase]];
        _queue = [FMDatabaseQueue databaseQueueWithPath:[self checkAndCreateDatabase]];
        
        //[db setTraceExecution:YES];
        
        /* Here we are opening the datase in order to access it */
        [_db open];
        [_db setLogsErrors:YES];
       
        
    }
}
- (void) closeDB
{
    /* Closing the Database */
    [_db close];
}
-(void)executeQuery:(NSString *)query andCompletionBlock:(void(^)(FMResultSet *fResult))completionBlock
{
  
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *fResult = [db executeQuery:[NSString stringWithFormat:@"%@",query]];
        completionBlock(fResult);
        [fResult close];
       }];
    
    

    
}

#pragma mark - CMS Query
-(void)CreateOrUpdateCMS:(NSString *)aboutus AndImportantNote:(NSString *)imp_note AndContactUs:(NSString *)contact_us andCompletionBlock:(void(^)(BOOL success))completionBlock {
    NSInteger CMSCount = [_db intForQuery:@"SELECT COUNT(*) FROM CMS_Master"];
    if(CMSCount == 0){
        [_queue inDatabase:^(FMDatabase *db) {
            BOOL success = [db executeUpdate:@"INSERT INTO CMS_Master (aboutUs,importantNote,contactUs) VALUES (?,?,?)",aboutus,imp_note,contact_us];
            completionBlock(success);
        }];
    }else{
        [_queue inDatabase:^(FMDatabase *db) {
            BOOL success = [db executeUpdate:@"UPDATE CMS_Master SET aboutUs = ?, importantNote = ?, contactUs = ?",aboutus,imp_note,contact_us];
            completionBlock(success);
        }];
    }
}
#pragma mark - Tender Query
-(void)CreateOrUpdateTenders:(NSMutableArray *)arr_Tenders andCompletionBlock:(void(^)(BOOL success , int newRecordCount))completionBlock {
    __block int newrecord = 0;
    
    if ([arr_Tenders count]>0) {
      
        NSNumber *min=[[arr_Tenders valueForKey:@"srno"] valueForKeyPath:@"@min.intValue"];
        [[NSUserDefaults standardUserDefaults]setInteger:[min intValue] forKey:[NSString stringWithFormat:@"MinSrNoOf%@",User_CustID]];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
   
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (NSMutableArray *dictTender in arr_Tenders){
            NSInteger tenderCount = [db intForQuery:@"SELECT COUNT(id) from Tenders_Master WHERE srNo = ? AND custId = ?",[dictTender valueForKey:@"srno"],User_CustID];
            if (tenderCount == 0) {
                    BOOL success = [db executeUpdate:@"INSERT INTO Tenders_Master (tid,srNo,tenderValueNumeric,tenderValueText,currency,closingDate,tenderDate,tenderDetail,buyer,subIndustry,companySubIndustry,department,city,state,country,continent,uploadedDate,isFresh,isCorrAvailable,isDocAvailable,isPqAvailable,isViewed,custId) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"tid"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"srno"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"tendervaluenumeric"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"tendervalue"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"currency"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"closingdate"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"tenderdate"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"productdetails"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"buyer"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"subindustry"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"companysubindustry"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"department"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"city"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"state"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"country"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"continent"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"uploadeddate"]],
                                    @"1",
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"iscorravailable"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"isotherdocavailable"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"ispqavailable"]],
                                    [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"isviewed"]],
                                    User_CustID];
                    if (success) {
                        newrecord++;
                    }
            }else{
               BOOL success = [db executeUpdate:@"UPDATE Tenders_Master SET tid = ?, tenderValueNumeric = ?, tenderValueText = ?, currency = ?, closingDate = ?, tenderDate = ?, tenderDetail = ?, buyer = ?, subIndustry = ?, companySubIndustry = ?, department = ?, city = ?, state = ?, country = ?, continent = ?, uploadedDate = ?,isFresh = 0, isCorrAvailable = ?, isDocAvailable = ?, isPqAvailable = ?, isViewed = ? WHERE srNo = ? AND custId = ?",
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"tid"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"tendervaluenumeric"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"tendervalue"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"currency"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"closingdate"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"tenderdate"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"productdetails"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"buyer"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"subindustry"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"companysubindustry"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"department"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"city"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"state"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"country"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"continent"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"uploadeddate"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"iscorravailable"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"isotherdocavailable"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"ispqavailable"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"isviewed"]],
                               [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"srno"]],
                               User_CustID];
                    if (!success) {
                        NSLog(@"Error in update Tenders");
                    }
            
            }
            
        }
        
    }];
    completionBlock(YES,newrecord);
}
-(void)DeleteArchives:(void(^)(BOOL success))completionBlockmethod{
    
    [_queue inDatabase:^(FMDatabase *db) {
       BOOL success = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM Tenders_Master WHERE closingDate < DATE('NOW') AND custId = %@ AND isViewed = 0 AND isFav = 0",User_CustID]];
        if(success){
            //NSLog(@"Delete Archive Tender Successfully");
        }else{
            //NSLog(@"Delete Archive Tender Fail");
        }
         completionBlockmethod(success);
    }];
    
}
-(void)LikeTender:(NSString *)str_srNo is_like:(BOOL)is_like andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL success = [db executeUpdate:@"UPDATE Tenders_Master SET isFav = ? WHERE srNo = ? AND custId = ?",(is_like)?@"1":@"0",str_srNo,User_CustID];
        if(success){
            //NSLog(@"Delete Archive Tender Successfully");
        }else{
            //NSLog(@"Delete Archive Tender Fail");
        }
        completionBlockmethod(success);
    }];
    
}
-(void)RemoveTender:(NSString *)str_srNo andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL success = [db executeUpdate:@"UPDATE Tenders_Master SET isDelete = 1 WHERE srNo = ? AND custId = ?",str_srNo,User_CustID];
        if(success){
            //NSLog(@"Delete Archive Tender Successfully");
        }else{
            //NSLog(@"Delete Archive Tender Fail");
        }
        completionBlockmethod(success);
    }];
}
-(void)ViewTender:(NSString *)str_srNo andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL success = [db executeUpdate:@"UPDATE Tenders_Master SET isViewed = 1 WHERE srNo = ? AND custId = ?",str_srNo,User_CustID];
        if(success){
            //NSLog(@"Delete Archive Tender Successfully");
        }else{
            //NSLog(@"Delete Archive Tender Fail");
        }
        completionBlockmethod(success);
    }];
    
}
#pragma mark - Result Query
-(void)UpdateResultForTenders:(NSArray *)arr_Results andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (NSDictionary *dictTender in arr_Results) {
            BOOL success = [db executeUpdate:
                            @"UPDATE Tenders_Master SET isResultAvailable = 1 AND trid = ? WHERE srNo = ? AND custId = ?",
                            [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"trid"]],
                            [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"srno"]],
                            User_CustID];
            if(success){
                NSLog(@"Update Result Tender Successfully");
            }else{
                NSLog(@"Update Result Tender Fail");
            }
        }
        completionBlockmethod(YES);
    }];
}

@end
