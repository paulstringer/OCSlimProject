#import <XCTest/XCTest.h>
#import "OCSPLocalizedMessageTable.h"

@interface OCSPLocalizedMessageTableTests : XCTestCase

@end

@implementation OCSPLocalizedMessageTableTests


- (void)testErrorMessageEmptyTestSuiteDefined {
    
    NSString *localizedString = NSLocalizedStringFromTableInBundle(@"EmptyTestSuiteErrorMessage", nil, [NSBundle bundleForClass:[self class]], nil);
    
    XCTAssertNotEqualObjects(@"EmptyTestSuiteErrorMessage", localizedString);
    
}

- (void)testLocalizedEmptyTestSuiteMessage {
    
    NSString *message = [OCSPLocalizedMessageTable localizedEmptyTestSuiteMessageWithSuiteName:@"TestSuite"];

    NSString *expectedMessage = [OCSPLocalizedMessageTable localizedMessageWithKey:@"EmptyTestSuiteErrorMessage" argument:@"TestSuite"];
    
    XCTAssertEqualObjects(expectedMessage, message);
    
}

- (void)testErrorMessageTestPageDefined {
    
    NSString *localizedString = NSLocalizedStringFromTableInBundle(@"TestPageErrorMessage", nil, [NSBundle bundleForClass:[self class]], nil);
    
    XCTAssertNotEqualObjects(@"TestPageErrorMessage", localizedString);
    
}


- (void)testLocalizedTestPageErrorMessage {
    
    NSString *message = [OCSPLocalizedMessageTable localizedTestPageMessageWithUnderlyingMessage:@"1 Errors"];
    
    NSString *expectedMessage = [OCSPLocalizedMessageTable localizedMessageWithKey:@"TestPageErrorMessage" argument:@"1 Errors"];
    
    XCTAssertEqualObjects(expectedMessage, message);
    
}

@end
