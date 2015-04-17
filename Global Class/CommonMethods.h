//
//  CommonMethods.h
//  TenderTiger
//
//  Created by ETL on 12/12/14.
//  Copyright (c) 2014 ETL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 
#import "JBWhatsAppActivity.h"
#import "ShareTenderGroupViewController.h"
#import "PagingViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
@interface CommonMethods : NSObject <EKEventEditViewDelegate>

+ (CommonMethods *)sharedInstance;

@property (nonatomic, strong) ShareTenderGroupViewController *shareingrp;
-(NSString *)UserQuerywithAnd;
-(NSString*)getSortKey;
-(NSString*)getOrderKey;
-(NSString*)getSyncKey;
-(NSString*)getSeenNotificationKey;
-(NSString*)AppendsubnoANDcustid;
-(NSString*)AppendsubnoORcustid;
-(void)GetHomeViewController:(void(^)(BOOL success,UIViewController *ViewController))completionBlockmethod;

-(void)ShareTender:(NSMutableDictionary *)dictTender onView:(UIView *)onView;
-(void)ShareScanTender:(UIImage *)imgShare onView:(UIView *)onView;
-(void)ShareTenderInGroup:(NSMutableDictionary *)dictTender;
-(void)ShareScanTenderInGroupWithImage:(UIImage *)img OrImageURL:(NSURL *)imgUrl imageid:(NSString *)imgid;

-(void)UpdateGlobalGroupDictionary;

-(void)goGallaryViewWithImage:(UIImage *)imgshare orImageURL:(NSURL *)imgURL;

-(void)GoTenderDetailwithArr_TsrNo:(NSMutableArray *)arr_TsrNo currentIndex:(int)currentIndex tenderType:(NSString *)TenderType;

-(NSString *)DocumentPathforTenderId:(NSString *)str_tsrNo;
-(void)OpenDocumentForUrl:(NSString *)UrlStr TenderId:(NSString *)str_tsrNo fileName:(NSString *)filename onView:(UIView *)onView;
@property (retain, nonatomic) UIDocumentInteractionController *documentController;

-(void)SyncTendersFromWebbyNotificationAndIncludeSynceDate:(BOOL)withSyncDate  andUploaddate:(NSString *)date;
-(void)SaveLastSyncronizeDate;

-(void)SyncGroupsandShowGroupTab:(BOOL)is_show;

-(void)SyncCommentsFromWebAndShowLoading:(BOOL)is_show andCompletionBlock:(void(^)(BOOL success))completionBlock;

-(void)GetPreferenceQueryFromWeb;

-(void)getCountryListFromWeb;

-(void)getBroadCastMessageFromServer:(void(^)(BOOL success))completionBlock;

-(void)ShareBroadCastMessage:(NSString *)message onView:(UIView *)onView;

-(void)LogOut;

-(void)OpenAppstore;

-(void)addEventWithStartDate:(NSDate*)startDate EndDate:(NSDate *)endDate Title:(NSString*)title notes:(NSString *)notes inLocation:(NSString*)location;

-(NSString*) deviceName;
-(void)showAlertWithTitle :(NSString *)title Message:(NSString *)messsage;
-(void)removeLocallyStoredData;

-(void)getContactsFromAddressBook:(void (^) (BOOL success,id result)) complitionBlock;
-(NSString *)getNameforContactNo:(NSString*)strMobile inArray:(NSMutableArray *)arrContacts;
-(void)SyncContacts:(void(^)(BOOL success))completionBlockmethod;

- (CGSize)screenSize;
-(CGSize)calculateSize:(NSString*)strText font:(UIFont*)fontType width:(CGFloat)lblMaxWidth;
-(NSString *)getBase64StringOfImage:(UIImage *)image;
-(NSInteger)MinutesBetweenFromDate:(NSDate *)from_Date toDate:(NSDate *)to_Date;
-(NSInteger)DaysBetweenFromDate:(NSDate *)from_Date toDate:(NSDate *)to_Date;
@end
