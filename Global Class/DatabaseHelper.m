//
//  DatabaseHelper.m
//  TenderTiger
//
//  Created by ETL on 17/11/14.
//  Copyright (c) 2014 ETL. All rights reserved.
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
    
      
    

        /*-------------Tender Query----------*/
        
      NSString *strQuery =  @"CREATE TABLE tblTenders"
        @"(id integer PRIMARY KEY AUTOINCREMENT,"
        @"refno text,"
        @"tenderValue text,"
        @"department text,"
        @"tenderdetail text,"
        @"closingdate text,"
        @"continent text,"
        @"state text,"
        @"country text,"
        @"company text,"
        @"subno text,"
        @"tsrno text,"
        @"city text,"
        @"currency text,"
        @"updatedate text,"
        @"tenderDate text,"
        @"scannedimage text,"
        @"docpath text,"
        @"keyword text,"
        @"isViewed bit DEFAULT(0),"
        @"isFav bit DEFAULT(0),"
        @"isDelete bit DEFAULT(0),"
        @"tenderValueFull text,"
        @"custId text DEFAULT(0),"
        @"isgroup bit DEFAULT(0),"
        @"rowid text,"
        @"IsCorrAvailable bit DEFAULT(0),"
        @"isDocument bit DEFAULT(0),"
        @"isPq bit DEFAULT(0))";
        
        if (![_db tableExists:@"tblTenders"])
        {
            [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
                if (success){
            //    NSLog(@"tblTenders created");
                }
                else{
            //    NSLog(@"tblTenders creation failed query=%@",strQuery);
                }
            }];
        }
    
        /*-------------HotTender Query----------*/
        
        
        strQuery = @"CREATE TABLE IF NOT EXISTS tblHotTenders"
        @"(id integer PRIMARY KEY,"
        @"refno text,"
        @"tenderValue text,"
        @"department text,"
        @"tenderdetail text,"
        @"closingdate text,"
        @"state text,"
        @"continent text,"
        @"country text,"
        @"company text,"
        @"subno text,"
        @"tsrno text,"
        @"city text,"
        @"currency text,"
        @"updatedate text,"
        @"keyword text,"
        @"isViewed bit DEFAULT(0),"
        @"isFav bit DEFAULT(0),"
        @"isDelete bit DEFAULT(0),"
        @"tenderValueFull text,"
        @"tenderDate text,"
        @"custId text,"
        @"IsCorrAvailable bit DEFAULT(0),"
        @"isDocument bit DEFAULT(0),"
        @"isPq bit DEFAULT(0))";
    
        if (![_db tableExists:@"tblHotTenders"])
        {
            [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
                if (success){
                //NSLog(@"tblHotTenders created");
                }
                else{
                //NSLog(@"tblHotTenders creation failed query=%@",strQuery);
                }
            }];
        }
    
    
        /*-------------Group Query----------*/
    
        strQuery =      @"CREATE TABLE IF NOT EXISTS tblGroup"
        @"(groupId integer PRIMARY KEY,"
        @"name text,"
        @"creationDate text,"
        @"department text)";
        
        
        if (![_db tableExists:@"tblGroup"])
        {
            [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
                if (success){
                //NSLog(@"tblGroup created");
                }
                else{
                //NSLog(@"tblGroup creation failed query=%@",strQuery);
                }
            }];
        }
        
        /*-------------GroupTender Query----------*/
        
        strQuery =      @"CREATE TABLE IF NOT EXISTS tblGroupTenders"
        @"(id integer PRIMARY KEY AUTOINCREMENT,"
        @"refno text,"
        @"tsrno text,"
        @"groupId text,"
        @"custId text,"
        @"subno text,"
        @"isFav bit DEFAULT(0),"
        @"isViewed bit DEFAULT(0),"
        @"isDelete bit DEFAULT(0),"
        @"shareDate text,"
        @"updatedate text,"
        @"firstShareTender text)";
        
    
        if (![_db tableExists:@"tblGroupTenders"])
        {
            [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
                if (success){
                //NSLog(@"tblGroupTenders created");
                }
                else{
                //NSLog(@"tblGroupTenders creation failed query=%@",strQuery);
                }
            }];
        }
    
         /*-------------User Query----------*/
        
        strQuery =      @"CREATE TABLE IF NOT EXISTS tblUser"
        @"(userId integer,"
        @"groupId integer,"
        @"name text,"
        @"number text,"
        @"status text,"
        @"custId text,"
        @"subNo text,"
        @"FOREIGN KEY (groupId) REFERENCES tblGroup (groupId))";
        
    
        if (![_db tableExists:@"tblUser"])
        {
            [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
                if (success){
                //NSLog(@"tblUser created");
                }
                else{
                //NSLog(@"tblUser creation failed query=%@",strQuery);
                }
            }];
        }
    
   
    
        /*-------------Country Query----------*/
    
    strQuery =      @"CREATE TABLE tblCountry"
                    @"(country text,"
                    @"continent text)";
    
    
        if (![_db tableExists:@"tblCountry"])
        {
            [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
                if (success){
                    //NSLog(@"tblCountry created");
                }
                else{
                    //NSLog(@"Country creation failed query=%@",strQuery);
                }
            }];
        }
    
    
     /*------------------------------ Version 2.0 -------------------------------*/
    
                    /*-------------BroadCast Query----------*/
    
    strQuery =      @"CREATE TABLE IF NOT EXISTS tblAds"
    @"(id integer PRIMARY KEY,"
    @"title text,"
    @"description text,"
    @"isCheck bit DEFAULT(0),"
    @"creationDate text,"
    @"userStatus text,"
    @"url text,"
    @"isDelete bit DEFAULT(0))";
    
    
    if (![_db tableExists:@"tblAds"])
    {
        [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
            if (success){
              //  NSLog(@"tblAds created");
            }
            else{
              //  NSLog(@"tblAds creation failed query=%@",strQuery);
            }
        }];
    }

                    /*-------------Comment Query----------*/
    
    strQuery =      @"CREATE TABLE IF NOT EXISTS tblGroupComments"
    @"(id integer PRIMARY KEY AUTOINCREMENT,"
    @"commentId integer,"
    @"tsrno integer,"
    @"groupId integer,"
    @"custId integer,"
    @"subno integer,"
    @"number integer,"
    @"name text,"
    @"comment text,"
    @"commentDate text,"
    @"isScanTender bit DEFAULT(0),"
    @"isViewed bit DEFAULT(0),"
    @"isDelete bit DEFAULT(0))";
    
    
    
    if (![_db tableExists:@"tblGroupComments"])
    {
        [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
            if (success){
                //NSLog(@"tblUser created");
            }
            else{
                //NSLog(@"tblUser creation failed query=%@",strQuery);
            }
        }];
    }
    
            /*-------------Scan Tender Query----------*/
    
    strQuery =      @"CREATE TABLE IF NOT EXISTS tblGroupScanTenders"
    @"(id integer PRIMARY KEY AUTOINCREMENT,"
    @"imgid text,"
    @"path text,"
    @"groupId text,"
    @"custId text,"
    @"subno text,"
    @"isDelete bit DEFAULT(0),"
    @"shareDate text,"
    @"updatedate text,"
    @"firstShareTender text)";
    
    
    if (![_db tableExists:@"tblGroupScanTenders"])
    {
        [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
            if (success){
                //NSLog(@"tblGroupScanTenders created");
            }
            else{
                //NSLog(@"tblGroupScanTenders creation failed query=%@",strQuery);
            }
        }];
    }
    
    
                /*-------------Alter Table Query----------*/
    
    if (![_db columnExists:@"isDocument" inTableWithName:@"tblTenders"])
    {
        strQuery =@"ALTER table tblTenders ADD COLUMN  isDocument bit DEFAULT(0)";
        [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
            if (success){
              //  NSLog(@"ALTER tblTenders isDocument created");
            }
            else{
             //   NSLog(@"ALTER tblTenders isDocument failed query=%@",strQuery);
            }
        }];
    }
    
    if (![_db columnExists:@"isPq" inTableWithName:@"tblTenders"])
    {
        strQuery =@"ALTER table tblTenders ADD COLUMN isPq bit DEFAULT(0)";
        [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
            if (success){
             //   NSLog(@"ALTER tblTenders isPq created");
            }
            else{
             //   NSLog(@"ALTER tblTenders isPq failed query=%@",strQuery);
            }
        }];
    }
    
    if (![_db columnExists:@"isDocument" inTableWithName:@"tblHotTenders"])
    {
        strQuery =@"ALTER table tblHotTenders ADD COLUMN isDocument bit DEFAULT(0)";
        [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
            if (success){
             //   NSLog(@"ALTER tblHotTenders isDocument created");
            }
            else{
              //  NSLog(@"ALTER tblHotTenders isDocument failed query=%@",strQuery);
            }
        }];
    }
    if (![_db columnExists:@"isPq" inTableWithName:@"tblHotTenders"])
    {
        strQuery =@"ALTER table tblHotTenders ADD COLUMN isPq bit DEFAULT(0)";
        [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
            if (success){
             //   NSLog(@"ALTER tblHotTenders isPq created");
            }
            else{
             //   NSLog(@"ALTER tblHotTenders isPq failed query=%@",strQuery);
            }
        }];
    }
    if (![_db columnExists:@"firstShareTender" inTableWithName:@"tblGroupTenders"])
    {
        strQuery =@"ALTER table tblGroupTenders ADD COLUMN  firstShareTender text";
        [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
            if (success){
             //   NSLog(@"ALTER tblGroupTenders created");
            }
            else{
             //   NSLog(@"ALTER tblGroupTenders failed query=%@",strQuery);
            }
        }];
    }
    if (![_db columnExists:@"updatedate" inTableWithName:@"tblGroupTenders"])
    {
        strQuery =@"ALTER table tblGroupTenders ADD COLUMN  updatedate text";
        [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
            if (success){
                //   NSLog(@"ALTER tblGroupTenders created");
            }
            else{
                //   NSLog(@"ALTER tblGroupTenders failed query=%@",strQuery);
            }
        }];
    }
    

     /*------------------------------ Version 2.0 -------------------------------*/
    
    
}
-(NSString *) checkAndCreateDatabase{
    
    // Get the path to the documents directory and append the databaseName
    // NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // NSString *documentsDir = [documentPaths objectAtIndex:0];
    
   
    ////////NSLog(@"DOCUMENT DIRECTORY PATH -- >  %@",documentsDir);
    //NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSString  *databasePath =[NSString stringWithFormat:@"%@",[Document_Directory stringByAppendingPathComponent:DB_TenderTiger]];
    ////////NSLog(@"%@",databasePath);
    // Check if the SQL database has already been saved to the users phone, if not then copy it over
    
    
    // Create a FileManager object, we will use this to check the status
    // of the database and to copy it over if required
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Check if the database has already been created in the users filesystem
    BOOL success = [fileManager fileExistsAtPath:databasePath];
    
    // If the database already exists then return without doing anything
    if(success)
    {
        //[pool release];
        return databasePath;
    }
    
    // If not then proceed to copy the database from the application to the users filesystem
    
    // Get the path to the database in the application package
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_TenderTiger];
    //////NSLog(@"resource path:%@",databasePathFromApp);
    
    
    // Copy the database from the package to the users filesystem
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
    //[pool release];
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
-(void)executeQuery:(NSString *)Query andCompletionBlock:(void(^)(FMResultSet *fResult))completionBlock
{
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *fResult = [db executeQuery:[NSString stringWithFormat:@"%@",Query]];
        completionBlock(fResult);
       
        }];

    
}


