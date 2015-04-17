//
//  AppDelegate.m
//  TenderTiger
//
//  Created by ETL on 13/11/14.
//  Copyright (c) 2014 ETL. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [AFNetworkReachabilityManager managerForDomain:Base_Url];
    _is_Internet = YES;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if ([AFNetworkReachabilityManager sharedManager].reachable){
            _is_Internet = YES;
        }else{
            _is_Internet = NO;
        }
    }];
    
    [[DatabaseHelper sharedInstance]openDB];
    [[DatabaseHelper sharedInstance]checkAndCreateTables];
    [[DatabaseHelper sharedInstance]fillCountryAndContinentsfromLocal];
    _gcmID = @"";
    
    _dateFormatter_server = [[NSDateFormatter alloc] init];
    [_dateFormatter_server setDateFormat:Date_Format_Server];
    [_dateFormatter_server setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
   // [_dateFormatter_server setTimeZone:[NSTimeZone localTimeZone]];
    
    _dateFormatter_app = [[NSDateFormatter alloc] init];
    [_dateFormatter_app setDateFormat:Date_Format_App];
    [_dateFormatter_app setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
  //  [_dateFormatter_app setTimeZone:[NSTimeZone localTimeZone]];
    
    _dateFormatter_GroupTenderserver = [[NSDateFormatter alloc] init];
    [_dateFormatter_GroupTenderserver setDateFormat:Date_Format_GroupTenderServer];
    [_dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
  //  [_dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone localTimeZone]];
    
    _dateFormatter_GroupTenderapp_Date = [[NSDateFormatter alloc] init];
    [_dateFormatter_GroupTenderapp_Date setDateFormat:Date_Format_GroupTenderApp_Date];
    [_dateFormatter_GroupTenderapp_Date setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
  //  [_dateFormatter_GroupTenderapp_Date setTimeZone:[NSTimeZone localTimeZone]];
    
    _dateFormatter_GroupTenderapp_Time = [[NSDateFormatter alloc] init];
    [_dateFormatter_GroupTenderapp_Time setDateFormat:Date_Format_GroupTenderApp_Time];
    [_dateFormatter_GroupTenderapp_Time setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
  //  [_dateFormatter_GroupTenderapp_Time setTimeZone:[NSTimeZone localTimeZone]];
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    ViewController *mainController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainController];
    navController.navigationBar.hidden = YES;
    if ([navController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navController.interactivePopGestureRecognizer.enabled = NO;
    }
    DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:navController];
    _menuController = rootController;
    
    RightSideMenuViewController *rightController = [[RightSideMenuViewController alloc] initWithNibName:@"RightSideMenuViewController" bundle:nil];
    rootController.rightViewController = rightController;
    self.window.rootViewController = rootController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
#ifdef __IPHONE_8_0
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil]];
#endif
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound)];
    }
    
    [[UIApplication sharedApplication]setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    [NSTimer scheduledTimerWithTimeInterval:300.0f
                                     target:self
                                   selector:@selector(syncGroupTendersinForeground)
                                   userInfo:nil
                                    repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:(SyncLoopTimeinMinutes*60)
                                     target:self
                                   selector:@selector(syncTendersinForeground)
                                   userInfo:nil
                                    repeats:YES];
    if (launchOptions != nil)
    {
    //Local Notification
        
        UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
        if (locationNotification)
        {
            [self HandleLocalNotification:locationNotification];
        }
// Push notification already working in every condition with didreceiveremotenotification method
        
//    //Push Notification
//        
//        NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//        if (userInfo != nil)
//        {
//            [self HandleRemoteNotification:userInfo];
//        }
    }
    
    
    
    // Sync Preference Query and Continent-Country Every Time
    [[CommonMethods sharedInstance]GetPreferenceQueryFromWeb];
  //  [[CommonMethods sharedInstance]getCountryListFromWeb];
    
        
    [self configureStore];
   
   
    

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    UIBackgroundTaskIdentifier backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
    }];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[DatabaseHelper sharedInstance]closeDB];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Push Notification Methods
