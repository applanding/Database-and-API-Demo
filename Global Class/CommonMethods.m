//
//  CommonMethods.m
//  TenderTiger
//
//  Created by ETL on 12/12/14.
//  Copyright (c) 2014 ETL. All rights reserved.
//

#import "CommonMethods.h"

@implementation CommonMethods

+ (CommonMethods *)sharedInstance
{
    static CommonMethods *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}
#pragma mark - Global Definations
-(NSString*)AppendsubnoANDcustid
{
    return [NSString stringWithFormat:@"subno = '%@' and custId = '%@'",User_SubNo,User_CustID];
}

-(NSString*)AppendsubnoORcustid
{
    if (User_Status == Special_User || User_Status == Registerd_User)
        return [NSString stringWithFormat:@"custId ='%@'",User_CustID];
    else
        return [NSString stringWithFormat:@"subno = '%@'",User_SubNo];
}
#pragma mark - Sort & order methods
-(NSString*)getSortKey
{
    if (User_CustID!=nil && ![User_CustID isEqualToString:@"0"])
    {
        ////NSLog(@"custsubkey=%@",[NSString stringWithFormat:@"%@%@",[self getSubNo],[self getCustID]]);
        return  [NSString stringWithFormat:@"sortby%@%@",User_SubNo,User_CustID];
    }
    else
    {
        ////NSLog(@"subkey=%@",[self getSubNo]);
        return [NSString stringWithFormat:@"sortby%@",User_SubNo];
    }
    
}
-(NSString*)getOrderKey
{
    if (User_CustID!=nil && ![User_CustID isEqualToString:@"0"])
    {
        ////NSLog(@"custsubkey=%@",[NSString stringWithFormat:@"%@%@",[self getSubNo],[self getCustID]]);
        return  [NSString stringWithFormat:@"orderby%@%@",User_SubNo,User_CustID];
    }
    else
    {
        ////NSLog(@"subkey=%@",[self getSubNo]);
        return [NSString stringWithFormat:@"orderby%@",User_SubNo];
    }
    
}
-(NSString*)getSyncKey
{
    if (User_CustID!=nil && ![User_CustID isEqualToString:@"0"])
    {
        ////NSLog(@"custsubkey=%@",[NSString stringWithFormat:@"%@%@",[self getSubNo],[self getCustID]]);
        return  [NSString stringWithFormat:@"syncby%@%@",User_SubNo,User_CustID];
    }
    else
    {
        ////NSLog(@"subkey=%@",[self getSubNo]);
        return [NSString stringWithFormat:@"syncby%@",User_SubNo];
    }
    
}
-(NSString*)getSeenNotificationKey
{
    if (User_CustID!=nil && ![User_CustID isEqualToString:@"0"])
    {
        ////NSLog(@"custsubkey=%@",[NSString stringWithFormat:@"%@%@",[self getSubNo],[self getCustID]]);
        return  [NSString stringWithFormat:@"seenby%@%@",User_SubNo,User_CustID];
    }
    else
    {
        ////NSLog(@"subkey=%@",[self getSubNo]);
        return [NSString stringWithFormat:@"seenby%@",User_SubNo];
    }
    
}
-(NSString *)UserQuerywithAnd{
    
    NSString *str_User_Query = [NSString stringWithFormat:@"%@",User_Query];
    if ( ![str_User_Query isEmptyString])
    {
        if (![str_User_Query hasPrefix:@"and"])
            str_User_Query = [NSString stringWithFormat:@"and %@",str_User_Query];
    }
    return [str_User_Query stringByReplacingOccurrencesOfString:@"tenderValueFull" withString:@"CAST(tenderValueFull AS INTEGER)"];
    
}
#pragma mark - Get HomeViewController

