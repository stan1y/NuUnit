//
//  NUTestCase.h
//  todo
//
//  Created by Semka Novikov on 13.12.09.
//  Copyright 2009 Nulana LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUTestResult.h"

@interface NUTestCase : NSObject {
    NSInteger       testsCount;
    NSInteger       testsFailed;
    NSMutableArray *selectorsList;
    NSMutableArray *results;
    NUTestResult   *runningTestResult;
}

@property (readonly) NSInteger testsCount;
@property (readonly) NSInteger testsFailed;
@property (readonly) NSMutableArray *results;

/* Fixture */
- (void) setUp;
- (void) tearDown;

/* Runtime stuff */
- (void) collectTestSelectors;

/* Management */
- (void) run;

/* Assertions */
- (void) assert:(BOOL)aBooleanExpression description:(NSString*)aDescription;
- (void) assert:(BOOL)aBooleanExpression;

- (void) assertObject:(id)expected equals:(id)actual;
- (void) assertObject:(id)expected notEquals:(id)actual;

- (void) assertObject:(id)expected notEquals:(id)actual description:(NSString*)description;
- (void) assertObject:(id)expected equals:(id)actual description:(NSString*)description;

- (void) assertInteger:(NSInteger)expected equals:(NSInteger)actual;
- (void) assertInteger:(NSInteger)expected equals:(NSInteger)actual description:(NSString*)description;

- (void) assertFloat:(double)expected equals:(double)actual description:(NSString*)description;

- (void) assertString:(NSString*)expected equals:(NSString*)actual description:(NSString*)description;

- (void) assertNonNil:(id)anObject;
- (void) assertNil:(id)anObject;
- (void) fail;

- (void) assertFalse:(BOOL)aBooleanExpression;
- (void) assertFalse:(BOOL)aBooleanExpression description:(NSString*)description;

- (void) assertTrue:(BOOL)aBooleanExpression;
- (void) assertTrue:(BOOL)aBooleanExpression description:(NSString*)description;

@end
