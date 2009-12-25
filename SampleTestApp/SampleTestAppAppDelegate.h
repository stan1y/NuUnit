//
//  SampleTestAppAppDelegate.h
//  SampleTestApp
//
//  Created by Stanislav Yudin on 12/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SampleTestAppAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
