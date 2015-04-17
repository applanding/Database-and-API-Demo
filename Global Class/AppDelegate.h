//
//  AppDelegate.h
//  TenderTiger
//
//  Created by ETL on 13/11/14.
//  Copyright (c) 2014 ETL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworkActivityIndicatorManager.h"
#import <sys/utsname.h>

#import "DDMenuController.h"
#import "ViewController.h"
#import "RightSideMenuViewController.h"
#import "FilterViewController.h"
#import "NewFeaturesViewController.h"
#import "MobileVerificationViewController.h"
#import "MyCategoriesViewController.h"
#import "HomeViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import "THContact.h"
#import "CMNavBarNotificationView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "RMStore.h"
#import "RMStoreKeychainPersistence.h"
#import "RMStoreAppReceiptVerificator.h"
#import "RMStoreTransactionReceiptVerificator.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    id<RMStoreReceiptVerificator> _receiptVerificator;
    RMStoreKeychainPersistence *_persistence;

}

@property (assign, nonatomic) BOOL is_Internet;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDMenuController *menuController;
@property (retain, nonatomic) NSString *gcmID;
@property (retain, nonatomic) NSDateFormatter *dateFormatter_server;
@property (retain, nonatomic) NSDateFormatter *dateFormatter_app;
@property (retain, nonatomic) NSDateFormatter *dateFormatter_GroupTenderserver;
@property (retain, nonatomic) NSDateFormatter *dateFormatter_GroupTenderapp_Date;
@property (retain, nonatomic) NSDateFormatter *dateFormatter_GroupTenderapp_Time;
@property (assign, nonatomic) BOOL is_Searching;
@property (retain, nonatomic) NSString *txt_Search;
@property (retain,nonatomic) NSMutableDictionary *dict_GroupInfo;
@property (assign, nonatomic) BOOL Refresh_List;
@property (assign, nonatomic) BOOL Refresh_Tender;
@property (retain, nonatomic) NSString *str_tsrNoOfCommentlist;
@property (assign,nonatomic) bool isScanTender;
-(void)syncGroupTendersinForeground;

-(void)goThroughLoginProcedure:(UINavigationController *)navigation;
-(void)goThroughHomeScreenFlow:(UINavigationController *)navigation;

@end

