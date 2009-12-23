//
//  NUTestCaseTests.m
//  todo
//
//  Created by Semka Novikov on 13.12.09.
//  Copyright 2009 Nulana LTD. All rights reserved.
//

#import "NUTestCaseTests.h"

@implementation NUTestCaseTests

- (void) setUp {
    array = [[NSArray alloc] initWithObjects:@"test", nil];
}

- (void) tearDown {
    [array release];
}

- (void) testArray {
    [self assertObject:[array objectAtIndex:0] equals:@"test"];
}

- (void) testAssertions
{
    [self assert:YES];
    [self assert:(3 + 4) == 7 description:@"The world went away..."];
    
    [self assertNil:nil];
    [self assertNonNil:@""];
    [self assertObject:@"Obj" equals:@"Obj"];
}

//- (void) testMethodInvocation {
//    [self assert:(self.testsCount > 0)];
//}
//
//
//- (void) testAssertions
//{
//    [self assert:YES];
//    [self assert:(3 + 4) == 7 description:@"The world went away..."];
//    
//    [self assertNil:nil];
//    [self assertNonNil:@""];
//    [self assertObject:@"Obj" equals:@"Obj"];
//}

@end
