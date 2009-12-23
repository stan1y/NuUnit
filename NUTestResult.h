//
//  NUTestResult.h
//  todo
//
//  Created by Semka Novikov on 13.12.09.
//  Copyright 2009 Nulana LTD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NUTestResult : NSObject {
    BOOL started;
    BOOL failed;
    NSString *description;
    NSString *testName;
}

@property (assign) BOOL started;
@property (assign) BOOL failed;
@property (retain) NSString *description;
@property (retain) NSString *testName;

@end
