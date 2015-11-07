//
//  CommonMethods.m
//  ProcurementTiger
//
//  Created by ETL on 29/04/15.
//  Copyright (c) 2015 ETL. All rights reserved.
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
#pragma mark - Setup HeaderView
-(void)SetupHeaderViewOf:(UIView *)headerView{
    for (UIView *view in headerView.subviews){
        if(view.tag == 1){
            [(UIImageView*)view setImage:[UIImage imageNamed:SubDomainHeaderImage]];
            #ifdef BPCLTenders
            [(UIImageView*)view setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:222.0/255.0 blue:0.0 alpha:1.0]];
            #endif
        }else if (view.tag == 2){
            for (UIView *subview in view.subviews){
                if(subview.tag == 3){
                    [(UIImageView*)subview setImage:[UIImage imageNamed:SubDomainHeaderLogoImage]];
                    #ifdef BPCLTenders
                    [(UIImageView*)subview setFrame:CGRectMake([(UIImageView*)subview frame].origin.x, 24, 84,35)];
                    #endif
                    
                }else if (subview.tag == 4){
                    [(UILabel*)subview setText:SubDomainName];
                }
            }
            
        }else if (view.tag == 5){
            [(UILabel*)view setTextColor:SubDomainHeaderTitleColor];
        }
    }
}
#pragma mark - Get Search Fields
-(NSString *)GetSearchFields{
    NSString *searchFields = @"tid || tenderValueText || tenderDetail || companySubIndustry || department || city || state || country";
    if ([User_Status intValue] == Subscriber_User)
    {
        searchFields = [searchFields stringByAppendingString:@" || buyer"];
    }
    return searchFields;
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
#pragma mark - Share Tender
-(void)ShareTender:(NSMutableDictionary *)dictTender onView:(UIView *)onView{
    NSString *strTenderValue = [dictTender valueForKey:@"tenderValueText"];
    if ([strTenderValue isEmptyString])
        strTenderValue=@"";
    else
        strTenderValue = [NSString stringWithFormat:@"of %@ %@",[dictTender valueForKey:@"currency"],[dictTender valueForKey:@"tenderValueText"]];
    
    NSString *strEmail = @"";
    NSString *tenderName = @"";
   
   
        tenderName = [NSString stringWithFormat:@"%@",[dictTender valueForKey:@"buyer"]];
    
    
    NSString *textToShare = [NSString stringWithFormat:@"%@ has published tender %@ for %@ in %@/%@/%@\n%@ %@",tenderName,strTenderValue,[[dictTender valueForKey:@"tenderDetail"]stringByDecodingHTMLEntities],[dictTender valueForKey:@"city"],[dictTender valueForKey:@"state"],[dictTender valueForKey:@"country"],Share_Tender_Msg,strEmail];
    
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
#pragma mark - Document Download And View
-(NSString *)DocumentPathforTenderSrNO:(NSString *)str_srNo{
    
    NSString *dataPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"Downloads/%@",str_srNo]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:nil]; //Create folder
    }
    
    return dataPath;
}

-(void)OpenDocumentForUrl:(NSString *)UrlStr TenderSrNO:(NSString *)str_srNo fileName:(NSString *)filename onView:(UIView *)onView{
    
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@",[self DocumentPathforTenderSrNO:str_srNo],filename];
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

#pragma mark - Flush NSUserDefaults
-(void)removeLocallyStoredData{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SortQuery"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"User"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    DELEGATE.is_Searching = NO;
}

#pragma mark - Open Appstore
-(void)OpenAppstore{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Apple_Store_URL]];
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
-(NSInteger)DaysBetweenFromDate:(NSDate *)from_Date toDate:(NSDate *)to_Date{
    
    if (from_Date && to_Date) {
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
    return 0;
}
@end
