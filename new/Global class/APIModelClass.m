//
//  APIModelClass.m
//  ProcurementTiger
//
//  Created by ETL on 29/04/15.
//  Copyright (c) 2015 ETL. All rights reserved.
//

#import "APIModelClass.h"

@implementation APIModelClass

- (id)init
{
    self = [super init];
    if (self) {
        drkSignUp = [[DarckWaitView alloc] initWithDelegate:nil andInterval:0.1 andMathod:nil];
    }
    
    return self;
}
+ (APIModelClass *)sharedInstance
{
    static APIModelClass *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)AppDownloadTrack:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"Login/AppDownload" parameters:parameters message:Loading_Msg showLoading:NO success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)AppLaunchTrack:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"Registration/AppUsage" parameters:parameters message:Loading_Msg showLoading:NO success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GetDomainInformation:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"Login/DomainConfiguration" parameters:parameters message:Loading_Msg showLoading:NO success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)RegisterUser:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"Registration/Registration" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)ForgotPassword:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"Registration/ForgotPassword" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)LoginUser:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"Login/Login" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)DownloadTenders:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"TenderList/GetTenders" parameters:parameters message:Download_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)LogoutUser:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"Login/Logout" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)TenderDetail:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"TenderDetail/ViewDetail" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)DocumentList:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"TenderDetail/TenderDocument" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)PlanList:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"Subscription/GetplanList" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)GenerateOrder:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"Subscription/GenerateOrder" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)UpteOrder:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"Subscription/UpdateOrder" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)ResultList:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"ResultList/GetResult" parameters:parameters message:Loading_Msg showLoading:NO success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}
- (void)ResultDetail:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error
{
    [self postURL:@"ResultList/GetResultDetail" parameters:parameters message:Loading_Msg showLoading:YES success:^(id response) {
        result(response);
    } failure:^(NSError *anError) {
        error(anError);
    }];
}



-(void)postURL:(NSString *)URL parameters:(id)parameters message:(NSString *)msg showLoading:(BOOL)show_loading success: (void (^) (id result)) successBlock failure: (void (^) (NSError * error)) failureBlock{
    
    
    //  if ([self canConnect:@"http://www.google.com/"]){
    
    if (DELEGATE.is_Internet){
        if (show_loading) {
            [drkSignUp showWithMessage:msg];
        }
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setTimeoutInterval:300];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        [manager POST:[[NSString stringWithFormat:@"%@%@",Base_Url,URL]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Input: %@ \n URL : %@ \n Output: %@", parameters,URL,[self cleanJsonToObject:responseObject]);
//            NSLog(@"-->%@",[[operation request]allHTTPHeaderFields]);
//           NSLog(@"-->%@",[[operation response]allHeaderFields]);
            if (show_loading) {
                [drkSignUp hide];
            }
            successBlock([self cleanJsonToObject:responseObject]);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Input: %@ \n URL : %@ \n Error: %@ \n %@", parameters,URL,operation.responseString,error);
            
            if (show_loading) {
                [drkSignUp hide];
            }
            UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController;
            [menuController.view makeToast:Network_Error_Msg];
            failureBlock(error);
        }];
    }else{
        UINavigationController *menuController = (UINavigationController*)DELEGATE.menuController;
        [menuController.view makeToast:No_Internet_Msg];
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
@end