-(void)GetHomeViewController:(void(^)(BOOL success,UIViewController *ViewController))completionBlockmethod{
    UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController.rootViewController;
    for(UIViewController *viewController in [menuController.viewControllers reverseObjectEnumerator]){
        if ([viewController isKindOfClass:[HomeViewController class]]) {
            completionBlockmethod(YES,viewController);
            break;
        }
    }
    completionBlockmethod(NO,nil);
}
#pragma mark Share Tender
-(void)ShareTender:(NSMutableDictionary *)dictTender onView:(UIView *)onView{
    NSString *strTenderValue = [dictTender valueForKey:@"tenderValue"];
    if ([strTenderValue isEmptyString])
        strTenderValue=@"";
    else
        strTenderValue = [NSString stringWithFormat:@"of %@ %@",[dictTender valueForKey:@"currency"],[dictTender valueForKey:@"tenderValue"]];
    
    NSString *strEmail = @"";
    NSString *tenderName = @"";
    if (User_Status == Special_User)
    {
        
        strEmail = [NSString stringWithFormat:@"and login with %@ & password-tendertiger (lowercase)and search for Tender ID  %@.",User_Email,[dictTender valueForKey:@"refno"]];
    }
    if (User_Status == Subscriber_User){
       tenderName = [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"company"]];
    }
    else{
        tenderName = [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"department"]];
    }
    
   
    
    NSString *textToShare = [NSString stringWithFormat:@"%@ has published tender %@ for %@ in %@/%@/%@\n%@ %@ For more info, visit http://www.m.tendertiger.com/tender/%@",tenderName,strTenderValue,[[dictTender valueForKey:@"tenderdetail"]stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"],[dictTender valueForKey:@"city"],[dictTender valueForKey:@"state"],[dictTender valueForKey:@"country"],Share_Tender_Msg,strEmail,[dictTender valueForKey:@"refno"]];
 
    WhatsAppMessage *whatsappMsg = [[WhatsAppMessage alloc] initWithMessage:textToShare forABID:@""];
    NSArray *applicationActivities = @[[[JBWhatsAppActivity alloc] init]];
    NSArray *arrayOfActivityItems = [NSArray arrayWithObjects:textToShare,whatsappMsg, nil];
    // Display the view controller
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems: arrayOfActivityItems applicationActivities:applicationActivities] ;
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll, UIActivityTypePrint,UIActivityTypeCopyToPasteboard, UIActivityTypePostToWeibo,
                                         UIActivityTypeAirDrop,UIActivityTypeAddToReadingList];
    
    UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController;
    if (IS_IOS8_OR_LATER && !IPHONE) {
        activityVC.popoverPresentationController.sourceView = onView;
    }
   [menuController presentViewController:activityVC animated:YES completion:nil];
    //if iPad
    [activityVC setCompletionHandler:^(NSString *activityType, BOOL completed)
     {
      //   NSLog(@"Activity = %@",activityType);
      //   NSLog(@"Completed Status = %d",completed);
         
         if (completed)
         {
             //             UIAlertView *objalert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Posting was success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             //             [objalert show];
             //             objalert = nil;
         }else
         {
             //             UIAlertView *objalert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Posting was not successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             //             [objalert show];
             //             objalert = nil;
         }
     }];
}
-(void)ShareScanTender:(UIImage *)imgShare onView:(UIView *)onView{
    WhatsAppMessage *whatsappMsg = [[WhatsAppMessage alloc] initWithMessage:Share_Tender_Msg forABID:@""];
    NSArray *applicationActivities = @[[[JBWhatsAppActivity alloc] init]];
    NSArray *arrayOfActivityItems = [NSArray arrayWithObjects:imgShare,Share_Tender_Msg,whatsappMsg, nil];
    // Display the view controller
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems: arrayOfActivityItems applicationActivities:applicationActivities] ;
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll, UIActivityTypePrint,UIActivityTypeCopyToPasteboard, UIActivityTypePostToWeibo,
                                         UIActivityTypeAirDrop,UIActivityTypeAddToReadingList];
    
    UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController;
    if (IS_IOS8_OR_LATER && !IPHONE) {
        activityVC.popoverPresentationController.sourceView = onView;
    }
    [menuController presentViewController:activityVC animated:YES completion:nil];
    //if iPad
    [activityVC setCompletionHandler:^(NSString *activityType, BOOL completed)
     {
         //   NSLog(@"Activity = %@",activityType);
         //   NSLog(@"Completed Status = %d",completed);
         
         if (completed)
         {
             //             UIAlertView *objalert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Posting was success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             //             [objalert show];
             //             objalert = nil;
         }else
         {
             //             UIAlertView *objalert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Posting was not successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             //             [objalert show];
             //             objalert = nil;
         }
     }];
}
-(void)ShareTenderInGroup:(NSMutableDictionary *)dictTender{
    _shareingrp = [[ShareTenderGroupViewController alloc]initWithNibName:@"ShareTenderGroupViewController" bundle:nil];
    _shareingrp.dictTender = dictTender;
    [_shareingrp.view setFrame:CGRectMake(0, 0, [self screenSize].width, [self screenSize].height)];
    
    [UIView transitionWithView:DELEGATE.menuController.rootViewController.view duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve //change to whatever animation you like
                    animations:^ { [DELEGATE.menuController.rootViewController.view addSubview:_shareingrp.view]; }
                    completion:nil];
    
    //[DELEGATE.menuController.rootViewController.view addSubview:_shareingrp.view];
}
-(void)ShareScanTenderInGroupWithImage:(UIImage *)img OrImageURL:(NSURL *)imgUrl imageid:(NSString *)imgid{
    _shareingrp = [[ShareTenderGroupViewController alloc]initWithNibName:@"ShareTenderImageGroupViewController" bundle:nil];
    _shareingrp.img_Share = img;
    _shareingrp.is_ImageShare = YES;
    _shareingrp.imgid = [NSString stringWithFormat:@"%@",imgid];
    _shareingrp.imgURL = imgUrl;
    [_shareingrp.view setFrame:CGRectMake(0, 0, [self screenSize].width, [self screenSize].height)];
    
    [UIView transitionWithView:DELEGATE.menuController.rootViewController.view duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve //change to whatever animation you like
                    animations:^ { [DELEGATE.menuController.rootViewController.view addSubview:_shareingrp.view]; }
                    completion:nil];
    
    //[DELEGATE.menuController.rootViewController.view addSubview:_shareingrp.view];
}

