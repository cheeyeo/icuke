//
//  iCukeServer.m
//  iCuke
//
//  Created by Rob Holland on 01/03/2010.
//  Copyright 2010 The IT Refinery. All rights reserved.
//

#import "iCukeServer.h"
#include <unistd.h>

@implementation iCukeServer

+ (void)start {
	[[iCukeHTTPServer sharediCukeHTTPServer] start];

	NSFileManager *fileManager= [[NSFileManager alloc] init];
	NSArray *paths;

	NSString *preferences = [NSHomeDirectory() stringByAppendingPathComponent: @"Library/Preferences"];

	paths = [fileManager contentsOfDirectoryAtPath: preferences error: NULL];
	for (NSString *path in paths) {
		if (![path hasPrefix: @"."]) {
			NSLog(@"Removing: %@", path);
			unlink([[preferences stringByAppendingPathComponent: path] cStringUsingEncoding: [NSString defaultCStringEncoding]]);
		}
	}

	NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent: @"Documents"];
	paths = [fileManager contentsOfDirectoryAtPath: documents error: NULL];
	for (NSString *path in paths) {
		if (![path hasPrefix: @"."]) {
			NSLog(@"Removing: %@", path);
			unlink([[documents stringByAppendingPathComponent: path] cStringUsingEncoding: [NSString defaultCStringEncoding]]);
		}
	}
}

@end

void start_server(void) __attribute__((constructor));
void start_server(void)
{
  [iCukeServer start];
}
