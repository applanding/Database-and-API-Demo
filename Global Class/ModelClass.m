//
//  ModelClass.m
//  APITest
//
//  Created by Evgeny Kalashnikov on 03.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ModelClass.h"


@implementation ModelClass


- (id)init
{
    self = [super init];
    if (self) {
       drkSignUp = [[DarckWaitView alloc] initWithDelegate:nil andInterval:0.1 andMathod:nil];
    }
    
    return self;
}
+ (ModelClass *)sharedInstance
{
    static ModelClass *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (void)AppDownloadTrack:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"LoginService.svc/AppDownloadTrack" parameters:parameters message:Loading_Msg showLoading:NO success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}

- (void)loginwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    
  
    [self postURL:@"LoginService.svc/GetloginDetailObj" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)CheckEmailIDwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"UserContactInfoService.svc/CheckEmailId" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)ContactFromInfowithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"UserContactInfoService.svc/Contactinfo" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)CategoryListwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self getURL:@"CategoryServiceList.svc/GetCategoryList" parameters:parameters message:Loading_Msg  success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)SavePreferencewithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"SavePreferenceQueryService.svc/SavePreferenceQuery" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)MobileVerificationwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MobileVerification.svc/SendVerificationMsg" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)VerifyCodewithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MobileVerification.svc/GetVerificationResponse" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)MyCategoryListwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"SwitchCategoryService.svc/GetSwitchCategoryList" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)LoginLogoutwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"LoginService.svc/loginlogout" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)ForgotPasswordwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"ForgotPassword.svc/GetForgotPasswordObj" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GetTenderswithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MyTendersService.svc/GetTenders" parameters:parameters message:Download_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GetHotTenderswithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"HotTenderService.svc/GetHotTenders" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GetCreditwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MyGroupService.svc/GetCredit" parameters:parameters message:Loading_Msg showLoading:NO success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)LogOutwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"LoginService.svc/logout" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)ContactuswithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"DomainContactUsService.svc/DomainContactus" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)ShareApplicationwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"SharingApplicationService.svc/ShareApplication" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)DeleteCategorywithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"SwitchCategoryService.svc/DeleteCategoryList" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GeoLocationListwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"GeoLocationService.svc/GetGeolocationList" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GroupListwithParameter:(NSDictionary *)parameters showLoading:(BOOL)is_show success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MyGroupService.svc/GetGrouplist" parameters:parameters message:Loading_Msg showLoading:is_show success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)CreateGroupwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    http://192.168.100.153:8022/Service1.svc
    
    [self postURL:@"MyGroupService.svc/CreateGroup" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)ExitGroupwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MyGroupService.svc/ExitGroupUser" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)UpdateGroupwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MyGroupService.svc/UpdateGroup" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GetGroupTenderListwithParameter:(NSDictionary *)parameters showLoading:(BOOL)is_show success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MyGroupService.svc/GetGroupTenderList" parameters:parameters message:Loading_Msg showLoading:is_show success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)AcknowledgementwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MyGroupService.svc/UpdateUserDate" parameters:parameters message:Loading_Msg showLoading:NO success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)LikeTenderwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"TenderDetailService.svc/LikeTender" parameters:parameters message:Loading_Msg showLoading:NO success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)ShareTenderToGroupwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MyGroupService.svc/ShareTenderToGroup" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)CreateGroupAndShareTenderwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MyGroupService.svc/CreateGroupShareTender" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GetTenderDetailwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"TenderDetailService.svc/GetTenderDetail" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)AskTechnicalExpertwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"TenderCycleAndATE.svc/AskTechnicalExpert" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)DocumentListwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"TenderDetailService.svc/GetTenderDocument" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)PlanListwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"SubscriptionPlan.svc/GetPlanList" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GetPreferenceQuerywithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"SavePreferenceQueryService.svc/GetPreferenceQuery" parameters:parameters message:Loading_Msg showLoading:NO success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GetCountryList:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"GeoLocationService.svc/GetCountryList" parameters:nil message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)CreateOrderNumwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"Payment.svc/CreateOrderno" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)UpdateOrderNumwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"Payment.svc/UpdateOrderno" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GetBrodcastMessagewithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"BoradcastMessage.svc/GetBrodcastMessage" parameters:parameters message:Loading_Msg showLoading:NO success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)AddCommentwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MyGroupService.svc/SharedComments" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GetCommentswithParameter:(NSDictionary *)parameters showLoading:(BOOL)is_show  success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MyGroupService.svc/GetTenderComments" parameters:parameters message:Loading_Msg showLoading:is_show success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)DeleteCommentwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"MyGroupService.svc/DeleteTenderComments" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)SyncContactswithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"SharingApplicationService.svc/SyncContact" parameters:parameters message:Loading_Msg showLoading:NO success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)AddScanTenderwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"ScanImage.svc/AddScanTender" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)CreateGroupAndShareScanTenderwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"ScanImage.svc/CreateGroupAndShareScanTender" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GetBuyerList:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"SavePreferenceQueryService.svc/GetBuyerList" parameters:nil message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}



