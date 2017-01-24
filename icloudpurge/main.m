//
//  main.m
//  icloudpurge
//
//  Created by Steven Troughton-Smith on 24/01/2017.
//  Copyright © 2017 High Caffeine Content. All rights reserved.
//

#import <Foundation/Foundation.h>

void usage()
{
	printf("Usage: icloudpurge [-f] /path/to/purge\n\n");
}

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		
		char s[20];
		
		if (argc > 1)
		{
			int pathIdx = 1;
			BOOL confirm = YES;
			
			if (argc > 2)
			{
				pathIdx = 2;
				confirm = NO;
			}
			
			NSString *destpath = [[NSString alloc] initWithUTF8String:argv[pathIdx]];
			
			if ([[NSFileManager defaultManager] fileExistsAtPath:destpath isDirectory:nil])
			{
				if (confirm)
				{
					printf("Really purge %s? y/N ", [destpath UTF8String]);
					scanf("%c", s);
					
					if (s[0] != 'y')
					{
						return -1;
					}
				}
				
				printf("Purging %s…\n", [destpath UTF8String]);
				NSError *error = nil;
				
				[[NSFileManager defaultManager] evictUbiquitousItemAtURL:[NSURL fileURLWithPath:destpath] error:&error];
				
				if (error)
				{
					printf("%s", [[error localizedDescription] UTF8String]);
					return -1;
				}
				
				return 0;
			}
			else
			{
				printf("Path %s not found.\n", [destpath UTF8String]);
				return -1;
			}
		}
	}
	
	usage();
	
	return -1;
}
