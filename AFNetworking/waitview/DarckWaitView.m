//
//  DarckWaitView.m
//  testProject
//
//  Created by Evgeny Kalashnikov on 18.01.11.
//  Copyright 2011 StableFlow. All rights reserved.
//

#import "DarckWaitView.h"


@implementation DarckWaitView

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithDelegate:(id)Class andInterval:(NSTimeInterval)interval andMathod:(SEL)mathod {
    self = [super init];
    if (self) {
        
        delegate = Class;
        time = interval;
        
       
    }
    return self;
}

- (void)showWithMessage:(NSString *)message{
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	if (!window) {
		window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	}
    if (message == nil) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES].detailsLabelText = message;
    }
    [self.view setFrame:window.frame];
   // [MBProgressHUD showHUDAddedTo:self.view animated:YES].detailsLabelText = @"Please Wait...";
//    if (IPHONE) {
//        
//    
//    [self.view setFrame:CGRectMake(0, 0, 320, 480)];
//    if (IS_IPHONE_5) {
//       [self.view setFrame:CGRectMake(0, 0, 320, 568)];
//    }
//    }else{
//    
//    [self.view setFrame:CGRectMake(0, 0, 768, 1024)];
//    }
    [window addSubview:self.view];
    
    
     [self performSelector:@selector(hide) withObject:nil afterDelay:120];
}


- (void) hide {
  
   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //[delegate performSelector:meth];
	[self.view removeFromSuperview];
}


@end
