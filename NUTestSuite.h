//
//  NUTestSuite.h
//  todo
//
//  Created by Semka Novikov on 13.12.09.
//  Copyright 2009 Nulana LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "NUTestCase.h"
#import "NUTestResult.h"

@interface NUTestSuite : NSObject {
    NSMutableArray *testClasses;
    NSMutableArray *results;
    NSInteger testsStarted;
    NSInteger testsFailed;
    NSTimeInterval elapsedTime;
}

@property (readonly) NSMutableArray *testClasses;

- (void) collectTestClasses;
- (void) run;
- (void) calcSummary;
- (void) printResults;

@end
