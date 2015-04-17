//
//  DatabaseHelper.h
//  TenderTiger
//
//  Created by ETL on 17/11/14.
//  Copyright (c) 2014 ETL. All rights reserved.
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
-(void)executeQuery:(NSString *)Query andCompletionBlock:(void(^)(FMResultSet *fResult))completionBlock;


-(void)fillCountryAndContinentsfromLocal;
-(void)fillCountryAndContinentsfromWeb:(NSMutableArray *)arr_List;
-(void)getContinentlist:(void(^)(NSMutableArray *result))completionBlock;
-(void)getcountriesForContinent:(NSString *)continent andCompletionBlock:(void(^)(NSMutableArray *result))completionBlock;
-(void)CreateOrUpdateTenders:(NSMutableArray *)arrWebTender andCompletionBlock:(void(^)(BOOL success , int newRecordCount))completionBlock ;
-(void)CreateOrUpdateHotTenders:(NSMutableArray *)arrHotTenders andCompletionBlock:(void(^)(BOOL success))completionBlock;
-(void)DeleteArchives:(void(^)(BOOL success))completionBlockmethod;
-(void)RemoveLiveOrSeenOrAchiveTender:(NSString *)str_TsrNo andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)LikeLiveOrSeenOrHotOrAchiveTender:(NSString *)str_TsrNo is_like:(BOOL)is_like andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)ViewTender:(NSString *)str_TsrNo andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;

-(void)CreateorUpdateGroup:(NSMutableArray *)arr_groups DeletePreviousGroups:(BOOL)is_delete andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)DeleteMemberFromGroup:(NSString *)groupID AppendString:(NSString *)AppendString andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)UpdateGroupName:(NSString *)name ForGroupId:(NSString *)grpID andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)CreateOrUpdateGroupTenders:(NSMutableArray *)arrGroupTenders GroupScanTenders:(NSMutableArray *)arrScanTenders andCompletionBlock:(void(^)(int newRecordCount,BOOL success))completionBlockmethod;
-(void)AddMySharedTenderToGroups:(NSMutableArray *)arrGroupIds Tender:(NSMutableDictionary *)dictTender andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)RemoveGroupTender:(NSString *)str_TsrNo andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)LikeGroupTender:(NSString *)str_TsrNo is_like:(BOOL)is_like andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)ViewGroupTender:(NSString *)str_TsrNo andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;

-(void)AddMySharedScanTenderToGroups:(NSMutableArray *)arrGroupIds ScanTender:(NSMutableDictionary *)dictScanTender andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)RemoveScanGroupTender:(NSString *)imgid andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;

-(void)AddComments:(NSMutableArray *)arr_Comments DeletedCommentIds:(NSString *)str_deletedIDs andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)ReadAllCommentsForGroupdId:(NSString *)groupId tsrno:(NSString *)tsrno isScanTender:(BOOL)isScanTender andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)DeleteLocalCommentForCommentId:(NSString *)str_commentId andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;

-(void)CreateorUpdateAds:(NSMutableArray *)arr_ads andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)CloseAdsForAdId:(NSString *)adId andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;
-(void)DeleteAdsForAdId:(NSString *)adId andCompletionBlock:(void(^)(BOOL success))completionBlockmethod;

@end