#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
//    if ([identifier isEqualToString:@"declineAction"]){
//    }
//    else if ([identifier isEqualToString:@"answerAction"]){
//    }
}
#endif
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    
    NSString *deviceToken = [[[[devToken description]
                               stringByReplacingOccurrencesOfString:@"<"withString:@""]
                              stringByReplacingOccurrencesOfString:@">" withString:@""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    
    _gcmID = [[NSString alloc]initWithFormat:@"%@",deviceToken];
    if (!Already_Installed) {
        [[ModelClass sharedInstance]AppDownloadTrack:
         @{
           @"gcmid":DELEGATE.gcmID,
           @"appversion":App_Version,
           @"manufacturename":Manufacture_Name,
           @"username":@"",
           @"mobileno":@""
           } success:^(id result) {
               if ([[NSString stringWithFormat:@"%@",[result valueForKeyPath:@"AppDownloadTrackResult.SuccessMessage"]]caseInsensitiveCompare:@"Success"] == NSOrderedSame) {
                   [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Already_Installed"];
                   [[NSUserDefaults standardUserDefaults]synchronize];
               }
               
           }
         
            error:^(NSError *error) {
                                                   
                }];
    }
}
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    ////NSLog(@"%@",[error description]);
   
//    _gcmID = [[NSString alloc]initWithFormat:@"%@",@"f785938b2198dc782ccae92010bea37c3786d9395428bbbcbeb2967d64f18b15"];
//    _gcmID = [[NSString alloc]initWithFormat:@"%@",@"stgt123f785938b2198dc782ccae92010bea37c3786d9395428bbbcbeb2967d64f18b15"];
  _gcmID = @"1";
}
#pragma mark - Receive Notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
  //  NSLog(@"we get notification = %@",userInfo);
    
    int notification = [[userInfo valueForKeyPath:@"aps.no"]intValue];
    
    if(application.applicationState == UIApplicationStateActive) {
        
       /*-------------- Active -----------*/
        
        if (notification == Install_ButNotLogin) {
            [[CommonMethods sharedInstance]showAlertWithTitle:@"" Message:[NSString stringWithFormat:@"%@",[userInfo valueForKeyPath:@"aps.alert"]]];
        }
        
        if (notification == LogOut) {
            [UIAlertView showWithTitle:@"" message:[NSString stringWithFormat:@"%@",[userInfo valueForKeyPath:@"aps.alert"]] cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
             {
                 [[CommonMethods sharedInstance]LogOut];
                 [[CommonMethods sharedInstance]OpenAppstore];
             }];
            
        }
        
        if (notification == Version_Update) {
            [UIAlertView showWithTitle:@"" message:[NSString stringWithFormat:@"%@",[userInfo valueForKeyPath:@"aps.alert"]] cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"View"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
             {
                 if (buttonIndex == 1) {
                 [[CommonMethods sharedInstance]OpenAppstore];
                 }
             }];
            
            
        }
        if (notification == Statastics) {
            
            [UIAlertView showWithTitle:@"" message:[NSString stringWithFormat:@"%@",[userInfo valueForKeyPath:@"aps.alert"]] cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"View"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
             {
                 if (buttonIndex == 1) {
                     [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[userInfo valueForKeyPath:@"aps.link"]]]];
                 }
             }];
            
        }
        if (notification == Sync_Group) {
            [UIAlertView showWithTitle:@"" message:[NSString stringWithFormat:@"%@",[userInfo valueForKeyPath:@"aps.alert"]] cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"View"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
             {
                 if (buttonIndex == 1) {
                      [[CommonMethods sharedInstance] SyncGroupsandShowGroupTab:YES];
                 }else{
                     [[CommonMethods sharedInstance] SyncGroupsandShowGroupTab:NO];
                 }
             }];
           
        }
      
    } else {
        
        /*-------------- InActive -----------*/
        if (notification == Install_ButNotLogin) {
            [[CommonMethods sharedInstance]showAlertWithTitle:@"" Message:[NSString stringWithFormat:@"%@",[userInfo valueForKeyPath:@"aps.alert"]]];
        }
        if (notification == LogOut) {
            [[CommonMethods sharedInstance]LogOut];
            [[CommonMethods sharedInstance]OpenAppstore];
        }
        if (notification == Version_Update) {
            [[CommonMethods sharedInstance]OpenAppstore];
        }
        if (notification == Statastics) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[userInfo valueForKeyPath:@"aps.link"]]]];
        }
        if (notification == Sync_Group) {
            [[CommonMethods sharedInstance] SyncGroupsandShowGroupTab:YES];
        }
        
    }
    
    // Any state
    
    if (notification == Sync_Now) {
        [[CommonMethods sharedInstance]SyncTendersFromWebbyNotificationAndIncludeSynceDate:NO andUploaddate:@""];
    }
    if (notification == Prefrence_Query_Update) {
         [[CommonMethods sharedInstance]GetPreferenceQueryFromWeb];
    }
    if (notification == ContinentCountry_Update) {
        [[CommonMethods sharedInstance]getCountryListFromWeb];
    }
    if (notification == Broadcast_Message) {
        [[CommonMethods sharedInstance]getBroadCastMessageFromServer:^(BOOL success){
            [[CommonMethods sharedInstance]GetHomeViewController:^(BOOL success, UIViewController *viewController){
                if (success) {
                    [(HomeViewController *)viewController showAdsViewIfAdAvailable];
                }
            }];
        }];
        
    }
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
 
     completionHandler(UIBackgroundFetchResultNewData);
  //  [[CommonMethods sharedInstance]showAlertWithTitle:[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"aps"]] Message:@""];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
  //   NSLog(@"we get notification = %@",notification.userInfo);
    [self HandleLocalNotification:notification];
   
}
-(void)HandleLocalNotification:(UILocalNotification *)notification{
    [UIApplication sharedApplication] .applicationIconBadgeNumber = 0;
    if ([[NSString stringWithFormat:@"%@",[notification.userInfo valueForKey:@"type"]]isEqualToString:@"GroupTenders"])
    {
        [[CommonMethods sharedInstance]GetHomeViewController:^(BOOL success, UIViewController *viewController){
            if (success) {
                UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController.rootViewController;
                [menuController popToViewController:viewController animated:NO];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"SelectGroupTab" object:nil];
            }
            
        }];
    }
    if ([[NSString stringWithFormat:@"%@",[notification.userInfo valueForKey:@"type"]]isEqualToString:@"Tenders"])
    {
        [[CommonMethods sharedInstance]GetHomeViewController:^(BOOL success, UIViewController *viewController){
            if (success) {
                UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController.rootViewController;
                [menuController popToViewController:viewController animated:NO];
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateSegmentTitles" object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshScreen" object:nil];
        }];
    }
}
#pragma mark - Sync Tenders
-(void)syncTendersinForeground{
  
      NSString *maxDate = [[DatabaseHelper sharedInstance].db stringForQuery:[NSString stringWithFormat:@"select max(updatedate) FROM  tblTenders where %@",[[CommonMethods sharedInstance]AppendsubnoANDcustid]]];
   
//    if ([[CommonMethods sharedInstance]DaysBetweenFromDate:[self.dateFormatter_GroupTenderserver dateFromString:maxDate] toDate:[NSDate date]]==0 && User)
//    {
//        [[CommonMethods sharedInstance]SyncTendersFromWebbyNotificationAndIncludeSynceDate:YES andUploaddate:maxDate];
//    }
    
    if([[NSUserDefaults standardUserDefaults]valueForKey:[[CommonMethods sharedInstance]getSyncKey]] && User){
        if ([[CommonMethods sharedInstance]DaysBetweenFromDate:[self.dateFormatter_GroupTenderserver dateFromString:[[NSUserDefaults standardUserDefaults]valueForKey:[[CommonMethods sharedInstance]getSyncKey]]] toDate:[NSDate date]]==0)
        {
            [[CommonMethods sharedInstance]SyncTendersFromWebbyNotificationAndIncludeSynceDate:YES andUploaddate:maxDate];
        }
    }
    
}