- (void) executeUpdate:(NSString*)Query andCompletionBlock:(void(^)(BOOL success))completionBlock
{
    
    [_queue inDatabase:^(FMDatabase *db) {
         BOOL success = [db executeUpdate:Query];
        completionBlock(success);
    }];
    
//    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
//        BOOL success = [db executeUpdate:Query];
//        completionBlock(success);
//    }];
   
}
    
#pragma mark - Country/Continent Query Methods
-(void)fillCountryAndContinentsfromLocal{
    
    NSUInteger count = [_db intForQuery:@"SELECT COUNT(*) FROM tblCountry"];
    
    if (count == 0) {
        NSString* filepath = [[NSBundle mainBundle]pathForResource:@"country" ofType:@"txt"];
        
        NSData *data = [NSData dataWithContentsOfFile:filepath];
        NSError *error=nil;
        NSDictionary *dictJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error) {
            ////NSLog(@"error=%@",error.description);
        }else{
            // //NSLog(@"error=%@",dictJSON);
            [dictJSON enumerateKeysAndObjectsUsingBlock: ^(NSString *country, NSString *continent, BOOL *stop) {
                NSString *strQuery =[NSString stringWithFormat:@"INSERT INTO tblCountry"
                                     @"(country, continent)"
                                     @"VALUES('%@', '%@')",country,continent];
                [self executeUpdate:strQuery andCompletionBlock:^(BOOL success){
                    if (success){
                        //   NSLog(@"tblCountry inserted");
                    }
                    else{
                        //  NSLog(@"tblCountry failed");
                    }
                }];
            }];
            
            
            
        }
    }
    
}
-(void)fillCountryAndContinentsfromWeb:(NSMutableArray *)arr_List{
    [self executeUpdate:@"Delete from tblCountry" andCompletionBlock:^(BOOL success){
        
    }];
    for(NSDictionary *dict in arr_List){
        
        [self executeUpdate:[NSString stringWithFormat:@"INSERT INTO tblCountry"
                             @"(country, continent)"
                             @"VALUES('%@', '%@')",[dict valueForKey:@"country"],[dict valueForKey:@"continent"]]
         andCompletionBlock:^(BOOL success){
             
         }];
    }
    
    
}
-(void)getContinentlist:(void(^)(NSMutableArray *result))completionBlock
{
    NSMutableArray *temp_continent = [NSMutableArray array];
    
    
    [self executeQuery:@"SELECT distinct(continent) FROM tblCountry order by continent ASC" andCompletionBlock:^(FMResultSet *fResult){
        while([fResult next])
        {
            
            [temp_continent addObject:[NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[fResult stringForColumn:@"continent"]],[NSNumber numberWithBool:NO], nil] forKeys:[NSArray arrayWithObjects:@"value",@"Is_Selected", nil]]];
            
        }
        [fResult close];
        completionBlock(temp_continent);
    }];
   
    
}

