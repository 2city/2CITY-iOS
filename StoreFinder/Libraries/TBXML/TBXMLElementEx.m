#import "TBXMLElementEx.h"

@interface TBXMLElementEx() 
-(TBXMLElementEx *) duplicate;
@end

@implementation TBXMLElementEx
@synthesize attributes;

-(id) initWithElement:(TBXMLElement *) value {
	if (self = [super init]) {
		element = value;
		firstPass = YES;
	}
	
	return self;
}

-(NSDictionary *) attributes {
	if (!attributes) {
		attributes = [[NSMutableDictionary alloc] init];
		TBXMLAttribute *attr = element->firstAttribute;
		
		while (attr) {
			[attributes setObject:[TBXML attributeValue:attr] forKey:[TBXML attributeName:attr]];
			attr = attr->next;
		}
	}
	
	return attributes;
}

-(NSArray *) query:(NSString *) search {
	NSMutableArray *result = [NSMutableArray array];
	NSArray *parts = [search componentsSeparatedByString:@"/"];
	NSString *targetElementName = [parts objectAtIndex:parts.count - 1];

	if ([targetElementName isEqualToString:@""]) {
		if (parts.count == 1) {
			return result;
		}
		
		targetElementName = [parts objectAtIndex:parts.count - 2];
	}
	
	int index = 0;
	TBXMLElementEx *el = nil;
	NSString *piece = [parts objectAtIndex:index];
	
	if ([piece isEqualToString:@""]) {
		el = [self child:[parts objectAtIndex:1]];
		index = 1;
	}
	else {
		el = [self child:piece];
	}
	
	BOOL didFindElement = [el.name isEqualToString:targetElementName];
	
	while (el != nil && index < parts.count && !didFindElement) {
		if ([el.name isEqualToString:targetElementName]) {
			didFindElement = YES;
		}
		else {
			piece = [parts objectAtIndex:++index];
			
			if (![piece isEqualToString:@""]) {
				el = [el child:piece];
			}
		}
	}
	
	if (didFindElement) {
		while ([el next]) {
			[result addObject:[el duplicate]];
		}
	}
	
	return result;
}

-(TBXMLElementEx *) duplicate {
	return [[TBXMLElementEx alloc] initWithElement:element];
}

-(NSString *) name {
	return element ? [TBXML elementName:element] : nil;
}

-(int) intAttribute:(NSString *) name {
	return element ? [[self attribute:name] intValue] : 0;
}

-(long long) longAttribute:(NSString *) name {
	return element ? [[self attribute:name] longLongValue] : 0; 
}

-(NSString *) attribute:(NSString *) name {
	return element ? [TBXML valueOfAttributeNamed:name forElement:element] : nil;
}

-(int) intValue {
	return [[self value] intValue];
}

-(long long) longValue {
	return [[self value] longLongValue];
}

-(NSString *) value {
	return element ? [TBXML textForElement:element] : nil;
}

-(NSString *) text {
	return [self value];
}

-(BOOL) next {
	if (!element) {
		return NO;
	}
	
	if (firstPass) {
		firstPass = NO;
		return YES;
	}
	
	element = [TBXML nextSiblingNamed:[TBXML elementName:element] searchFromElement:element];
	return element != nil;
}

-(TBXMLElementEx *) child:(NSString *) elementName {
	TBXMLElement *childElement = [TBXML childElementNamed:elementName parentElement:element];
	return childElement ? [[TBXMLElementEx alloc] initWithElement:childElement] : nil;
}


@end