-(void)postURL:(NSString *)URL parameters:(NSDictionary *)parameters message:(NSString *)msg showLoading:(BOOL)show_loading success: (void (^) (id result)) successBlock failure: (void (^) (NSError * error)) failureBlock{

    
  //  if ([self canConnect:@"http://www.google.com/"]){

        if (DELEGATE.is_Internet){
            if (show_loading) {
                [drkSignUp showWithMessage:msg];
            }
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setTimeoutInterval:120];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            [manager POST:[[NSString stringWithFormat:@"%@%@",Base_Url,URL]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
     //           NSLog(@"JSON: %@", [self cleanJsonToObject:responseObject]);
                if (show_loading) {
                    [drkSignUp hide];
                }
                successBlock([self cleanJsonToObject:responseObject]);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@ %@", operation.responseString,error);
                // NSLog(@"Error: %@", operation.responseString);
                if (show_loading) {
                    [drkSignUp hide];
                }
                
                [DELEGATE.window makeToast:Network_Error_Msg];
                
                failureBlock(error);
            }];
        }else{
            
            [DELEGATE.window makeToast:No_Internet_Msg];
            //  [DELEGATE.menuController.rootViewController.view makeToast:No_Internet_Msg];
            
        }
//    }];
    
    
    
}
-(void)getURL:(NSString *)URL parameters:(NSDictionary *)parameters message:(NSString *)msg success: (void (^) (id result)) successBlock failure: (void (^) (NSError * error)) failureBlock{
    
  //  if ([self canConnect:@"http://www.google.com/"]) {
        if (DELEGATE.is_Internet){
            [drkSignUp showWithMessage:msg];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            [manager GET:[[NSString stringWithFormat:@"%@%@",Base_Url,URL]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //          NSLog(@"JSON: %@", responseObject);
                [drkSignUp hide];
                successBlock([self cleanJsonToObject:responseObject]);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                
                [drkSignUp hide];
                
                [DELEGATE.window makeToast:Network_Error_Msg];
                
                failureBlock(error);
            }];
        }else{
            [DELEGATE.window makeToast:No_Internet_Msg];
            
        }
//    }];
    
    
    
}
- (id)cleanJsonToObject:(id)data {
    NSError* error;
    if (data == (id)[NSNull null]){
        return [[NSObject alloc] init];
    }
    id jsonObject;
    if ([data isKindOfClass:[NSData class]]){
        jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    } else {
        jsonObject = data;
    }
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [jsonObject mutableCopy];
        for (int i = (int)array.count-1; i >= 0; i--) {
            id a = array[i];
            if (a == (id)[NSNull null]){
                [array removeObjectAtIndex:i];
            } else {
                array[i] = [self cleanJsonToObject:a];
            }
        }
        return array;
    } else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dictionary = [jsonObject mutableCopy];
        for(NSString *key in [dictionary allKeys]) {
            id d = dictionary[key];
            if (d == (id)[NSNull null]){
                dictionary[key] = @"";
            } else {
                dictionary[key] = [self cleanJsonToObject:d];
            }
        }
        return dictionary;
    } else {
        return jsonObject;
    }
    
}
-(BOOL) canConnect:(NSString*) urlString;
{
    
    BOOL            flag=NO;
    @try {
        //NSData          *dataReply;
        NSURLResponse   *response;
        NSError         *error;
        
        // create the request
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
        
        // Make the connection
        [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
        
        if (response != nil)
        {
            //NSLog(@"(canConnect) - TESTING OF CONNECTION SUCCEEDED %@", response);
            flag = YES;
        } else {
            // inform the user that the download could not be made
          //  NSLog(@"(canConnect) - TESTING OF CONNECTION FAILED: %@ %@", response, error);
            flag = NO;
        }
    }
    @catch (NSException *exception) {
        flag = NO;
    }
    // Return the flag
    return flag;
}
@end