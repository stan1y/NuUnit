ABOUT
-----
 
NuUnit is easy to use Unit testing software for Objective-C.
 
INSTALLING
----------
 
Just add this files to your project: 
  - NUTestCase.h
  - NUTestCase.m
  - NUTestResult.h
  - NUTestResult.m
  - NUTestSuite.h
  - NUTestSuite.m
  
Put following code in applicationDidFinishLaunching method or in any other method you want to run tests:

  NUTestSuite *suite = [NUTestSuite new];
  [suite run];
  [suite release];
  
If you don't want to run tests on iPhone device (if you developing iPhone software), you can use #if TARGET_IPHONE_SIMULATOR preprocessor directive.

WRITING TESTS
-------------

To create new test case add new NUTestCase subclass with suffix Tests to your project. Suffix Tests is important, NuUnit lookup Tests classes in runtime. 
In terms of NuUnit single test is method with prefix "test" of NUTestCase subclass. Fixture can be defined by standard setUp and tearDown methods. Prefix "test" is important too.

Some sample code:

//
//  NUSomeTests.h
//

#import <Foundation/Foundation.h>
#import "NUTestCase.h"
#import "NUTestResult.h"

@interface NUSomeTests : NUTestCase {
  NSArray *array;
}
@end

//
//  NUSomeTests.m
//

#import "NUSomeTests.h"

@implementation NUSomeTests

/* set up fixture */
- (void) setUp {
  array = [[NSArray alloc] initWithObjects:@"test", nil];
}

/* clean fixture state */
- (void) tearDown {
  [array release];
}

/* test method */
- (void) testArray {
  [self assertObject:[array objectAtIndex:0] equals:@"test"];
}

/* another test method */
- (void) testAssertions
{
    [self assert:YES];
    [self assert:(3 + 4) == 7 description:@"The world went away..."];
    
    [self assertNil:nil];
    [self assertNonNil:@""];
    [self assertObject:@"Obj" equals:@"Obj"];
}

@end

After compilation and running your application you should see following in debug console:
---------------------------------------------------------------------------------------
2 test run, 0 failures. Elapsed time: 0.00003 sec.
---------------------------------------------------------------------------------------

You can find sample NuUnit project here: http://github.com/semka/NuUnit-Exmaple

AVAILABLE ASSERTIONS
--------------------
NUTestCase class implements some assert methods.
List of available assertions:

- (void) assert:(BOOL)aBooleanExpression description:(NSString*)aDescription;
- (void) assert:(BOOL)aBooleanExpression;

- (void) assertObject:(id)expected equals:(id)actual;
- (void) assertObject:(id)expected notEquals:(id)actual;

- (void) assertObject:(id)expected equals:(id)actual description:(NSString*)description;
- (void) assertObject:(id)expected notEquals:(id)actual description:(NSString*)description;

- (void) assertInteger:(NSInteger)expected equals:(NSInteger)actual;
- (void) assertInteger:(NSInteger)expected equals:(NSInteger)actual description:(NSString*)description;

- (void) assertFloat:(double)expected equals:(double)actual description:(NSString*)description;

- (void) assertString:(NSString*)expected equals:(NSString*)actual description:(NSString*)description;

- (void) assertNonNil:(id)anObject;
- (void) assertNil:(id)anObject;

- (void) assertFalse:(BOOL)aBooleanExpression;
- (void) assertFalse:(BOOL)aBooleanExpression description:(NSString*)description;

- (void) assertTrue:(BOOL)aBooleanExpression;
- (void) assertTrue:(BOOL)aBooleanExpression description:(NSString*)description;

- (void) fail;