#pragma mark - Global Group Dictionary
-(void)UpdateGlobalGroupDictionary{
    int countofTender = [[DatabaseHelper sharedInstance].db intForQuery:[NSString stringWithFormat:@"select count(*) from tblGroupTenders where groupId = '%@' and isDelete = '0' and %@",[DELEGATE.dict_GroupInfo valueForKey:@"groupId"],[self AppendsubnoORcustid]]];
    int countofScanTender = [[DatabaseHelper sharedInstance].db intForQuery:[NSString stringWithFormat:@"select count(*) from tblGroupScanTenders where groupId = '%@' and isDelete = '0' and %@",[DELEGATE.dict_GroupInfo valueForKey:@"groupId"],[self AppendsubnoORcustid]]];
    
    if (countofTender == 0){
        [DELEGATE.dict_GroupInfo setObject:[NSString stringWithFormat:@"%@",[DELEGATE.dict_GroupInfo valueForKey:@"name"]] forKey:@"displaygroupname"];
    }
    else {
        [DELEGATE.dict_GroupInfo setObject:[NSString stringWithFormat:@"%@ (%d)",[DELEGATE.dict_GroupInfo valueForKey:@"name"],countofTender] forKey:@"displaygroupname"];
    }
    if ((countofScanTender + countofTender) ==0) {
        [DELEGATE.dict_GroupInfo setObject:[DELEGATE.dict_GroupInfo valueForKey:@"name"] forKey:@"displaygroupnameAllCount"];
    }else{
        [DELEGATE.dict_GroupInfo setObject:[NSString stringWithFormat:@"%@ (%d)",[DELEGATE.dict_GroupInfo valueForKey:@"name"],countofScanTender+countofTender] forKey:@"displaygroupnameAllCount"];
    }
    
    if (countofScanTender == 0) {
        [DELEGATE.dict_GroupInfo setObject:[DELEGATE.dict_GroupInfo valueForKey:@"name"] forKey:@"displaygroupnameScanTenderCount"];
    }else{
        [DELEGATE.dict_GroupInfo setObject:[NSString stringWithFormat:@"%@ (%d)",[DELEGATE.dict_GroupInfo valueForKey:@"name"],countofScanTender] forKey:@"displaygroupnameScanTenderCount"];
    }
    [DELEGATE.dict_GroupInfo setObject:[NSString stringWithFormat:@"%d",countofScanTender] forKey:@"ScanTenderCount"];
    [DELEGATE.dict_GroupInfo setObject:[NSString stringWithFormat:@"%d",countofTender] forKey:@"TenderCount"];
    
}
#pragma mark - Gallery View
-(void)goGallaryViewWithImage:(UIImage *)imgshare orImageURL:(NSURL *)imgURL{
    UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController;
    FSBasicImage *firstPhoto;
    if (imgshare) {
        firstPhoto = [[FSBasicImage alloc]initWithImage:imgshare];
    }else{
        firstPhoto = [[FSBasicImage alloc] initWithImageURL:imgURL name:@""];
    }
    
        FSBasicImageSource *photoSource = [[FSBasicImageSource alloc] initWithImages:@[firstPhoto]];
        FSImageViewerViewController *imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imageViewController];
    [menuController presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Tender Detail
-(void)GoTenderDetailwithArr_TsrNo:(NSMutableArray *)arr_TsrNo currentIndex:(int)currentIndex tenderType:(NSString *)TenderType{
    UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController;
    PagingViewController *tender = [[PagingViewController alloc]initWithNibName:@"PagingViewController" bundle:nil];
    tender.currentIndex = currentIndex;
    tender.arr_TsrNo = arr_TsrNo;
    tender.str_tenderType = [NSString stringWithFormat:@"%@",TenderType];
    [menuController pushViewController:tender animated:YES];
}
#pragma mark - Document Download And View
-(NSString *)DocumentPathforTenderId:(NSString *)str_tsrNo{
    
    NSString *dataPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"Downloads/%@",str_tsrNo]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:nil]; //Create folder
    }
    
    return dataPath;
}

