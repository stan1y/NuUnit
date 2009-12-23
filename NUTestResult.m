//
//  NUTestResult.m
//  todo
//
//  Created by Semka Novikov on 13.12.09.
//  Copyright 2009 Nulana LTD. All rights reserved.
//

#import "NUTestResult.h"


@implementation NUTestResult

@synthesize started, failed, description, testName;

- (id) init
{
    if (self = [super init]) {
        description = [NSString new];
        testName    = [NSString new];
    }
    return self;
}

- (void) dealloc
{
    [description release];
    [testName release];
    [super dealloc];
}



@end
