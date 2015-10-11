#import <Foundation/Foundation.h>
#import "TBXML.h"

@interface TBXMLElementEx : NSObject {
	TBXMLElement *element;
	BOOL firstPass;
	NSMutableDictionary *attributes;
}

// A dictionary with all attributes of a given element
@property (nonatomic, readonly) NSDictionary *attributes;

-(id) initWithElement:(TBXMLElement *) value;

// Looks for a child element. Returns an autoreleased object
// if the element exists, of nil otherwise
-(TBXMLElementEx *) child:(NSString *) elementName;

// Advances to the next element with the same name of this instance's name
-(BOOL) next;

// Returns the value of a specific attribute, or nil otherwise
-(NSString *) attribute:(NSString *) name;

// Returns the value of a specific attribute as an int value, or 0 otherwise
-(int) intAttribute:(NSString *) name;

// Returns ths value of a specific attribute as an long value, or 0 otherwise
-(long long) longAttribute:(NSString *) name;

// Returns the text of this tag, if any
-(NSString *) value;

// Return the text of this tag as an int
-(int) intValue;

/*

*/
-(NSArray *) query:(NSString *) search;

// Retunrs the text of this tas as a long
-(long long) longValue;

// Returns the text of this tag
-(NSString *) text;

// Returns the name of this tag
-(NSString *) name;

@end