-(void)OpenDocumentForUrl:(NSString *)UrlStr TenderId:(NSString *)str_tsrNo fileName:(NSString *)filename onView:(UIView *)onView{
    
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@",[self DocumentPathforTenderId:str_tsrNo],filename];
     CGRect rectForAppearing = [onView.superview convertRect:onView.frame toView:DELEGATE.menuController.rootViewController.view];
    if ([[NSFileManager defaultManager]fileExistsAtPath:fullPath]) {
        _documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:fullPath]];
        dispatch_async(dispatch_get_main_queue(), ^() {
        [_documentController  presentOptionsMenuFromRect:rectForAppearing inView:DELEGATE.menuController.rootViewController.view animated:YES];
        });
        return;
       
        
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:DELEGATE.window animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Downloading";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",UrlStr]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:fullPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)
     {
         hud.progress = ((float)totalBytesRead/(float)totalBytesExpectedToRead);
         //  NSLog(@"bytesRead: %u, totalBytesRead: %lld, totalBytesExpectedToRead: %lld", bytesRead, totalBytesRead, totalBytesExpectedToRead);
     }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"RES: %@", [[[operation response] allHeaderFields] description]);
        [hud hide:YES];
        
        _documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:fullPath]];
    //   [_documentController presentOptionsMenuFromRect:CGRectZero inView:DELEGATE.menuController.rootViewController.view animated:YES];
        dispatch_async(dispatch_get_main_queue(), ^() {
            [_documentController  presentOptionsMenuFromRect:rectForAppearing inView:DELEGATE.menuController.rootViewController.view animated:YES];
        });

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //    NSLog(@"ERR: %@", [error description]);
        [[NSFileManager defaultManager]removeItemAtPath:fullPath error:nil];
        [hud hide:YES];
        [DELEGATE.window makeToast:Network_Error_Msg];
    }];
    [operation start];
}
#pragma mark - Sync Tenders from Push or Time Interval

