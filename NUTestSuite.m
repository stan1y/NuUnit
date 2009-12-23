//
//  NUTestSuite.m
//  todo
//
//  Created by Semka Novikov on 13.12.09.
//  Copyright 2009 Nulana LTD. All rights reserved.
//

#import "NUTestSuite.h"


@implementation NUTestSuite

@synthesize testClasses;

#pragma mark Initialization/Deallocation

- (id) init
{
    if (self = [super init]) 
    {
        testClasses  = [NSMutableArray new];
        results      = [NSMutableArray new];        
        testsFailed  = 0;
        testsStarted = 0;
    }
    return self;
}


- (void) dealloc
{
    [testClasses release];
    [results release];
    [super dealloc];
}


#pragma mark Runtime stuff

- (void) collectTestClasses 
{
    int classesCount = 0;
    Class * c_list = NULL;
    
    c_list = NULL;
    classesCount = objc_getClassList(NULL, 0);
    
    if (classesCount > 0)
    {
        c_list = malloc(sizeof(Class) * classesCount);
        classesCount = objc_getClassList(c_list, classesCount);
        
        for (int i = 0; i < classesCount; i++)
        {
            NSString *className = [NSString stringWithCString:class_getName(c_list[i])
                                                     encoding:NSUTF8StringEncoding];
            
            if ([className hasSuffix:@"Tests"]) {
                [testClasses addObject:className];
            }
        }
        free(c_list);
    }
}


#pragma mark Management

- (void) run 
{
    NSDate *startDate = [NSDate date];
    [self collectTestClasses];
    
    for (NSString *className in self.testClasses) 
    {
        id testClass = class_createInstance(
                            objc_getFutureClass(
                              [className cStringUsingEncoding:NSUTF8StringEncoding]
                            ),
                        0);
        [testClass init];
        [testClass run];
        [results addObjectsFromArray:[(NUTestCase*)testClass results]];
        testsStarted += [(NUTestCase*)testClass testsCount];
        testsFailed  += [(NUTestCase*)testClass testsFailed];
        [testClass release];
    }
    
    NSDate *finishDate = [NSDate date];
    elapsedTime = [finishDate timeIntervalSinceDate:startDate];
    
    [self calcSummary];
    [self printResults];
}


- (void) calcSummary 
{
    for (NUTestResult *result in results)
    {
        if (result.failed) {
            NSLog(@"TEST FAILED! Test: %@ failed with reasons: %@", result.testName, result.description);
        }
    }
}


#pragma mark Reporting

- (void) printResults 
{
    printf("---------------------------------------------------------------------------------------\n");
    printf("%d test run, %d failures. Elapsed time: %f sec.\n", testsStarted, testsFailed, elapsedTime);
    printf("---------------------------------------------------------------------------------------\n");
}

@end