-(void)getcountriesForContinent:(NSString *)continent andCompletionBlock:(void(^)(NSMutableArray *result))completionBlock
{
    NSMutableArray *temp_country = [NSMutableArray array];
   
   
    [self executeQuery:[NSString stringWithFormat:@"SELECT distinct(country) FROM tblCountry where continent='%@' order by country ASC",continent] andCompletionBlock:^(FMResultSet *fResult){
        while([fResult next])
        {
            [temp_country addObject:[NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[fResult stringForColumn:@"country"]],[NSNumber numberWithBool:NO], nil] forKeys:[NSArray arrayWithObjects:@"value",@"Is_Selected", nil]]];
            
        }
    //    NSLog(@"-->%@",temp_country);
        [fResult close];
        completionBlock (temp_country);
    }];
        
   
}
#pragma mark - Tender Query Methods
-(void)CreateOrUpdateTenders:(NSMutableArray *)arrWebTender andCompletionBlock:(void(^)(BOOL success , int newRecordCount))completionBlock {
    __block int newRec = 0;
    for (NSMutableDictionary *dictTender in arrWebTender){
        
        NSInteger tenderCount = [_db intForQuery:[NSString stringWithFormat:@"select count(*) from tblTenders where tsrno = '%@' and subno = '%@'",[NSString stringWithFormat:@"%@",[dictTender valueForKey:@"SrNo"]],User_SubNo]];
        
        if (tenderCount == 0) {
            [self executeUpdate:[NSString stringWithFormat:
                                 @"INSERT INTO tblTenders"
                                 @"(city, closingdate, company, department, country, currency, keyword, tenderdetail, tsrno, state, refno, tenderValue, tenderValueFull, updatedate, subno, isFav, tenderDate, continent, custId , isViewed, rowid,IsCorrAvailable,isDocument,isPq)"
                                 @"VALUES('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@' ,'%@', '%@', '%@','%@', '%@','%@','%@','%@')",
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"City"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"ClosingDate"]],
                                 [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"CompanyName"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"]],
                                 [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"Department"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Country"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Currency"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Keywords"]],
                                 [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"ProductDetails"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"SrNo"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"State"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"TcNo"]],
                                 [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"TenderValue"]stringByReplacingOccurrencesOfString:@"(approx.)" withString:@""]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"TenderValueNumeric"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"uploadeddate"]],
                                 User_SubNo,
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsFavourite"]],
                                 [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"TenderDate"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Continent"]],
                                 User_CustID,
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsViewed"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"RowId"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsCorrAvailable"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsOtherDocAvailable"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsPQavailable"]]]
             andCompletionBlock:^(BOOL success){
                 if(success){
                     //NSLog(@"Insert tender Successfully");
                     newRec++;
                 }else{
                     //NSLog(@"Insert tender Fail");
                 }
             }];
        }else{
            [self executeUpdate:[NSString stringWithFormat:@"UPDATE tblTenders"
                                 @" SET city='%@',closingdate='%@',"
                                 @"company='%@',department='%@',"
                                 @"country='%@',currency='%@',"
                                 @"keyword='%@',tenderdetail='%@',"
                                 @"state='%@',refno='%@',"
                                 @"tenderValue='%@',tenderValueFull='%@',"
                                 @"isFav='%@',"
                                 @"tenderDate='%@',"
                                 @"updatedate='%@',"
                                 @"continent='%@',"
                                 @"custId='%@',"
                                 @"isViewed='%@',"
                                 @"rowid='%@',"
                                 @"IsCorrAvailable='%@',"
                                 @"isDocument='%@',"
                                 @"isPq='%@'"
                                 @" WHERE tsrno = '%@' and subno='%@'",
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"City"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey: @"ClosingDate"]],
                                 [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"CompanyName"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"]],
                                 [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"Department"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Country"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Currency"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Keywords"]],
                                 [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"ProductDetails"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"State"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"TcNo"]],
                                 [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"TenderValue"]stringByReplacingOccurrencesOfString:@"(approx.)" withString:@""]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"TenderValueNumeric"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsFavourite"]],
                                 [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"TenderDate"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"uploadeddate"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Continent"]],
                                 User_CustID,
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsViewed"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"RowId"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsCorrAvailable"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsOtherDocAvailable"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsPQavailable"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"SrNo"]],
                                 User_SubNo]
             andCompletionBlock:^(BOOL success){
                 if(success){
                     //NSLog(@"Update tender Successfully");
                 }else{
                     //NSLog(@"Update tender Fail");
                 }
             }];
            
            
            
        }
        
        
    }
    completionBlock(YES, newRec);
    
}
-(void)CreateOrUpdateHotTenders:(NSMutableArray *)arrHotTenders andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    
    
    [self executeUpdate:[NSString stringWithFormat:@"DELETE from tblHotTenders"
                         @" WHERE %@",
                         [[CommonMethods sharedInstance] AppendsubnoANDcustid]]
     andCompletionBlock:^(BOOL success){
         if(success){
             //NSLog(@"Delete HotTender Successfully");
         }else{
             //NSLog(@"Delete HotTender Fail");
         }
     }];
    
    [DELEGATE.dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone localTimeZone]];
    for(NSMutableDictionary *dictTender in arrHotTenders)
    {
        [self executeUpdate:[NSString stringWithFormat:@"INSERT INTO tblHotTenders"
                             @"(city, closingdate, company, department, country, currency, keyword, tenderdetail, tsrno, state, refno, tenderValue, tenderValueFull, updatedate, subno, isFav,isViewed, tenderDate, continent, custId,IsCorrAvailable,isDocument,isPq)"
                             @"VALUES('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', %@ ,'%@', '%@', '%@','%@','%@','%@','%@')",
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"City"]],
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"ClosingDate"]],
                             [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"CompanyName"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"]],
                             [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"Department"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"]],
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Country"]],
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Currency"]],
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Keywords"]],
                             [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"ProductDetails"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"]],
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"SrNo"]],
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"State"]],
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"TcNo"]],
                             [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"TenderValue"]stringByReplacingOccurrencesOfString:@"(approx.)" withString:@""]],
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"TenderValueNumeric"]],
                             [DELEGATE.dateFormatter_GroupTenderserver stringFromDate:[NSDate date]],
                             User_SubNo,
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsFav"]],
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsViewed"]],
                             [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"TenderDate"]],
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Continent"]],
                             User_CustID,
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsCorrAvailable"]],
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsOtherDocAvailable"]],
                             [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsPQavailable"]]]
         
         andCompletionBlock:^(BOOL success)
         {
             if(success){
                 //NSLog(@"Insert HotTender Successfully");
             }else{
                 //NSLog(@"Insert HotTender Fail");
             }
             
         }];
        
        if ([[NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsViewed"]]isEqualToString:@"1"]||[[NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsFav"]]isEqualToString:@"1"]) {
            
            // Key is different in Hot tender API and normal API
            [dictTender setObject:[NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsFav"]] forKey:@"IsFavourite"];
            [dictTender setObject:[NSString stringWithFormat:@"%@",[DELEGATE.dateFormatter_GroupTenderserver stringFromDate:[NSDate date]]] forKey:@"uploadeddate"];
            [self CreateOrUpdateTenders:[NSMutableArray arrayWithObject:dictTender] andCompletionBlock:^(BOOL success, int newTenderCount){
                
                
            }];
        }
    }
    [DELEGATE.dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    [self executeUpdate:[NSString stringWithFormat:
                         @"UPDATE tblHotTenders"
                         @" SET isFav = 1"
                         @" WHERE tsrno IN (SELECT tsrno FROM tblTenders WHERE isFav=1 AND %@ and isDelete = 0)",[[CommonMethods sharedInstance] AppendsubnoANDcustid]]
     andCompletionBlock:^(BOOL success)
     {
         if(success){
             //NSLog(@"UPDATE HotTender Fav Successfully");
         }else{
             //NSLog(@"UPDATE HotTender Fav Fail");
         }
     }];
    
    [self executeUpdate:[NSString stringWithFormat:@"UPDATE tblHotTenders"
                         @" SET isViewed = 1"
                         @" WHERE tsrno IN (SELECT tsrno FROM tblTenders WHERE isViewed=1 AND %@ and isDelete = 0)",[[CommonMethods sharedInstance] AppendsubnoANDcustid]]
     andCompletionBlock:^(BOOL success)
     {
         if(success){
             //NSLog(@"UPDATE HotTender View Successfully");
         }else{
             //NSLog(@"UPDATE HotTender View Fail");
         }
     }];
    
    [self executeUpdate:[NSString stringWithFormat:@"UPDATE tblHotTenders"
                         @" SET isDelete = 1"
                         @" WHERE tsrno IN (SELECT tsrno FROM tblTenders WHERE  %@ and isDelete = 1)",[[CommonMethods sharedInstance] AppendsubnoANDcustid]]
     andCompletionBlock:^(BOOL success)
     {
         if(success){
             //NSLog(@"UPDATE HotTender Delete Successfully");
         }else{
             //NSLog(@"UPDATE HotTender Delete Fail");
         }
         
         
     }];
    completionBlockmethod(YES);
    
}
-(void)DeleteArchives:(void(^)(BOOL success))completionBlockmethod{
   
    
    [self executeUpdate:[NSString stringWithFormat:@"DELETE from tblTenders"
                         @" WHERE closingdate < date('now') and"
                         @"%@ and isViewed = 0 and isFav = 0",
                         [[CommonMethods sharedInstance] AppendsubnoANDcustid]]
     andCompletionBlock:^(BOOL success){
         if(success){
             //NSLog(@"Delete Archive Tender Successfully");
         }else{
             //NSLog(@"Delete Archive Tender Fail");
         }
     }];
    
    [self executeUpdate:[NSString stringWithFormat:@"DELETE from tblTenders"
                         @" WHERE updatedate <= date('now','-5 day') and"
                         @"isDelete = 1 and %@",
                         [[CommonMethods sharedInstance] AppendsubnoANDcustid]]
     andCompletionBlock:^(BOOL success){
         if(success){
             //NSLog(@"Delete Archive Tender Successfully");
         }else{
             //NSLog(@"Delete Archive Tender Fail");
         }
     }];
    completionBlockmethod(YES);
}
-(void)RemoveLiveOrSeenOrAchiveTender:(NSString *)str_TsrNo andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    [self executeUpdate:[NSString stringWithFormat:
                         @"UPDATE tblTenders"
                         @" SET isDelete=1"
                         @" WHERE tsrno = '%@' and %@",str_TsrNo,
                         [[CommonMethods sharedInstance] AppendsubnoANDcustid]] andCompletionBlock:^(BOOL success){
        if(success){
            //NSLog(@"Delete Archive Tender Successfully");
            
        }else{
            //NSLog(@"Delete Archive Tender Fail");
            
        }
        completionBlockmethod(success);
    }];
    
}
-(void)LikeLiveOrSeenOrHotOrAchiveTender:(NSString *)str_TsrNo is_like:(BOOL)is_like andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    
    [self executeUpdate:[NSString stringWithFormat:
                         @"UPDATE tblTenders"
                         @" SET isFav=%@"
                         @" WHERE tsrno = '%@' and %@",(is_like)?@"1":@"0",str_TsrNo,[[CommonMethods sharedInstance] AppendsubnoANDcustid]]
     andCompletionBlock:^(BOOL success){
         if(success){
             //NSLog(@"UPDATE Tender Successfully");
             
         }else{
             //NSLog(@"UPDATE Tender Fail");
         }
     }];
    
    [self executeUpdate:[NSString stringWithFormat:
                         @"UPDATE tblHotTenders"
                         @" SET isFav=%@"
                         @" WHERE tsrno = '%@' and %@",(is_like)?@"1":@"0",str_TsrNo,[[CommonMethods sharedInstance] AppendsubnoANDcustid]]
     andCompletionBlock:^(BOOL success){
         if(success){
             //NSLog(@"UPDATE HotTenders Successfully");
             
         }else{
             //NSLog(@"UPDATE HotTenders Fail");
         }
     }];
    
    
    [self insertTenderfromHotTender:str_TsrNo];
    
    [[ModelClass sharedInstance]LikeTenderwithParameter:
    @{@"appuserid":User_App_User_Id,
      @"srno":[NSString stringWithFormat:@"%@",str_TsrNo],
      @"subno":User_SubNo,
      @"userstatus":[NSString stringWithFormat:@"%d",User_Status],
      @"action":(is_like)?@"like":@"unlike"
      }
        success:^(id result){

            
        } error:^(NSError *error){
    }];
    completionBlockmethod(YES);
    
    
    
}
-(void)ViewTender:(NSString *)str_TsrNo andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    
    [self executeUpdate:[NSString stringWithFormat:
                         @"UPDATE tblTenders"
                         @" SET isViewed= 1"
                         @" WHERE tsrno = '%@' and %@",str_TsrNo,[[CommonMethods sharedInstance] AppendsubnoANDcustid]]
     andCompletionBlock:^(BOOL success){
         if(success){
             //NSLog(@"UPDATE Tenders Successfully");
             
         }else{
             //NSLog(@"UPDATE Tenders Fail");
         }
     }];
    [self executeUpdate:[NSString stringWithFormat:
                         @"UPDATE tblHotTenders"
                         @" SET isViewed= 1"
                         @" WHERE tsrno = '%@' and %@",str_TsrNo,[[CommonMethods sharedInstance] AppendsubnoANDcustid]]
     andCompletionBlock:^(BOOL success){
         if(success){
             //NSLog(@"UPDATE HotTenders Successfully");
             
         }else{
             //NSLog(@"UPDATE HotTenders Fail");
         }
     }];
    [self insertTenderfromHotTender:str_TsrNo];
    
     completionBlockmethod(YES);
    
    
}
-(void)insertTenderfromHotTender:(NSString *)tsrno{
   
    int count = [_db intForQuery:[NSString stringWithFormat:
                                  @"select count(*) from tblTenders"
                                  @" WHERE tsrno = '%@' and %@",tsrno,[[CommonMethods sharedInstance] AppendsubnoANDcustid]]];
        if (count==0)
        {
            [self executeUpdate:
             [NSString stringWithFormat:@"INSERT INTO tblTenders( refno , tenderValue , department , tenderdetail , closingdate , state , country , company , subno , tsrno , city , currency , updatedate , keyword , tenderValueFull , isFav , tenderDate ,continent , custId , isViewed , isDelete,IsCorrAvailable,isDocument,isPq ) Select refno , tenderValue , department , tenderdetail , closingdate , state , country , company , subno , tsrno , city , currency , updatedate , keyword , tenderValueFull , isFav , tenderDate ,continent , custId , isViewed , isDelete,IsCorrAvailable,isDocument,isPq from tblHotTenders where %@ and tsrno = '%@'",[[CommonMethods sharedInstance] AppendsubnoANDcustid],tsrno] andCompletionBlock:^(BOOL success){
                 if(success){
                     //NSLog(@"INSERT Tenders Successfully");
                     
                 }else{
                     //NSLog(@"INSERT Tenders Fail");
                 }
             }];
           }
}
#pragma mark Group Query Methods
-(void)CreateorUpdateGroup:(NSMutableArray *)arr_groups DeletePreviousGroups:(BOOL)is_delete andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
  
