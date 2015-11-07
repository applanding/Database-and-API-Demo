//
//  AppDelegate.h
//  TenderApps
//
//  Created by ETL on 19/08/15.
//  Copyright (c) 2015 ETL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworkActivityIndicatorManager.h"
#import "DDMenuController.h"
#import "LoginViewController.h"
#import "RightSideMenuViewController.h"
#import "RMStore.h"
#import "RMStoreKeychainPersistence.h"
#import "RMStoreAppReceiptVerificator.h"
#import "RMStoreTransactionReceiptVerificator.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    id<RMStoreReceiptVerificator> _receiptVerificator;
    RMStoreKeychainPersistence *_persistence;

}

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) BOOL is_Internet;
@property (strong, nonatomic) DDMenuController *menuController;
@property (retain, nonatomic) NSString *deviceToken;
@property (assign, nonatomic) BOOL is_Searching;
@property (retain, nonatomic) NSString *txt_Search;
@property (retain, nonatomic) NSDateFormatter *dateFormatter_server;
@property (retain, nonatomic) NSDateFormatter *dateFormatter_app;
@property (retain, nonatomic) NSDateFormatter *dateTimeFormatter_server;
@end

