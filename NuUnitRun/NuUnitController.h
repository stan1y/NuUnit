//
//  NuUnitController.h
//  NuUnitRun
//
//  Created by Stanislav Yudin on 12/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <NuUnitFramework/NUTestSuite.h>

#include <dlfcn.h>

@interface NuUnitController : NSObject {

	void * applicationHandle;
	NSTextView * outputView;
}

@property (assign) IBOutlet NSTextView * outputView;

-(IBAction)browseForApplication:(id)sender;
-(IBAction)restart:(id)sender;
-(IBAction)clearOutput:(id)sender;

@end
