//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGFileManager : NSObject

+(BOOL)deleteImageAtFilePath:(NSString*)filePath;

+(void)deleteAllFilesAtDocumentsFolderWithExt:(NSString*)extension;

@end
