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
	printf("Usage: icloudpurge /path/to/purge\n\n");
}

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		
		char s[20];
		
		if (argc > 1)
		{
			NSString *destpath = [[NSString alloc] initWithUTF8String:argv[1]];
			
			if ([[NSFileManager defaultManager] fileExistsAtPath:destpath isDirectory:nil])
			{
				printf("Really purge %s? y/N ", [destpath UTF8String]);
				scanf("%c", s);
				
				if (s[0] == 'y')
				{
					printf("Purging…\n");
					NSError *error = nil;

					[[NSFileManager defaultManager] evictUbiquitousItemAtURL:[NSURL fileURLWithPath:destpath] error:&error];
					
					if (error)
					{
						NSLog(@"%@", [error localizedDescription]);
						return -1;
					}
				}
				
				return 0;
			}
			else
			{
				printf("Path not found.\n");
				return -1;
			}
		}
	}
	
	usage();

	return -1;
}
