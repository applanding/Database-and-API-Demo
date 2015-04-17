//
//  DarckWaitView.h
//  testProject
//
//  Created by Evgeny Kalashnikov on 18.01.11.
//  Copyright 2011 StableFlow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface DarckWaitView : UIViewController {
	
    id delegate;
    NSTimeInterval time;
	
}
- (id)initWithDelegate:(id)Class andInterval:(NSTimeInterval)interval andMathod:(SEL)mathod;
- (void)showWithMessage:(NSString *)message;
- (void) hide;

@end