#pragma mark - Background Call
-(void)syncGroupTendersinForeground{
    
    [self syncGroupTenders:^(int newRecordCount){
        if (newRecordCount >0) {
            AudioServicesPlaySystemSound (1007);
            [CMNavBarNotificationView notifyWithText:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] detail:[NSString stringWithFormat:@"%d new tender have been shared in groups.",newRecordCount] image:[UIImage imageNamed:@"AppIcon60x60"] duration:5.0 andTouchBlock:^(CMNavBarNotificationView *notificationView)
            {
                [[CommonMethods sharedInstance]GetHomeViewController:^(BOOL success, UIViewController *viewController){
                    if (success) {
                    
                    UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController.rootViewController;
                    [menuController popToViewController:viewController animated:NO];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"SelectGroupTab" object:nil];
                    }
                }];
            }];
            
    }
        
    } failure:^(NSError *error){
        
    }];
}


-(void)application:(UIApplication *)application performFetchWithCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
 //   NSLog(@"Background fetch started...");
    
    //---do background fetch here---
    // You have up to 30 seconds to perform the fetch
    
    [self syncGroupTenders:^(int newRecordCount){
    if (newRecordCount > 0) {
        
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate date];
        localNotification.alertBody = [NSString stringWithFormat:@"%d new tender have been shared in groups.",newRecordCount];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        localNotification.userInfo = @{@"type":@"GroupTenders"};
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.soundName =  UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        }
        
        completionHandler(UIBackgroundFetchResultNewData);
    } failure:^(NSError *error){
        
        completionHandler(UIBackgroundFetchResultNoData);
    }];
    
    
}
-(void)syncGroupTenders:(void (^) (int newRecordCount)) successBlock failure: (void (^) (NSError * error)) failureBlock{
    NSError *error;
    
    if(User && User_Mobile_Number.length > Min_Length_Mobile){
        [[ModelClass sharedInstance]GetGroupTenderListwithParameter:
         @{
           @"appuserid":User_App_User_Id,
           @"userstatus":[NSString stringWithFormat:@"%d",User_Status]
           }
        showLoading:NO success:^(id results){
            if ([[results valueForKeyPath:@"GetGroupTenderListResult.lstSharelist"] isKindOfClass:[NSArray class]] && [[results valueForKeyPath:@"GetGroupTenderListResult.lstScanImagelist"] isKindOfClass:[NSArray class]] )
            {
                [[DatabaseHelper sharedInstance]CreateOrUpdateGroupTenders:[results valueForKeyPath:@"GetGroupTenderListResult.lstSharelist"] GroupScanTenders:[results valueForKeyPath:@"GetGroupTenderListResult.lstScanImagelist"]  andCompletionBlock:^(int newRecordCount,BOOL success){
                    [[CommonMethods sharedInstance]UpdateGlobalGroupDictionary];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshGroup" object:nil];
                    successBlock(newRecordCount);
                }];
                
                
            }else{
                failureBlock(error);
            }
            
            [[ModelClass sharedInstance]AcknowledgementwithParameter:
             @{
               @"appuserid":User_App_User_Id,
               @"userstatus":[NSString stringWithFormat:@"%d",User_Status],
               }
                success:^(id results){
            } error:^(NSError *errors){
                failureBlock(errors);
            }];
            
            
        } error:^(NSError *errors){
            failureBlock(errors);
        }];
    }else{
        
        failureBlock(error);
    }
    
}

