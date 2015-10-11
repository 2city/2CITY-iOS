//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGFileManager.h"

@implementation MGFileManager


+(BOOL)deleteImageAtFilePath:(NSString*)filePath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    
    return success;
}


+(void)deleteAllFilesAtDocumentsFolderWithExt:(NSString*)extension {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    
    while ((filename = [e nextObject])) {
        
        if ([[filename pathExtension] isEqualToString:extension]) {
    
            NSString* pathFile = [documentsDirectory stringByAppendingPathComponent:filename];
            [fileManager removeItemAtPath:pathFile error:NULL];
        }
    }
}

@end
