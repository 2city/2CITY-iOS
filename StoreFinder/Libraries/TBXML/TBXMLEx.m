#import "TBXMLEx.h"

@interface TBXMLEx ()
-(void) setTBXML:(TBXML *) value;
@end

@implementation TBXMLEx

+(TBXMLEx *) parserWithXML:(NSString *) xml {
	TBXMLEx *ex = [[TBXMLEx alloc] init];
	[ex setTBXML:[[TBXML alloc] initWithXMLString:xml]];
	return ex;
}

+(TBXMLEx *) parserWithURL:(NSString *) url {
	TBXMLEx *ex = [[TBXMLEx alloc] init];
	[ex setTBXML:[ [TBXML alloc] initWithURL:[NSURL URLWithString:url]] ];
	return ex;
}

+(TBXMLEx *) parserWithFile:(NSString *) xml {
	TBXMLEx *ex = [[TBXMLEx alloc] init];
	[ex setTBXML:[TBXML tbxmlWithXMLFile:xml]];
	return ex;
}

-(void) setTBXML:(TBXML *) value {
	tbxml = value;
}

-(BOOL) invalidXML {
	return tbxml.invalidXML;
}

-(NSString *) parsingErrorDescription {
	return tbxml.parsingErrorDescription;
}

-(TBXMLElementEx *) rootElement {
	if (!rootElement) {
		rootElement = [[TBXMLElementEx alloc] initWithElement:tbxml.rootXMLElement];
	}

	return rootElement;
}


@end
