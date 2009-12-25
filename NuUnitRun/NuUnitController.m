//
//  NuUnitController.m
//  NuUnitRun
//
//  Created by Stanislav Yudin on 12/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NuUnitController.h"

@implementation NuUnitController

@synthesize outputView;

-(void)dealloc 
{
	if (applicationHandle) {
		dlclose(applicationHandle);
	}
}

-(IBAction)browseForApplication:(id)sender 
{
	NSOpenPanel* openDlg = [NSOpenPanel openPanel];
	[openDlg setCanChooseFiles:YES];
	[openDlg setCanChooseDirectories:NO];
	if ( [openDlg runModalForDirectory:nil file:nil] == NSOKButton )
	{
		NSString* fileName = [[openDlg filenames] objectAtIndex:0];
		NSLog(@"Opening file %s\n", [fileName UTF8String]);
		applicationHandle = dlopen([fileName UTF8String], RTLD_GLOBAL | RTLD_NOW);
		if (!applicationHandle) {
			NSLog(@"%s\n", dlerror());
			return;
		}
		
		[self restart:sender];
	}	
}

-(IBAction)restart:(id)sender
{
	NUTestSuite * suite = [[NUTestSuite alloc] init];
	[suite run];
	[suite release];
}

-(IBAction)clearOutput:(id)sender
{
}

@end
