#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "TBXMLElementEx.h"

@interface TBXMLEx : NSObject {
	TBXML *tbxml;
	TBXMLElementEx *rootElement;
}

// Creates an autoreleased parser
+(TBXMLEx *) parserWithXML:(NSString *) xml;
+(TBXMLEx *) parserWithFile:(NSString *) xml;
+(TBXMLEx *) parserWithURL:(NSString *) url;

-(BOOL) invalidXML;
-(NSString *) parsingErrorDescription;
-(TBXMLElementEx *) rootElement;

@end

