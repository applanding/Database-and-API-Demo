//
//  APIModelClass.h
//  ProcurementTiger
//
//  Created by ETL on 29/04/15.
//  Copyright (c) 2015 ETL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "DarckWaitView.h"

@class DarckWaitView;
@class DarckWaitView_pad;

@interface APIModelClass : NSObject{
 DarckWaitView *drkSignUp;
}
+ (APIModelClass *)sharedInstance;
- (void)AppDownloadTrack:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)AppLaunchTrack:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GetDomainInformation:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)RegisterUser:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)ForgotPassword:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)LoginUser:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)DownloadTenders:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)LogoutUser:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)TenderDetail:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)DocumentList:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)PlanList:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GenerateOrder:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)UpteOrder:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)ResultList:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)ResultDetail:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
@end