-(void)SyncTendersFromWebbyNotificationAndIncludeSynceDate:(BOOL)withSyncDate andUploaddate:(NSString *)date{
    
    
    NSDictionary *dict;
    if (withSyncDate) {
        dict =     @{@"ismore":@"1",
                     @"appuserid":User_App_User_Id,
                     @"type":@"fresh",
                     @"startrow":@"1",
                     @"userstatus":[NSString stringWithFormat:@"%d",User_Status],
                     @"subno":User_SubNo,
                     @"uploadeddate":[NSString stringWithFormat:@"%@",date]
                     };
    }else{
        dict = @{@"ismore":@"1",
                 @"appuserid":User_App_User_Id,
                 @"type":@"fresh",
                 @"startrow":@"1",
                 @"userstatus":[NSString stringWithFormat:@"%d",User_Status],
                 @"subno":User_SubNo
                 };
    }
    
    [[ModelClass sharedInstance]GetTenderswithParameter:dict
    success:^(id result)
     {
         if ([[result valueForKeyPath:@"GetTendersResult.ListTenderBrief"]count]>0) {
             
             [[DatabaseHelper sharedInstance]CreateOrUpdateTenders:[result valueForKeyPath:@"GetTendersResult.ListTenderBrief"]
            andCompletionBlock:^(BOOL success,int newTenderCount){
                if (newTenderCount > 0 && [UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
                    
                    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
                    localNotification.fireDate = [NSDate date];
                    localNotification.alertBody = [NSString stringWithFormat:@"%d New Tenders Found.",newTenderCount];
                    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
                    localNotification.userInfo = @{@"type":@"Tenders"};
                    localNotification.timeZone = [NSTimeZone defaultTimeZone];
                    localNotification.soundName =  UILocalNotificationDefaultSoundName;
                    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                }
                if (newTenderCount > 0 && [UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
                   
                    [DELEGATE.window makeToast:[NSString stringWithFormat:@"%d New Tenders Found.", newTenderCount] duration:CSToastDefaultDuration position:CSToastPositionBottom title:@"Sync Completed"];
                }
                [self GetHomeViewController:^(BOOL success, UIViewController *viewController){
                    if (success) {
                        [(HomeViewController *)viewController setSegmentTitles];
                    }
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateSegmentTitles" object:nil];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshScreen" object:nil];
                }];
            }];
         }
         [self SaveLastSyncronizeDate];
     } error:^(NSError *error){
         
     }];
}
-(void)SaveLastSyncronizeDate{
    
 //   [DELEGATE.dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone localTimeZone]];
    [[NSUserDefaults standardUserDefaults]setValue:[DELEGATE.dateFormatter_GroupTenderserver stringFromDate:[NSDate date]] forKey:[self getSyncKey]];
    [[NSUserDefaults standardUserDefaults]synchronize];
 //   [DELEGATE.dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
}
#pragma mark - Sync Groups
-(void)SyncGroupsandShowGroupTab:(BOOL)is_show{
    
    [[ModelClass sharedInstance]GroupListwithParameter:
     @{
       @"appuserid":User_App_User_Id,
       @"userstatus":[NSString stringWithFormat:@"%d",User_Status]
       } showLoading:NO success:
     ^(id result){
         if ([[result objectForKey:@"GetGroupListResult"] isKindOfClass:[NSArray class]])
         {
             [[DatabaseHelper sharedInstance]CreateorUpdateGroup:[result objectForKey:@"GetGroupListResult"] DeletePreviousGroups:YES
                andCompletionBlock:^(BOOL success){
                   
                    [self GetHomeViewController:^(BOOL success, UIViewController *viewController){
                        if (success && is_show) {
                            UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController.rootViewController;
                            [menuController popToViewController:viewController animated:NO];
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"SelectGroupTab" object:nil];
                        }
                         [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateSegmentTitles" object:nil];
                          [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshGroup" object:nil];
                    }];
                    [DELEGATE syncGroupTendersinForeground];
                }];
         }
     } error:^(NSError *error){
     }];
    
}
#pragma mark - Sync Comments
-(void)SyncCommentsFromWebAndShowLoading:(BOOL)is_show andCompletionBlock:(void(^)(BOOL success))completionBlock {
  
     int maxCommentId = [[DatabaseHelper sharedInstance].db intForQuery:[NSString stringWithFormat:@"select max(commentId) FROM  tblGroupComments Where %@",[self AppendsubnoORcustid]]];
    [[ModelClass sharedInstance]GetCommentswithParameter:
     @{@"appuserid":User_App_User_Id,
       @"userstatus":[NSString stringWithFormat:@"%d",User_Status],
       @"mobileno":User_Mobile_Number,
       @"maxcommentid":[NSString stringWithFormat:@"%d",maxCommentId]
       } showLoading:is_show success:^(id results){
      
           if ([[results valueForKeyPath:@"GetTenderCommentsResult.lstComments"]isKindOfClass:[NSArray class]]) {
               [[DatabaseHelper sharedInstance]AddComments:[results valueForKeyPath:@"GetTenderCommentsResult.lstComments"] DeletedCommentIds:[results valueForKeyPath:@"GetTenderCommentsResult.DeletedCommentIds"] andCompletionBlock:^(BOOL success){
                   completionBlock(success);
               }];
           }
       } error:^(NSError *error){
           completionBlock(NO);
       }];
}

#pragma mark - Sync Query
-(void)GetPreferenceQueryFromWeb{
    if (User) {
    [[ModelClass sharedInstance]GetPreferenceQuerywithParameter:
    @{
      @"appuserid":User_App_User_Id,
      @"userstatus":[NSString stringWithFormat:@"%d",User_Status],
      @"subno":User_SubNo
      }
    success:^(id result){
        if ([[result objectForKey:@"GetPreferenceQueryResult"] isKindOfClass:[NSDictionary class]])
        {
           
            if (![[[result valueForKey:@"GetPreferenceQueryResult"] objectForKey:@"Query"] isEmptyString] && ![[[result valueForKey:@"GetPreferenceQueryResult"] objectForKey:@"QueryTextDisplay"] isEmptyString])
            {
                
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:User];
                [dict setValue:[NSString stringWithFormat:@"%@",[[result valueForKey:@"GetPreferenceQueryResult"] valueForKey:@"Query"]] forKey:@"Query"];
                [dict setValue:[NSString stringWithFormat:@"%@",[[result valueForKey:@"GetPreferenceQueryResult"] valueForKey:@"QueryTextDisplay"]] forKey:@"QueryTextDisplay"];
                [dict setValue:[NSString stringWithFormat:@"%@",[[result valueForKey:@"GetPreferenceQueryResult"] valueForKey:@"Searchfor"]] forKey:@"Searchfor"];
                
                [[NSUserDefaults standardUserDefaults]setValue:dict forKey:@"User"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            
        }
        
} error:^(NSError *error){

}];
    }
}

#pragma makr Sync Country and Continent
-(void)getCountryListFromWeb{
    [[ModelClass sharedInstance]GetCountryList:
     ^(id result){
         if ([[result valueForKey:@"GetCountryListResult"] isKindOfClass:[NSArray class]])
         {
             if ([[result valueForKey:@"GetCountryListResult"]count]>0)
             {
                 [[DatabaseHelper sharedInstance]fillCountryAndContinentsfromWeb:[result valueForKey:@"GetCountryListResult"]];
             
             }
     }
     }
    error:^(NSError *error){
    }];
}

#pragma mark - Sync Messages
-(void)getBroadCastMessageFromServer:(void(^)(BOOL success))completionBlock{
    
    if(User){
    int maxAdId = [[DatabaseHelper sharedInstance].db intForQuery:[NSString stringWithFormat:@"select max(id) FROM  tblAds"]];
    
    [[ModelClass sharedInstance]GetBrodcastMessagewithParameter:
     @{@"appversion":App_Version,
       @"userstatus":[NSString stringWithFormat:@"%d",User_Status],
       @"manufacturename":Manufacture_Name,
       @"messageid":[NSString stringWithFormat:@"%d",maxAdId]
       }
                                                        success:
     ^(id results){
         if ([[NSString stringWithFormat:@"%@",[results valueForKeyPath:@"GetBrodcastMessageResult.IsSuccess"]]boolValue]){
             if ([[results valueForKeyPath:@"GetBrodcastMessageResult.lstmessage"]isKindOfClass:[NSArray class]]){
                 [[DatabaseHelper sharedInstance]CreateorUpdateAds:[results valueForKeyPath:@"GetBrodcastMessageResult.lstmessage"] andCompletionBlock:^(BOOL success){
                      completionBlock(YES);
                 }];
             }
         }
         completionBlock(YES);
     } error:^(NSError *error){
     }];
    }
}
#pragma mark - Share BroadCast Message
-(void)ShareBroadCastMessage:(NSString *)message onView:(UIView *)onView{
   
    WhatsAppMessage *whatsappMsg = [[WhatsAppMessage alloc] initWithMessage:message forABID:@""];
    
    NSArray *applicationActivities = @[[[JBWhatsAppActivity alloc] init]];
    NSArray *arrayOfActivityItems = [NSArray arrayWithObjects:message,whatsappMsg, nil];
    
    // Display the view controller
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems: arrayOfActivityItems applicationActivities:applicationActivities] ;
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll, UIActivityTypePrint,UIActivityTypeCopyToPasteboard, UIActivityTypePostToWeibo,
                                         UIActivityTypeAirDrop,UIActivityTypeAddToReadingList];
    
    UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController;
    if (IS_IOS8_OR_LATER && !IPHONE) {
        activityVC.popoverPresentationController.sourceView = onView;
    }
    [menuController presentViewController:activityVC animated:YES completion:nil];
    
    //if iPad
    [activityVC setCompletionHandler:^(NSString *activityType, BOOL completed)
     {
         //   NSLog(@"Activity = %@",activityType);
         //   NSLog(@"Completed Status = %d",completed);
         
         if (completed)
         {
             //             UIAlertView *objalert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Posting was success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             //             [objalert show];
             //             objalert = nil;
         }else
         {
             //             UIAlertView *objalert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Posting was not successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             //             [objalert show];
             //             objalert = nil;
         }
     }];
}


#pragma mark - Open Appstore
-(void)OpenAppstore{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Apple_Store_URL]];
}

