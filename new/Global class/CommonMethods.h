//
//  CommonMethods.h
//  ProcurementTiger
//
//  Created by ETL on 29/04/15.
//  Copyright (c) 2015 ETL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 
#import <sys/utsname.h> 
#import <CommonCrypto/CommonDigest.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "JBWhatsAppActivity.h"
@interface CommonMethods : NSObject <EKEventEditViewDelegate>

+ (CommonMethods *)sharedInstance;

-(void)SetupHeaderViewOf:(UIView *)headerView;

-(NSString *)GetSearchFields;

-(void)GetHomeViewController:(void(^)(BOOL success,UIViewController *ViewController))completionBlockmethod;

-(void)ShareTender:(NSMutableDictionary *)dictTender onView:(UIView *)onView;

-(NSString *)DocumentPathforTenderSrNO:(NSString *)str_srNo;
-(void)OpenDocumentForUrl:(NSString *)UrlStr TenderSrNO:(NSString *)str_srNo fileName:(NSString *)filename onView:(UIView *)onView;
@property (retain, nonatomic) UIDocumentInteractionController *documentController;

-(void)removeLocallyStoredData;

-(void)OpenAppstore;

-(void)addEventWithStartDate:(NSDate*)startDate EndDate:(NSDate *)endDate Title:(NSString*)title notes:(NSString *)notes inLocation:(NSString*)location;

- (NSString*) deviceName;

- (CGSize)screenSize;
-(CGSize)calculateSize:(NSString*)strText font:(UIFont*)fontType width:(CGFloat)lblMaxWidth;
-(NSInteger)DaysBetweenFromDate:(NSDate *)from_Date toDate:(NSDate *)to_Date;
@end
