//
//  NUTestCase.m
//  todo
//
//  Created by Semka Novikov on 13.12.09.
//  Copyright 2009 Nulana LTD. All rights reserved.
//

#import "NUTestCase.h"
#import <objc/runtime.h>


@implementation NUTestCase

@synthesize testsCount, results, testsFailed;

#pragma mark Initialization/Deallocation

- (id) init {
    if (self = [super init]) {
        selectorsList = [NSMutableArray new];
        [self collectTestSelectors];
        results = [NSMutableArray new];
        runningTestResult = nil;
        testsFailed = 0;
    }
    return self;
}


- (void) dealloc
{
    [selectorsList release];
    [results release];
    [super dealloc];
}


#pragma mark Runtime stuff

- (void) collectTestSelectors
{    
    unsigned int methodCount = 0;
    Method *m_list = class_copyMethodList(object_getClass(self), &methodCount);
    
    for (int i = 0; i < methodCount; i++) 
    {
        NSString *selectorName = [NSString stringWithCString:sel_getName(method_getName(m_list[i])) 
                                                    encoding:NSUTF8StringEncoding];
        if ([selectorName hasPrefix:@"test"]) {
            [selectorsList addObject:selectorName];
        }
    }
    free(m_list);
}


#pragma mark Management

- (void) run
{
    testsCount = 0;
    for (NSString *testSelectorName in selectorsList) 
    {
        runningTestResult = [NUTestResult new];
        runningTestResult.started  = YES;
        runningTestResult.testName = testSelectorName;
        
        SEL testSelector = NSSelectorFromString(testSelectorName);
        if ([self respondsToSelector:testSelector]) 
        {
            [self setUp];
            [self performSelector:testSelector];
            testsCount++;
            if (runningTestResult.failed) {
                testsFailed++;
            }
            [self tearDown];
        }
        [results addObject:runningTestResult];
        [runningTestResult release];
    }
}


#pragma mark Fixture
- (void) setUp {}
- (void) tearDown {}


#pragma mark Assertions

- (void) assert:(BOOL)aBooleanExpression description:(NSString*)aDescription 
{
    if (!aBooleanExpression) {
        runningTestResult.failed = YES;
        runningTestResult.description = [NSString stringWithFormat:@"%@\n%@", runningTestResult.description, aDescription];
    }        
}


- (void) assert:(BOOL)aBooleanExpression {
    [self assert:aBooleanExpression description:@"Asserion failed"];
}


- (void) assertTrue:(BOOL)aBooleanExpression {
    [self assert:aBooleanExpression description:@"Asserion failed"];
}

- (void) assertTrue:(BOOL)aBooleanExpression description:(NSString*)description {
    [self assert:aBooleanExpression description:description];
}


- (void) assertFalse:(BOOL)aBooleanExpression {
    [self assert:!aBooleanExpression description:@"Asserion failed"];
}


- (void) assertFalse:(BOOL)aBooleanExpression description:(NSString*)description {
    [self assert:!aBooleanExpression description:description];
}


- (void) assertObject:(id)expected equals:(id)actual
{
    [self assert:[expected isEqual:actual]
     description:[NSString stringWithFormat:@"%@ should be equal to %@", expected, actual]];
}


- (void) assertObject:(id)expected notEquals:(id)actual
{
    [self assert:![expected isEqual:actual]
     description:[NSString stringWithFormat:@"%@ should be equal to %@", expected, actual]];
}


- (void) assertObject:(id)expected notEquals:(id)actual description:(NSString*)description 
{
    [self assert:![expected isEqual:actual]
     description:[NSString stringWithFormat:@"%@ should be equal to %@. %@", expected, actual, description]];
}


- (void) assertObject:(id)expected equals:(id)actual description:(NSString*)description 
{
    [self assert:[expected isEqual:actual]
     description:[NSString stringWithFormat:@"%@ should be equal to %@. %@", expected, actual, description]];
}


- (void) assertInteger:(NSInteger)expected equals:(NSInteger)actual 
{
    [self assert:expected == actual
     description:[NSString stringWithFormat:@"%d should be equal to %d", expected, actual]];    
}


- (void) assertInteger:(NSInteger)expected notEquals:(NSInteger)actual 
{
    [self assert:expected != actual
     description:[NSString stringWithFormat:@"%d should be equal to %d", expected, actual]];    
}


- (void) assertInteger:(NSInteger)expected equals:(NSInteger)actual description:(NSString*)description 
{
    [self assert:expected == actual
     description:[NSString stringWithFormat:@"%d should be equal to %d. %@", expected, actual, description]];    
}


- (void) assertInteger:(NSInteger)expected notEquals:(NSInteger)actual description:(NSString*)description 
{
    [self assert:expected != actual
     description:[NSString stringWithFormat:@"%d should be equal to %d. %@", expected, actual, description]];    
}


- (void) assertFloat:(double)expected equals:(double)actual description:(NSString*)description 
{
    [self assert:expected == actual
     description:[NSString stringWithFormat:@"%f should be equal to %f. %@", expected, actual, description]];
}


- (void) assertString:(NSString*)expected equals:(NSString*)actual description:(NSString*)description 
{
    [self assert:[expected isEqualToString:actual]
     description:[NSString stringWithFormat:@"%@ should be equal to %@. %@", expected, actual, description]];
}


- (void) assertNonNil:(id)anObject 
{
    [self assert:(anObject != nil)
     description:[NSString stringWithFormat:@"%@ shouldn't be equal to nil", anObject]];
}


- (void) assertNil:(id)anObject {
    [self assert:(anObject == nil) 
     description:[NSString stringWithFormat:@"%@ should be equal to nil", anObject]];
}


- (void) fail {
    [self assert:NO description:@"Fail for the win!"];
}

@end