#pragma mark - Login Flow
-(void)goThroughLoginProcedure:(UINavigationController *)navigation{
    
    if (User) {
        switch (User_Status)
        {
            case Special_User:
                // Special User
                
                if (!User_Is_Form_Filled) {
                    //Show Contact Form
                    ContactFormViewController *goContact = [[ContactFormViewController alloc]initWithNibName:@"ContactFormViewController" bundle:nil];
                    [navigation pushViewController:goContact animated:YES];
                    
                }
                else if (!User_Is_Filter && [User_Query isEmptyString] && [User_Query_Display isEmptyString]){
                    // Show Filter View
                    FilterViewController *gofilter = [[FilterViewController alloc]initWithNibName:@"FilterViewController" bundle:nil];
                    gofilter.isFromLogin = YES;
                    [navigation pushViewController:gofilter animated:YES];
                    
                }
                else{
                    //Show Home Screen
                    [self goThroughHomeScreenFlow:navigation];
                }
                break;
            case Subscriber_User:
                //Subsciber
                //Show Home Screen
                [self goThroughHomeScreenFlow:navigation];
                break;
            case Expired_User:
                //Expired User
                //Show Home Screen
                [self goThroughHomeScreenFlow:navigation];
                break;
            case Registerd_User:
                //Registered User
                if (User_Category_Name.length > 0) {
                    [self goThroughHomeScreenFlow:navigation];
                }
                else if (User_Is_Switch_Profile) {
                    // My Categories
                    MyCategoriesViewController *gomyCat= [[MyCategoriesViewController alloc]initWithNibName:@"MyCategoriesViewController" bundle:nil];
                    [navigation pushViewController:gomyCat animated:YES];
                }
                else{
                    // Category List
                    CategoryListViewController *goCat = [[CategoryListViewController alloc]initWithNibName:@"CategoryListViewController" bundle:nil];
                    [navigation pushViewController:goCat animated:YES];
                }
                
                break;
                
        }
    }
}
-(void)goThroughHomeScreenFlow:(UINavigationController *)navigation{
    if (!Is_NewFeatures_Seen)
    {
        NewFeaturesViewController *goNewFeat = [[NewFeaturesViewController alloc]initWithNibName:@"NewFeaturesViewController" bundle:nil];
        goNewFeat.isFromLogin = YES;
        [navigation pushViewController:goNewFeat animated:YES];
    }
    else if(!Is_MobileVerification_Skipped && !User_Is_Mobile_Verified){
        MobileVerificationViewController *gomob = [[MobileVerificationViewController alloc]initWithNibName:@"MobileVerificationViewController" bundle:nil];
        gomob.isFromLogin = YES;
        [navigation pushViewController:gomob animated:YES];
    }
    else{
        HomeViewController *goHome = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
        [navigation pushViewController:goHome animated:YES];
        
    }
    
}

#pragma mark - In-App Purchase
- (void)configureStore
{
    const BOOL iOS7OrHigher = floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1;
    _receiptVerificator = iOS7OrHigher ? [[RMStoreAppReceiptVerificator alloc] init] : [[RMStoreTransactionReceiptVerificator alloc] init];
    [RMStore defaultStore].receiptVerificator = _receiptVerificator;
    
    _persistence = [[RMStoreKeychainPersistence alloc] init];
    [RMStore defaultStore].transactionPersistor = _persistence;
}


@end