//    NSString *temp = @"";
//    if (User_Status == Special_User || User_Status == Registerd_User)
//        temp= [NSString stringWithFormat:@"custId ='%@'",User_CustID];
//    else
//        temp= [NSString stringWithFormat:@"subNo = '%@'",User_SubNo];
//    
//    NSString *QUERY = [NSString stringWithFormat:@"select distinct g.groupId from tblUser u JOIN  tblGroup g ON u.groupId = g.groupId where u.%@",temp];
//    [self executeQuery:QUERY andCompletionBlock:^(FMResultSet *fResult){
//        while ([fResult next]) {
//            if ([fResult stringForColumn:@"g.groupId"] == nil && [[fResult stringForColumn:@"g.groupId"] isEmptyString])
//            {
//               
//                [self executeUpdate:[NSString stringWithFormat:@"delete from tblUser where groupId='%@'",[fResult stringForColumn:@"g.groupId"]] andCompletionBlock:^(BOOL success){
//                
//                }];
//            }
//        }
//    }];
    if(is_delete){
    [self executeUpdate:[NSString stringWithFormat:@"Delete from tblUser"]
     andCompletionBlock:^(BOOL success){
         if(success){
             //  NSLog(@"Delete tblUser Successfully");
         }else{
             //  NSLog(@"UPDATE tblUser Fail");
         }
     }];
    }
    NSMutableArray *contacts = [NSMutableArray array];
    [[CommonMethods sharedInstance] getContactsFromAddressBook:^(BOOL success,id result){
        if(success){
            for (THContact *contact in result) {
                [contacts addObject:@{@"mobileno":[[[NSString stringWithFormat:@"%@",contact.phone] componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]]componentsJoinedByString:@""],
                                         @"name":[NSString stringWithFormat:@"%@",[contact fullName]]}];
            }
        }
       
        for(NSMutableDictionary *dict in arr_groups)
        {
            if ([[dict valueForKey:@"GroupId"]intValue]!=0) {
                
            
            int count = [_db intForQuery:[NSString stringWithFormat:@"Select count(*) from tblGroup where groupId = '%@'",[dict objectForKey:@"GroupId"]]];
            
            if (count == 0)
            {
                NSString *strDate = [NSString stringWithFormat:@"%@",[dict objectForKey:@"CreateGroupDate"]];
                
                if (strDate == nil || [strDate isEmptyString])
                {
                    strDate = [DELEGATE.dateFormatter_server stringFromDate:[NSDate date]];
                }
                
                [self executeUpdate:[NSString stringWithFormat:@"insert into tblGroup (groupId,name,creationDate) values('%@','%@','%@')"
                                     ,[dict objectForKey:@"GroupId"],[dict objectForKey:@"GroupName"],strDate]
                 andCompletionBlock:^(BOOL success){
                     if(success){
                         //   NSLog(@"Insert tblGroup Successfully");
                     }else{
                         //   NSLog(@"Insert tblGroup Fail");
                     }
                 }];
                
            }
            else
            {
                [self executeUpdate:[NSString stringWithFormat:@"UPDATE tblGroup SET name='%@' where groupId='%@'",[dict objectForKey:@"GroupName"],[dict objectForKey:@"GroupId"]]
                 andCompletionBlock:^(BOOL success){
                     if(success){
                         // NSLog(@"UPDATE tblGroup Successfully");
                     }else{
                         //  NSLog(@"UPDATE tblGroup Fail");
                     }
                 }];
            }
            
//            [self executeUpdate:[NSString stringWithFormat:@"Delete from tblUser where groupId='%@'",[dict objectForKey:@"GroupId"]]
//             andCompletionBlock:^(BOOL success){
//                 if(success){
//                     //  NSLog(@"Delete tblUser Successfully");
//                 }else{
//                     //  NSLog(@"UPDATE tblUser Fail");
//                 }
//             }];
            if([[dict objectForKey:@"lstGroupUserList"] isKindOfClass:[NSArray class]]){
            for (NSMutableDictionary *dictUser in [dict objectForKey:@"lstGroupUserList"])
            {
                
                //NSLog(@"dictUser=%@",dictUser);
                NSString *strSubNo = [NSString stringWithFormat:@"%@",[dictUser objectForKey:@"SubNo"]];
                NSString * strCustId = [NSString stringWithFormat:@"%@",[dictUser objectForKey:@"CustId"]];
                
                if (strSubNo == nil || [strSubNo isEqualToString:@"0"])
                    strSubNo=@"";
                
                if (strCustId == nil || [strCustId isEqualToString:@"0"])
                    strCustId=@"";
                
                
                [self executeUpdate:[NSString stringWithFormat:@"insert into tblUser (userId,groupId,name,number,status,custId,subNo) values('%@','%@','%@','%@','%@','%@','%@')"
                                     ,[dictUser objectForKey:@"GroupUserId"],[dict objectForKey:@"GroupId"],[[CommonMethods sharedInstance] getNameforContactNo:[dictUser objectForKey:@"MobileNo"] inArray:contacts],[dictUser objectForKey:@"MobileNo"],[dictUser objectForKey:@"DisplayText"],strCustId,strSubNo]
                 andCompletionBlock:^(BOOL success){
                     if(success){
                         //  NSLog(@"Insert tblUser Successfully");
                     }else{
                         //  NSLog(@"Insert tblUser Fail");
                     }
                 }];
                
            }
            }
            
            }
        }
        completionBlockmethod(YES);
        
    }];
    
   
}
-(void)DeleteMemberFromGroup:(NSString *)groupID AppendString:(NSString *)AppendString andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    [self executeUpdate:[NSString stringWithFormat:@"delete from tblUser where groupId = '%@' and %@",groupID,AppendString]
     andCompletionBlock:^(BOOL success){
         if(success){
              NSLog(@"delete tblUser Successfully");
             
         }else{
               NSLog(@"delete tblUser Fail");
         }
     }];
    completionBlockmethod(YES);
    

}
-(void)UpdateGroupName:(NSString *)name ForGroupId:(NSString *)grpID andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    [self executeUpdate:[NSString stringWithFormat:@"UPDATE tblGroup SET name='%@' where groupId='%@'",name,grpID]
     andCompletionBlock:^(BOOL success){
         if(success){
             // NSLog(@"UPDATE tblGroup Successfully");
             
         }else{
             //  NSLog(@"UPDATE tblGroup Fail");
         }
         completionBlockmethod(success);
     }];
   
}
-(void)CreateOrUpdateGroupTenders:(NSMutableArray *)arrGroupTenders GroupScanTenders:(NSMutableArray *)arrScanTenders andCompletionBlock:(void(^)(int newRecordCount,BOOL success))completionBlockmethod
{
    
    NSMutableArray *contacts = [NSMutableArray array];
    [[CommonMethods sharedInstance] getContactsFromAddressBook:^(BOOL success,id result){
        if(success){
            for (THContact *contact in result) {
                [contacts addObject:@{@"mobileno":[[[NSString stringWithFormat:@"%@",contact.phone] componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]]componentsJoinedByString:@""],
                                      @"name":[NSString stringWithFormat:@"%@",[contact fullName]]}];
            }
        }
    
    __block int newRec = 0;
   
    for(NSMutableDictionary *dictTender in arrGroupTenders)
    {
        int count = [_db intForQuery:[NSString stringWithFormat:@"select count(*) from tblTenders where tsrno ='%@'  and isgroup = '1'",[dictTender objectForKey:@"SrNo"]]];
        [DELEGATE.dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone localTimeZone]];
        if (count == 0)
        {
            [self executeUpdate:[NSString stringWithFormat:@"INSERT INTO tblTenders"
                                 @"(city, closingdate, company, department, country, currency, keyword, tenderdetail, tsrno, state, refno, tenderValue, tenderValueFull, updatedate, tenderDate, continent,isgroup,IsCorrAvailable,isDocument,isPq)"
                                 @"VALUES('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@' ,'%@', '%@', '%@','1', '%@', '%@', '%@')",
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"City"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"ClosingDate"]],
                                 [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"CompanyName"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"]],
                                 [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"Department"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Country"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Currency"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Keywords"]],
                                 [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"ProductDetails"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"SrNo"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"State"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"TcNo"]],
                                 [NSString stringWithFormat:@"%@",[[dictTender objectForKey:@"TenderValue"]stringByReplacingOccurrencesOfString:@"(approx.)" withString:@""]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"TenderValueNumeric"]],
                                 [DELEGATE.dateFormatter_GroupTenderserver stringFromDate:[NSDate date]],
                                 [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"TenderDate"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"Continent"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsCorrAvailable"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsOtherDocAvailable"]],
                                 [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsPQavailable"]]
                                 ] andCompletionBlock:^(BOOL success){
                if(success){
                    //   NSLog(@"Insert tender(group) Successfully");
                    
                }else{
                    //   NSLog(@"Insert tender(group) Fail");
                }
            }];
        }
        [DELEGATE.dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        //Group Tender Query:
        
        NSArray *arrGroupIds = [[NSString stringWithFormat:@"%@",[dictTender objectForKey:@"GroupIds"]] componentsSeparatedByString:@","];
        NSArray *FirstSharedDateArray = [[NSString stringWithFormat:@"%@",[dictTender objectForKey:@"FirstSharedDate"]] componentsSeparatedByString:@","];
        NSArray *UpdateDateArray = [[NSString stringWithFormat:@"%@",[dictTender objectForKey:@"UpdateDateList"]] componentsSeparatedByString:@","];
        
        for(int i=0;i<arrGroupIds.count;i++)
        {
            
            int countGrpTender = [_db intForQuery:[NSString stringWithFormat:@"select count(*) from tblGroupTenders WHERE tsrno = '%@' and groupId='%@' and %@",[dictTender valueForKey:@"SrNo"],[arrGroupIds objectAtIndex:i],[[CommonMethods sharedInstance] AppendsubnoORcustid]]];
            NSString *contactName = [NSString stringWithFormat:@"%@",[[CommonMethods sharedInstance]getNameforContactNo:[dictTender objectForKey:@"FirstShareTenderMobileNo"] inArray:contacts]];
            if ([[dictTender objectForKey:@"FirstShareTenderMobileNo"] isEqualToString:User_Mobile_Number]) {
                contactName = @"Me";
            }
            
            if (countGrpTender != 0)
            {
                [self executeUpdate:
                 [NSString stringWithFormat:@"Update tblGroupTenders SET refno='%@',"
                  @"isFav='%@',isViewed='%@',firstShareTender='%@',shareDate='%@',updatedate='%@'"
                  @" WHERE tsrno = '%@' and groupId='%@' and %@"
                  ,[NSString stringWithFormat:@"%@",[dictTender objectForKey:@"TcNo"]],
                  [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsFavourite"]],
                  [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsViewed"]],
                  contactName,
                  [NSString stringWithFormat:@"%@",[FirstSharedDateArray objectAtIndex:i]],
                  [NSString stringWithFormat:@"%@",[UpdateDateArray objectAtIndex:i]],
                  [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"SrNo"]],
                  [NSString stringWithFormat:@"%@",[arrGroupIds objectAtIndex:i]],
                  [[CommonMethods sharedInstance] AppendsubnoORcustid]]
                 andCompletionBlock:^(BOOL success){
                     if(success){
                         //   NSLog(@"Update tblGroupTenders Successfully");
                         
                     }else{
                         //   NSLog(@"Update tblGroupTenders Fail");
                     }
                 }];
                
            }
            else
            {
                
                [self executeUpdate:[NSString stringWithFormat:@"INSERT INTO tblGroupTenders (refno,tsrno, groupId , %@ , isFav , isViewed , shareDate,updatedate,firstShareTender) VALUES ('%@', '%@', '%@', %@, '%@', '%@', '%@', '%@', '%@')",
                                     (User_Status == Special_User || User_Status == Registerd_User)?@"custId":@"subno",
                                     [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"TcNo"]],
                                     [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"SrNo"]],
                                     [NSString stringWithFormat:@"%@",[arrGroupIds objectAtIndex:i]],
                                     (User_Status == Special_User || User_Status == Registerd_User)?User_CustID:User_SubNo,
                                     [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsFavourite"]],
                                     [NSString stringWithFormat:@"%@",[dictTender objectForKey:@"IsViewed"]],
                                     [NSString stringWithFormat:@"%@",[FirstSharedDateArray objectAtIndex:i]],
                                     [NSString stringWithFormat:@"%@",[UpdateDateArray objectAtIndex:i]],
                                     contactName
                                     ]
                 andCompletionBlock:^(BOOL success){
                     if(success){
                         newRec++;
                         //  NSLog(@"Insert tblGroupTenders Successfully");
                         
                     }else{
                         //  NSLog(@"Insert tblGroupTenders Fail");
                     }
                 }];
            }
        }
        
    }
    
        
        /*------------- Scan Tenders ----------------- */
        
        for (NSMutableDictionary *dictScanTender in arrScanTenders) {
            
            NSArray *arrGroupIds = [[NSString stringWithFormat:@"%@",[dictScanTender objectForKey:@"GroupIds"]] componentsSeparatedByString:@","];
            
            NSArray *FirstSharedDateArray = [[NSString stringWithFormat:@"%@",[dictScanTender objectForKey:@"FirstSharedDate"]] componentsSeparatedByString:@","];
            NSArray *UpdateDateArray = [[NSString stringWithFormat:@"%@",[dictScanTender objectForKey:@"UpdateDateList"]] componentsSeparatedByString:@","];
            
            NSString *contactName = [NSString stringWithFormat:@"%@",[[CommonMethods sharedInstance]getNameforContactNo:[dictScanTender objectForKey:@"FirstShareTenderMobileNo"] inArray:contacts]];
            if ([[dictScanTender objectForKey:@"FirstShareTenderMobileNo"] isEqualToString:User_Mobile_Number]) {
                contactName = @"Me";
            }
            for(int i=0;i<arrGroupIds.count;i++)
            {
                
                int countGrpTender = [_db intForQuery:[NSString stringWithFormat:@"select count(*) from tblGroupScanTenders WHERE imgid = '%@' and groupId='%@' and %@",[dictScanTender valueForKey:@"ImgId"],[arrGroupIds objectAtIndex:i],[[CommonMethods sharedInstance] AppendsubnoORcustid]]];
                
                if (countGrpTender != 0)
                {
                    
                    [self executeUpdate:
                     [NSString stringWithFormat:@"Update tblGroupScanTenders SET path='%@',"
                      @"shareDate = '%@',updatedate='%@',firstShareTender = '%@'"
                      @" WHERE imgid = '%@' and groupId='%@' and %@",
                      [dictScanTender valueForKey:@"ImgURL"],
                      [NSString stringWithFormat:@"%@",[FirstSharedDateArray objectAtIndex:i]],
                      [NSString stringWithFormat:@"%@",[UpdateDateArray objectAtIndex:i]],
                      contactName,
                      [dictScanTender valueForKey:@"ImgId"],
                      [arrGroupIds objectAtIndex:i],
                      [[CommonMethods sharedInstance] AppendsubnoORcustid]]
                     andCompletionBlock:^(BOOL success){
                         if(success){
                             //   NSLog(@"Update tblGroupTenders Successfully");
                             
                         }else{
                             //    NSLog(@"Update tblGroupTenders Fail");
                         }
                     }];
                    
                }
                else
                {
                    [self executeUpdate:[NSString stringWithFormat:@"INSERT INTO tblGroupScanTenders (imgid,path, groupId , %@ ,shareDate,updatedate,firstShareTender ) VALUES ('%@', '%@', '%@', %@, '%@', '%@','%@')",
                                         (User_Status == Special_User || User_Status == Registerd_User)?@"custId":@"subno",
                                         [dictScanTender valueForKey:@"ImgId"],
                                         [dictScanTender valueForKey:@"ImgURL"],
                                         [arrGroupIds objectAtIndex:i] ,
                                         (User_Status == Special_User || User_Status == Registerd_User)?User_CustID:User_SubNo,
                                         [NSString stringWithFormat:@"%@",[FirstSharedDateArray objectAtIndex:i]],
                                         [NSString stringWithFormat:@"%@",[UpdateDateArray objectAtIndex:i]],
                                         contactName
                                         ]
                     andCompletionBlock:^(BOOL success){
                         if(success){
                             newRec++;
                             //   NSLog(@"Insert tblGroupTenders Successfully");
                             
                         }else{
                             //   NSLog(@"Insert tblGroupTenders Fail");
                         }
                     }];
                }
            }
        }
     
    completionBlockmethod(newRec,YES);
    }];
    
}
-(void)AddMySharedTenderToGroups:(NSMutableArray *)arrGroupIds Tender:(NSMutableDictionary *)dictTender andCompletionBlock:(void(^)(BOOL success))completionBlockmethod
{
    
    
        int count = [_db intForQuery:[NSString stringWithFormat:@"select count(*) from tblTenders where tsrno ='%@'  and isgroup = '1'",[dictTender valueForKey:@"tsrno"]]];
        
        if (count == 0)
        {
            [self executeUpdate:[NSString stringWithFormat:@"Insert into tblTenders (refno, tenderValue, department, tenderdetail, closingdate, state, country, company, tsrno, city, currency, updatedate, keyword, tendervalueFull, tenderdate, continent, isgroup,IsCorrAvailable,isDocument,isPq) select refno, tenderValue, department, tenderdetail, closingdate, state, country, company, tsrno, city, currency, updatedate, keyword, tendervalueFull, tenderdate, continent, '1',IsCorrAvailable,isDocument,isPq from tblTenders where tsrno = '%@' and %@",[dictTender valueForKey:@"tsrno"],[[CommonMethods sharedInstance] AppendsubnoANDcustid]] andCompletionBlock:^(BOOL success){
                if(success){
                    //   NSLog(@"Insert tender(group) Successfully");
                    
                }else{
                   //    NSLog(@"Insert tender(group) Fail");
                }
            }];
        }
    
     [DELEGATE.dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone localTimeZone]];
        for(int i=0;i<arrGroupIds.count;i++)
        {
            
            int countGrpTender = [_db intForQuery:[NSString stringWithFormat:@"select count(*) from tblGroupTenders WHERE tsrno = '%@' and groupId='%@' and %@",[dictTender valueForKey:@"tsrno"],[[arrGroupIds objectAtIndex:i]objectForKey:@"groupid"],[[CommonMethods sharedInstance] AppendsubnoORcustid]]];
            
            if (countGrpTender != 0)
            {
                
                [self executeUpdate:
                 [NSString stringWithFormat:@"Update tblGroupTenders SET refno='%@',"
                  @"isFav='%@',isViewed='%@',updatedate='%@'"
                  @" WHERE tsrno = '%@' and groupId='%@' and %@",
                  [dictTender valueForKey:@"refno"],
                  [dictTender objectForKey:@"isFav"],
                  [dictTender objectForKey:@"isViewed"],
                  [DELEGATE.dateFormatter_GroupTenderserver stringFromDate:[NSDate date]],
                  [dictTender valueForKey:@"tsrno"],
                  [[arrGroupIds objectAtIndex:i] objectForKey:@"groupid"],
                  [[CommonMethods sharedInstance] AppendsubnoORcustid]]
                 andCompletionBlock:^(BOOL success){
                     if(success){
                         //   NSLog(@"Update tblGroupTenders Successfully");
                         
                     }else{
                         //   NSLog(@"Update tblGroupTenders Fail");
                     }
                 }];
                
            }
            else
            {
                [self executeUpdate:[NSString stringWithFormat:@"INSERT INTO tblGroupTenders (refno,tsrno, groupId , %@ , isFav , isViewed , shareDate,updatedate,firstShareTender ) VALUES ('%@', '%@', '%@', %@, '%@', '%@', '%@', '%@','%@')",
                                     (User_Status == Special_User || User_Status == Registerd_User)?@"custId":@"subno",
                                     [dictTender valueForKey:@"refno"],
                                     [dictTender valueForKey:@"tsrno"],
                                     [[arrGroupIds objectAtIndex:i] objectForKey:@"groupid"],
                                     (User_Status == Special_User || User_Status == Registerd_User)?User_CustID:User_SubNo,
                                     [dictTender objectForKey:@"isFav"],
                                     [dictTender objectForKey:@"isViewed"],
                                     [DELEGATE.dateFormatter_GroupTenderserver stringFromDate:[NSDate date]],
                                     [DELEGATE.dateFormatter_GroupTenderserver stringFromDate:[NSDate date]],
                                     @"Me"
                                     ]
                 andCompletionBlock:^(BOOL success){
                     if(success){
                         
                         //   NSLog(@"Insert tblGroupTenders Successfully");
                         
                     }else{
                         //   NSLog(@"Insert tblGroupTenders Fail");
                     }
                 }];
            }
        }
     [DELEGATE.dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    completionBlockmethod(YES);
    
}
-(void)RemoveGroupTender:(NSString *)str_TsrNo andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    
    [self executeUpdate:[NSString stringWithFormat:
                         @"UPDATE tblGroupTenders"
                         @" SET isDelete=1"
                         @" WHERE tsrno = '%@' and %@ and groupId='%@'",str_TsrNo,[[CommonMethods sharedInstance] AppendsubnoORcustid],[DELEGATE.dict_GroupInfo valueForKey:@"groupId"]] andCompletionBlock:^(BOOL success){
        if(success){
            //NSLog(@"Delete Archive Tender Successfully");
            
        }else{
            //NSLog(@"Delete Archive Tender Fail");
            
        }
        
    }];
    completionBlockmethod(YES);
    
}
-(void)LikeGroupTender:(NSString *)str_TsrNo is_like:(BOOL)is_like andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
   
    [self executeUpdate:[NSString stringWithFormat:
                         @"UPDATE tblGroupTenders"
                         @" SET isFav=%@"
                         @" WHERE tsrno = '%@' and %@ and groupId='%@'",(is_like)?@"1":@"0",str_TsrNo,[[CommonMethods sharedInstance] AppendsubnoORcustid],[DELEGATE.dict_GroupInfo valueForKey:@"groupId"]]
     andCompletionBlock:^(BOOL success){
         if(success){
             //NSLog(@"UPDATE GroupTender Successfully");
             
         }else{
             //NSLog(@"UPDATE GroupTender Fail");
         }
     }];
    
   
    [[ModelClass sharedInstance]LikeTenderwithParameter:
     @{@"appuserid":User_App_User_Id,
       @"srno":[NSString stringWithFormat:@"%@",str_TsrNo],
       @"subno":User_SubNo,
       @"action":(is_like)?@"like":@"unlike"
       }
        success:^(id result){
                                                    
    } error:^(NSError *error){
    }];
    completionBlockmethod(YES);
}
-(void)ViewGroupTender:(NSString *)str_TsrNo andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    
    [self executeUpdate:[NSString stringWithFormat:
                         @"UPDATE tblGroupTenders"
                         @" SET isViewed= 1"
                         @" WHERE tsrno = '%@' and %@ and groupId='%@'",str_TsrNo,[[CommonMethods sharedInstance] AppendsubnoORcustid],[DELEGATE.dict_GroupInfo valueForKey:@"groupId"]]
     andCompletionBlock:^(BOOL success){
         if(success){
             //NSLog(@"UPDATE GroupTender Successfully");
            
         }else{
             //NSLog(@"UPDATE GroupTender Fail");
             
         }
         completionBlockmethod(success);
     }];
    
    
}
#pragma mark - Scan Tender Query
-(void)AddMySharedScanTenderToGroups:(NSMutableArray *)arrGroupIds ScanTender:(NSMutableDictionary *)dictScanTender andCompletionBlock:(void(^)(BOOL success))completionBlockmethod
{

    [DELEGATE.dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone localTimeZone]];
    for(int i=0;i<arrGroupIds.count;i++)
    {
        int countGrpTender = [_db intForQuery:[NSString stringWithFormat:@"select count(*) from tblGroupScanTenders WHERE imgid = '%@' and groupId='%@' and %@",[dictScanTender valueForKey:@"ImgId"],[[arrGroupIds objectAtIndex:i]objectForKey:@"groupid"],[[CommonMethods sharedInstance] AppendsubnoORcustid]]];
        
        if (countGrpTender != 0)
        {
            
            [self executeUpdate:
             [NSString stringWithFormat:@"Update tblGroupScanTenders SET path='%@',"
              @"updatedate='%@'"
              @" WHERE imgid = '%@' and groupId='%@' and %@",
              [dictScanTender valueForKey:@"ImgURL"],
              [DELEGATE.dateFormatter_GroupTenderserver stringFromDate:[NSDate date]],
              [dictScanTender valueForKey:@"ImgId"],
              [[arrGroupIds objectAtIndex:i] objectForKey:@"groupid"],
              [[CommonMethods sharedInstance] AppendsubnoORcustid]]
             andCompletionBlock:^(BOOL success){
                 if(success){
                    //   NSLog(@"Update tblGroupTenders Successfully");
                     
                 }else{
                    //    NSLog(@"Update tblGroupTenders Fail");
                 }
             }];
            
        }
        else
        {
            [self executeUpdate:[NSString stringWithFormat:@"INSERT INTO tblGroupScanTenders (imgid,path, groupId , %@ ,shareDate,updatedate,firstShareTender ) VALUES ('%@', '%@', '%@', %@, '%@', '%@','%@')",
                                 (User_Status == Special_User || User_Status == Registerd_User)?@"custId":@"subno",
                                 [dictScanTender valueForKey:@"ImgId"],
                                 [dictScanTender valueForKey:@"ImgURL"],
                                 [[arrGroupIds objectAtIndex:i] objectForKey:@"groupid"],
                                 (User_Status == Special_User || User_Status == Registerd_User)?User_CustID:User_SubNo,
                                 [DELEGATE.dateFormatter_GroupTenderserver stringFromDate:[NSDate date]],
                                 [DELEGATE.dateFormatter_GroupTenderserver stringFromDate:[NSDate date]],
                                 @"Me"
                                 ]
             andCompletionBlock:^(BOOL success){
                 if(success){
                     
                     //   NSLog(@"Insert tblGroupTenders Successfully");
                     
                 }else{
                     //   NSLog(@"Insert tblGroupTenders Fail");
                 }
             }];
        }
    }
     [DELEGATE.dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    completionBlockmethod(YES);
    
}
-(void)RemoveScanGroupTender:(NSString *)imgid andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    
    [self executeUpdate:[NSString stringWithFormat:
                         @"UPDATE tblGroupScanTenders"
                         @" SET isDelete=1"
                         @" WHERE imgid = '%@' and %@ and groupId='%@'",imgid,[[CommonMethods sharedInstance] AppendsubnoORcustid],[DELEGATE.dict_GroupInfo valueForKey:@"groupId"]] andCompletionBlock:^(BOOL success){
        if(success){
            //NSLog(@"Delete Archive Tender Successfully");
            
        }else{
            //NSLog(@"Delete Archive Tender Fail");
            
        }
        completionBlockmethod(success);
    }];
    
}
#pragma mark - Comment Query
-(void)AddComments:(NSMutableArray *)arr_Comments DeletedCommentIds:(NSString *)str_deletedIDs andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{

    NSMutableArray *contacts = [NSMutableArray array];
    [[CommonMethods sharedInstance] getContactsFromAddressBook:^(BOOL success,id result){
        if(success){
            for (THContact *contact in result) {
                [contacts addObject:@{@"mobileno":[[[NSString stringWithFormat:@"%@",contact.phone] componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]]componentsJoinedByString:@""],
                                      @"name":[NSString stringWithFormat:@"%@",[contact fullName]]}];
            }
        }
    
    for (NSDictionary *dict in arr_Comments) {
        NSString *isViewed = @"0";
        NSString *contactName = [NSString stringWithFormat:@"%@",[[CommonMethods sharedInstance] getNameforContactNo:[dict valueForKey:@"MobileNo"] inArray:contacts]];
        if ([[dict valueForKey:@"MobileNo"] isEqualToString:User_Mobile_Number]) {
            contactName = @"Me";
            isViewed = @"1";
        }
        int commentId = [_db intForQuery:[NSString stringWithFormat:@"select count(commentId) from tblGroupComments where CommentId = '%@'", [dict valueForKey:@"CommentId"]]];
        if (commentId == 0) {
        [self executeUpdate:[NSString stringWithFormat:@"INSERT INTO tblGroupComments (commentId,tsrno, groupId ,%@ , number ,name, comment , commentDate,isViewed,isScanTender) VALUES ('%@', '%@', '%@', %@, '%@', '%@', '%@', '%@', '%@','%@') ",
                             (User_Status == Special_User || User_Status == Registerd_User)?@"custId":@"subno",
                             [dict valueForKey:@"CommentId"],
                             [dict valueForKey:@"SrNo"],
                             [dict valueForKey:@"GroupId"],
                             (User_Status == Special_User || User_Status == Registerd_User)?User_CustID:User_SubNo,
                             [dict valueForKey:@"MobileNo"],
                             contactName,
                             [[dict valueForKey:@"Comment"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"],
                             [dict valueForKey:@"EntryDate"],
                             isViewed,
                             [dict valueForKey:@"IsScanImage"]
                             ]
         andCompletionBlock:^(BOOL success){
             if(success){
                
                 //   NSLog(@"Insert tblGroupComments Successfully");
                 
             }else{
                 //   NSLog(@"Insert tblGroupComments Fail");
             }
         }];
       
    }
    }
        
    if (![str_deletedIDs isEmptyString]) {
        
    [self executeUpdate:[NSString stringWithFormat:
                         @"UPDATE tblGroupComments"
                         @" SET isDelete= 1"
                         @" WHERE CommentId IN (%@)",str_deletedIDs]
     andCompletionBlock:^(BOOL success){
         if(success){
             //NSLog(@"Delete tblGroupComments Successfully");
             
         }else{
             //NSLog(@"Delete tblGroupComments Fail");
             
         }
         
     }];
    }
    completionBlockmethod(YES);
    }];

}
-(void)ReadAllCommentsForGroupdId:(NSString *)groupId tsrno:(NSString *)tsrno isScanTender:(BOOL)isScanTender andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
   
    [self executeUpdate:[NSString stringWithFormat:
                         @"UPDATE tblGroupComments"
                         @" SET isViewed= 1"
                         @" WHERE groupId = '%@' and tsrno = '%@' and isScanTender = '%@' and %@",groupId,tsrno,(isScanTender)?@"1":@"0",[[CommonMethods sharedInstance]AppendsubnoORcustid]]
     andCompletionBlock:^(BOOL success){
         if(success){
             //NSLog(@"Update tblGroupComments Successfully");
             
         }else{
             //NSLog(@"Update tblGroupComments Fail");
             
         }
            completionBlockmethod(YES);
     }];
    
}
-(void)DeleteLocalCommentForCommentId:(NSString *)str_commentId andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    [self executeUpdate:[NSString stringWithFormat:
                         @"UPDATE tblGroupComments"
                         @" SET isDelete= 1"
                         @" WHERE CommentId = '%@'",str_commentId]
     andCompletionBlock:^(BOOL success){
         if(success){
             //NSLog(@"Delete tblGroupComments Successfully");
             
         }else{
             //NSLog(@"Delete tblGroupComments Fail");
             
         }
         completionBlockmethod(success);
     }];
}
#pragma mark - Broadcast Query Methods
-(void)CreateorUpdateAds:(NSMutableArray *)arr_ads andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    for (NSMutableDictionary *dict in arr_ads) {
        
        NSUInteger count = [_db intForQuery:[NSString stringWithFormat:@"select count(*) from tblAds Where id = '%@'",[dict valueForKey:@"MessageId"]]];
        if (count == 0) {
            [self executeUpdate:[NSString stringWithFormat:@"insert into tblAds (id,title,description,creationDate,userStatus,url) values('%@','%@','%@','%@','%@','%@')"
                                 ,[dict objectForKey:@"MessageId"],[[dict objectForKey:@"Title"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"],[[dict objectForKey:@"Body"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"],[DELEGATE.dateFormatter_server stringFromDate:[NSDate date]],[NSString stringWithFormat:@"%d",User_Status],[dict objectForKey:@"URL"]]
             andCompletionBlock:^(BOOL success){
                 if(success){
                     //  NSLog(@"Insert tblAds Successfully");
                 }else{
                     //  NSLog(@"Insert tblAds Fail");
                 }
             }];
            
        }else{
            [self executeUpdate:[NSString stringWithFormat:@"Update tblAds"
                                 @" SET title = '%@',"
                                 @" description = '%@',"
                                 @" creationDate = '%@',"
                                 @" userStatus= '%@',"
                                 @" url= '%@'"
                                 @" Where id= '%@'"
                                 ,[[dict objectForKey:@"Title"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"],[[dict objectForKey:@"Body"]stringByReplacingOccurrencesOfString:@"'" withString:@"''"],[DELEGATE.dateFormatter_server stringFromDate:[NSDate date]],[NSString stringWithFormat:@"%d",User_Status],[dict objectForKey:@"URL"],[dict objectForKey:@"MessageId"]]
             andCompletionBlock:^(BOOL success){
                 if(success){
                     //   NSLog(@"Update tblAds Successfully");
                 }else{
                     //   NSLog(@"Update tblAds Fail");
                 }
             }];
        }
    }
    
    
    
    completionBlockmethod(YES);
}
-(void)CloseAdsForAdId:(NSString *)adId andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
            [self executeUpdate:[NSString stringWithFormat:@"Update tblAds"
                                 @" SET isCheck= 1"
                                 @" Where id= '%@'"
                                 ,adId]
             andCompletionBlock:^(BOOL success){
                 if(success){
                   //  NSLog(@"Update tblAds Successfully");
                 }else{
                   //  NSLog(@"Update tblAds Fail");
                 }
                 completionBlockmethod(success);
             }];
}

-(void)DeleteAdsForAdId:(NSString *)adId andCompletionBlock:(void(^)(BOOL success))completionBlockmethod{
    
    [self executeUpdate:[NSString stringWithFormat:@"Update tblAds"
                         @" SET isDelete= 1"
                         @" Where id= '%@'"
                         ,adId]
     andCompletionBlock:^(BOOL success){
         if(success){
             NSLog(@"Update tblAds Successfully");
         }else{
             NSLog(@"Update tblAds Fail");
         }
         completionBlockmethod(success);
     }];
}
@end
