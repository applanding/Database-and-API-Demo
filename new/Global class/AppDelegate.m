//
//  AppDelegate.m
//  TenderApps
//
//  Created by ETL on 19/08/15.
//  Copyright (c) 2015 ETL. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil]];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
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
    
    _dateFormatter_server = [[NSDateFormatter alloc] init];
    [_dateFormatter_server setDateFormat:Date_Format_Server];
    [_dateFormatter_server setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    _dateFormatter_app = [[NSDateFormatter alloc] init];
    [_dateFormatter_app setDateFormat:Date_Format_App];
    [_dateFormatter_app setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    _dateTimeFormatter_server = [[NSDateFormatter alloc] init];
    [_dateTimeFormatter_server setDateFormat:DateTime_Format_Server];
    [_dateTimeFormatter_server setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *mainController;
    // Override point for customization after application launch.
    if (User) {
        mainController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    }else{
        mainController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    }
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[DatabaseHelper sharedInstance]closeDB];
}
#pragma mark - Push Notification Methods
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    
    NSString *deviceToken = [[[[devToken description]
                               stringByReplacingOccurrencesOfString:@"<"withString:@""]
                              stringByReplacingOccurrencesOfString:@">" withString:@""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    _deviceToken = [[NSString alloc]initWithFormat:@"%@",deviceToken];
    
    if (!Already_Installed) {
        [self callDownloadTrackAPI];
    }else{
        [self callAppLaunchAPI];
    }
    
}
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    ////NSLog(@"%@",[error description]);
    _deviceToken = @"0000001";
    if (!Already_Installed) {
        [self callDownloadTrackAPI];
    }else{
        [self callAppLaunchAPI];
    }
    
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //  NSLog(@"we get notification = %@",userInfo);
    //int notification = [[userInfo valueForKeyPath:@"aps.no"]intValue];
    if(application.applicationState == UIApplicationStateActive) {
        
        /*-------------- Active -----------*/
      
    } else {
        
        /*-------------- InActive -----------*/
        
    }
    
    // Any state
    
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    completionHandler(UIBackgroundFetchResultNewData);
    //  [[CommonMethods sharedInstance]showAlertWithTitle:[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"aps"]] Message:@""];
}
#pragma mark - DownloadTrack
-(void)callDownloadTrackAPI{
    [[APIModelClass sharedInstance]AppDownloadTrack:
     @{
       @"imeino":[NSString stringWithFormat:@"%@",_deviceToken],
       @"notificationtoken":[NSString stringWithFormat:@"%@",_deviceToken],
       @"manufacturer":Manufacture_Name,
       @"modelname":Model_Name,
       @"osname":OS_Name,
       @"osversion":OS_Version,
       @"userappversion":App_Version,
       @"countryname":Country_Code,
       @"subdomainid":SubDomainID
       } success:^(id result) {
           if ([[result valueForKey:@"status"]boolValue]) {
               [[NSUserDefaults standardUserDefaults]setBool:YES forKey:[NSString stringWithFormat:@"Already_Installed%@",App_Version]];
               [[NSUserDefaults standardUserDefaults]synchronize];
           }else{
               UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController;
               [menuController.view makeToast:[NSString stringWithFormat:@"%@",[result valueForKey:@"message"]]];
           }
           //               if ([[NSString stringWithFormat:@"%@",[result valueForKeyPath:@"AppDownloadTrackResult.SuccessMessage"]]caseInsensitiveCompare:@"Success"] == NSOrderedSame) {
           //
           //               }
           
       }
        error:^(NSError *error) {
    }];
}
#pragma mark - AppLaunch
-(void)callAppLaunchAPI{
    
    [[APIModelClass sharedInstance]AppLaunchTrack:
    @{@"appuserid":AppUserID,
      @"imeino":[NSString stringWithFormat:@"%@",_deviceToken],
      @"userappversion":App_Version,
      @"subdomainid":SubDomainID
    }
    success:^(id result){
        if ([[result valueForKey:@"status"]boolValue]) {
            UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController;
            if(![[result valueForKey:@"isupdatedversion"]boolValue]){
                if (User) {
                    [[CommonMethods sharedInstance] removeLocallyStoredData];
                    LoginViewController *gologin = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                    [gologin.view makeToast:@"Logout Successfully"];
                    [menuController pushViewController:gologin animated:YES];

                }
                [RMUniversalAlert showAlertInViewController:menuController withTitle:@"" message:[NSString stringWithFormat:@"%@",[result valueForKey:@"message"]] cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:nil tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex){
                
                    [[CommonMethods sharedInstance]OpenAppstore];
                    
                }];
            }
        }
    }error:^(NSError *error){

    }];

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
