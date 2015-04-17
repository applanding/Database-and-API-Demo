//
//  ModelClass.h
//  APITest
//
//  Created by Evgeny Kalashnikov on 03.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "DarckWaitView.h"

@class DarckWaitView;
@class DarckWaitView_pad;
@interface ModelClass : NSObject {
  
    DarckWaitView *drkSignUp;

}
+ (ModelClass *)sharedInstance;

- (void)AppDownloadTrack:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)loginwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)CheckEmailIDwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)ContactFromInfowithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)CategoryListwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)SavePreferencewithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)MobileVerificationwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)VerifyCodewithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)MyCategoryListwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)LoginLogoutwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)ForgotPasswordwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GetTenderswithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GetHotTenderswithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GetCreditwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)LogOutwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)ContactuswithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)ShareApplicationwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)DeleteCategorywithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GeoLocationListwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GroupListwithParameter:(NSDictionary *)parameters showLoading:(BOOL)is_show success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)CreateGroupwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)ExitGroupwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)UpdateGroupwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GetGroupTenderListwithParameter:(NSDictionary *)parameters showLoading:(BOOL)is_show success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)AcknowledgementwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)LikeTenderwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)ShareTenderToGroupwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)CreateGroupAndShareTenderwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GetTenderDetailwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)AskTechnicalExpertwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)DocumentListwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)PlanListwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GetPreferenceQuerywithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GetCountryList:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)CreateOrderNumwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)UpdateOrderNumwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GetBrodcastMessagewithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)AddCommentwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GetCommentswithParameter:(NSDictionary *)parameters showLoading:(BOOL)is_show success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)DeleteCommentwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)SyncContactswithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)AddScanTenderwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)CreateGroupAndShareScanTenderwithParameter:(NSDictionary *)parameters success:(void (^)(id))result error:(void (^)(NSError *))error;
- (void)GetBuyerList:(void (^)(id))result error:(void (^)(NSError *))error;

@end