#pragma mark - Logout
-(void)LogOut{
    [[ModelClass sharedInstance]LogOutwithParameter:
     @{@"subno":User_SubNo,
       @"appuserid":User_App_User_Id,
       @"gcmid":DELEGATE.gcmID
       }
        success:^(id result){
            [[CommonMethods sharedInstance] removeLocallyStoredData];
             [DELEGATE.menuController showRootController:NO];
            ViewController *gologin = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
            [gologin.view makeToast:@"Logout Successfully"];
            UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController.rootViewController;
            [menuController pushViewController:gologin animated:YES];
        } error:^(NSError *error){
            
        }];
}

#pragma mark - Calendar Event
-(void)addEventWithStartDate:(NSDate*)startDate EndDate:(NSDate *)endDate Title:(NSString*)title notes:(NSString *)notes inLocation:(NSString*)location
{
    
    
            EKEventStore *eventStore = [[EKEventStore alloc]init];
            [eventStore requestAccessToEntityType:EKEntityTypeEvent
                                       completion:^(BOOL granted, NSError *error)
             {
                 if (granted)
                 {
                     EKEvent *event = [EKEvent eventWithEventStore:eventStore];
                     
                     // assign basic information to the event; location is optional
                     event.calendar = [eventStore defaultCalendarForNewEvents];
                     event.title = [NSString stringWithFormat:@"%@",title];
                     event.location = [NSString stringWithFormat:@"%@",location];
                     event.startDate = startDate;
                     event.endDate = endDate;
                     event.notes = [NSString stringWithFormat:@"%@",notes];
                     [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
                     
                     EKEventEditViewController *controller = [[EKEventEditViewController alloc] init];
                     controller.event = event;
                     controller.eventStore = eventStore;
                     controller.editViewDelegate = self;
                     UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController;
                     dispatch_async(dispatch_get_main_queue(), ^{
                     [menuController presentViewController:controller animated:YES completion:nil];
                          });
                     
                 }else{
                     
                     [DELEGATE.window makeToast:@"Please give permissions to access calendars in your device settings"];
                 }
                 
             }];
        
   
    
    
}
- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action
{
    
    NSError *error = nil;
    //  EKEvent *thisEvent = controller.event;
    switch (action) {
        case EKEventEditViewActionCanceled:
            // Edit action canceled, do nothing.
            break;
            
        case EKEventEditViewActionSaved:{
            // When user hit "Done" button, save the newly created event to the event store,
            // and reload table view.
            // If the new event is being added to the default calendar, then update its
            // eventsList.
            // if (self.defaultCalendar ==  thisEvent.calendar) {
            //   [self.eventsList addObject:thisEvent];
            // }
            // save event to the callendar
            BOOL result = [controller.eventStore saveEvent:controller.event span:EKSpanFutureEvents commit:YES error:&error];
            if (result) {
                
            } else {
                // NSLog(@"Error saving event: %@", error);
                // unable to save event to the calendar
                
            }
            
            [controller.eventStore saveEvent:controller.event span:EKSpanFutureEvents error:&error];
            // [self.tableView reloadData];
            break;
        }
        case EKEventEditViewActionDeleted:
            // When deleting an event, remove the event from the event store,
            // and reload table view.
            // If deleting an event from the currenly default calendar, then update its
            // eventsList.
            //  if (self.defaultCalendar ==  thisEvent.calendar) {
            //     [self.eventsList removeObject:thisEvent];
            //  }
            //   [controller.eventStore removeEvent:thisEvent span:EKSpanFutureEvents error:&error];
            //  [self.tableView reloadData];
            break;
            
        default:
            break;
    }
    // Dismiss the modal view controller
    UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController;
    [menuController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Device Model
- (NSString*) deviceName
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{@"i386"      :@"Simulator",
                              @"x86_64"    :@"Simulator",
                              @"iPod1,1"   :@"iPod Touch 1G",
                              @"iPod2,1"   :@"iPod Touch 2G",
                              @"iPod3,1"   :@"iPod Touch 3G",
                              @"iPod4,1"   :@"iPod Touch 4G",
                              @"iPod5,1"   :@"iPod Touch 5G",
                              
                              @"iPhone1,1" :@"iPhone 1G",
                              @"iPhone1,2" :@"iPhone 3G",
                              @"iPhone2,1" :@"iPhone 3GS",
                              @"iPhone3,1" :@"iPhone 4",
                              @"iPhone3,3" :@"Verizon iPhone 4",
                              @"iPhone4,1" :@"iPhone 4S",
                              @"iPhone5,1" :@"iPhone 5 (GSM)",
                              @"iPhone5,2" :@"iPhone 5 (GSM + CDMA)",
                              @"iPhone5,3" :@"iPhone 5c (GSM)",
                              @"iPhone5,4" :@"iPhone 5c (GSM + CDMA)",
                              @"iPhone6,1" :@"iPhone 5s (GSM)",
                              @"iPhone6,2" :@"iPhone 5s (GSM + CDMA)",
                              @"iPhone7,2" :@"iPhone 6",
                              @"iPhone7,1" :@"iPhone 6 Plus",
                              
                              @"iPad1,1"   :@"iPad",
                              @"iPad2,1"   :@"iPad 2 (WiFi)",
                              @"iPad2,2"   :@"iPad 2 (GSM)",
                              @"iPad2,3"   :@"iPad 2 (CDMA)",
                              @"iPad2,4"   :@"iPad 2 (WiFi)",
                              @"iPad2,5"   :@"iPad Mini (WiFi)",
                              @"iPad2,6"   :@"iPad Mini (GSM)",
                              @"iPad2,7"   :@"iPad Mini (GSM + CDMA)",
                              @"iPad3,1"   :@"iPad 3 (WiFi)",
                              @"iPad3,2"   :@"iPad 3 (GSM + CDMA)",
                              @"iPad3,3"   :@"iPad 3 (GSM)",
                              @"iPad3,4"   :@"iPad 4 (WiFi)",
                              @"iPad3,5"   :@"iPad 4 (GSM)",
                              @"iPad3,6"   :@"iPad 4 (GSM + CDMA)",
                              @"iPad4,1"   :@"iPad Air (WiFi)",
                              @"iPad4,2"   :@"iPad Air (Cellular)",
                              @"iPad4,3"   :@"iPad Air",
                              @"iPad4,4"   :@"iPad Mini 2G (WiFi)",
                              @"iPad4,5"   :@"iPad Mini 2G (Cellular)",
                              @"iPad4,6"   :@"iPad Mini 2G",
                              @"iPad4,7"   :@"iPad Mini 3 (WiFi)",
                              @"iPad4,8"   :@"iPad Mini 3 (Cellular)",
                              @"iPad4,9"   :@"iPad Mini 3 (China)",
                              @"iPad5,3"   :@"iPad AIR 2 (WiFi)",
                              @"iPad5,4"   :@"iPad AIR 2 (Cellular)"
                              };
    }
    
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    
    if (!deviceName) {
        // Not found on database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        }
    }
    
    return deviceName;
}

#pragma mark - AlertView
-(void)showAlertWithTitle :(NSString *)title Message:(NSString *)messsage {
    [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@",title] message:[NSString stringWithFormat:@"%@",messsage] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
    
}
#pragma mark - Flush NSUserDefaults
-(void)removeLocallyStoredData{
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"User_Email"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"User_Password"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Keep_Login"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SortQuery"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"User"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    DELEGATE.is_Searching = NO;
}
#pragma mark - AddressBook
-(void)getContactsFromAddressBook:(void (^) (BOOL success,id result)) complitionBlock
{
    ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CFErrorRef error = NULL;
                NSMutableArray *arr_contact;
                
                ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
                if (addressBook) {
                    NSArray *allContacts = (__bridge_transfer NSArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
                    NSMutableArray *mutableContacts = [NSMutableArray arrayWithCapacity:allContacts.count];
                    
                    NSUInteger i = 0;
                    for (i = 0; i<[allContacts count]; i++)
                    {
                        THContact *contact = [[THContact alloc] init];
                        ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];
                        contact.recordId = ABRecordGetRecordID(contactPerson);
                        
                        // Get first and last names
                        NSString *firstName = (__bridge_transfer NSString*)ABRecordCopyValue(contactPerson, kABPersonFirstNameProperty);
                        NSString *lastName = (__bridge_transfer NSString*)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
                        
                        // Set Contact properties
                        contact.firstName = firstName;
                        contact.lastName = lastName;
                        
                        // Get mobile number
                        ABMultiValueRef phonesRef = ABRecordCopyValue(contactPerson, kABPersonPhoneProperty);
                        contact.phone = [self getMobilePhoneProperty:phonesRef];
                        if(phonesRef) {
                            CFRelease(phonesRef);
                        }
                        
                        // Get image if it exists
                        NSData  *imgData = (__bridge_transfer NSData *)ABPersonCopyImageDataWithFormat(contactPerson,kABPersonImageFormatThumbnail);
                        contact.image = [UIImage imageWithData:imgData];
                        if (!contact.image) {
                            contact.image = [UIImage imageNamed:@"icon_avatar"];
                        }
                        if ([Arr_TTUsers containsObject:[[[NSString stringWithFormat:@"%@",contact.phone] componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]]componentsJoinedByString:@""]]) {
                            contact.is_TTUser = YES;
                        }else{
                            contact.is_TTUser = NO;
                        }
                        [mutableContacts addObject:contact];
                    }
                    
                    if(addressBook) {
                        CFRelease(addressBook);
                    }
                    
                    arr_contact = [NSMutableArray arrayWithArray:mutableContacts];
                    complitionBlock(YES, [[[[NSSet setWithArray:arr_contact] allObjects] sortedArrayUsingDescriptors:
                                           @[[NSSortDescriptor
                                              sortDescriptorWithKey:@"firstName" ascending:YES selector:@selector(caseInsensitiveCompare:)]]] mutableCopy]);
                }
                else
                {
                 //   NSLog(@"Error");
                    complitionBlock(NO, nil);
                }
            });
        } else {
            // TODO: Show alert
            complitionBlock(NO, nil);
        }
    });
    
    
    
    
}
- (NSString *)getMobilePhoneProperty:(ABMultiValueRef)phonesRef
{
    for (int i=0; i < ABMultiValueGetCount(phonesRef); i++) {
        CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phonesRef, i);
        CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phonesRef, i);
        
        if(currentPhoneLabel) {
            if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
                return (__bridge NSString *)currentPhoneValue;
            }
            
            if (CFStringCompare(currentPhoneLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
                return (__bridge NSString *)currentPhoneValue ;
                
            }
        }
        if(currentPhoneLabel) {
            CFRelease(currentPhoneLabel);
        }
        if(currentPhoneValue) {
            CFRelease(currentPhoneValue);
        }
    }
    
    return nil;
}
-(NSString *)getNameforContactNo:(NSString*)strMobile inArray:(NSMutableArray *)arrContacts
{
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"mobileno contains[c] %@",strMobile];
    NSArray *filteredContacts = [arrContacts filteredArrayUsingPredicate:filter];
    
    if (filteredContacts.count>0)
    {
        return [[filteredContacts objectAtIndex:0]valueForKey:@"name"];
    }
    else{
        return strMobile;
    }
}
-(void)SyncContacts:(void(^)(BOOL success))completionBlockmethod{
    
    NSMutableArray *contacts = [NSMutableArray array];
    [[CommonMethods sharedInstance] getContactsFromAddressBook:^(BOOL success,id result){
        if(success){
            for (THContact *contact in result) {
                [contacts addObject:@{@"mobileno":[[[NSString stringWithFormat:@"%@",contact.phone] componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]]componentsJoinedByString:@""]}];
            }
            
        }
        [[ModelClass sharedInstance]SyncContactswithParameter:
         @{@"moblielist":contacts
           } success:^(id results){
               if ([[NSString stringWithFormat:@"%@",[results valueForKeyPath:@"SyncContactResult.IsSuccess"]]boolValue]){
                   [[NSUserDefaults standardUserDefaults]setValue:[results valueForKeyPath:@"SyncContactResult.lstMobileNo.MobileNo"] forKey:@"Arr_TTUsers"];
                   [[NSUserDefaults standardUserDefaults]synchronize];
               }
               
           } error:^(NSError *error){
               
           }];
    }];
    completionBlockmethod(YES);
}
#pragma mark - Useful Methods
- (CGSize)screenSize {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    
    return screenSize;
}
-(CGSize)calculateSize:(NSString*)strText font:(UIFont*)fontType width:(CGFloat)lblMaxWidth
{
    CGSize newSize,maxsize;
    maxsize = CGSizeMake(lblMaxWidth, 7000.0);
    newSize = [strText sizeWithFont:fontType constrainedToSize:maxsize lineBreakMode:NSLineBreakByWordWrapping];
    return newSize;
}
-(NSString *)getBase64StringOfImage:(UIImage *)image{
    return  [UIImageJPEGRepresentation(image, 0.7) base64Encoding];
}
-(NSInteger)MinutesBetweenFromDate:(NSDate *)from_Date toDate:(NSDate *)to_Date{
    [DELEGATE.dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar rangeOfUnit:NSMinuteCalendarUnit startDate:&fromDate
                 interval:NULL forDate:from_Date];
    [calendar rangeOfUnit:NSMinuteCalendarUnit startDate:&toDate
                 interval:NULL forDate:to_Date];
    
    NSDateComponents *difference = [calendar components:NSMinuteCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    [DELEGATE.dateFormatter_GroupTenderserver setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return difference.minute;
}
-(NSInteger)DaysBetweenFromDate:(NSDate *)from_Date toDate:(NSDate *)to_Date{
   
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:from_Date];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:to_Date];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    return difference.day;
}
@end
