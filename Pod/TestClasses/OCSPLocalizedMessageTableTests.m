#import <XCTest/XCTest.h>
#import "OCSPLocalizedMessageTable.h"

@interface OCSPLocalizedMessageTableTests : XCTestCase

@end

@implementation OCSPLocalizedMessageTableTests


- (void)testErrorMessageEmptyTestSuiteKeyDefined {
    
    NSString *localizedString = NSLocalizedStringFromTableInBundle(@"EmptyTestSuiteErrorMessage", nil, [NSBundle bundleForClass:[self class]], nil);
    
    XCTAssertNotEqualObjects(@"EmptyTestSuiteErrorMessage", localizedString);
    
}

- (void)testLocalizedEmptyTestSuiteMessage {
    
    NSString *message = [OCSPLocalizedMessageTable localizedEmptyTestSuiteMessageWithSuiteName:@"TestSuite"];

    NSString *expectedMessage = [OCSPLocalizedMessageTable localizedMessageWithKey:@"EmptyTestSuiteErrorMessage" argument:@"TestSuite"];
    
    XCTAssertEqualObjects(expectedMessage, message);
    
}

- (void)testErrorMessageTestPageKeyDefined {
    
    NSString *localizedString = NSLocalizedStringFromTableInBundle(@"TestPageErrorMessage", nil, [NSBundle bundleForClass:[self class]], nil);
    
    XCTAssertNotEqualObjects(@"TestPageErrorMessage", localizedString);
    
}

- (void)testLocalizedTestPageErrorMessage {
    
    NSString *message = [OCSPLocalizedMessageTable localizedTestPageMessageWithUnderlyingMessage:@"1 Errors"];
    
    NSString *expectedMessage = [OCSPLocalizedMessageTable localizedMessageWithKey:@"TestPageErrorMessage" argument:@"1 Errors"];
    
    XCTAssertEqualObjects(expectedMessage, message);
    
}


- (void)testErrorMessageTestSuiteParsingErrorKeyDefined {
    
    NSString *localizedString = NSLocalizedStringFromTableInBundle(@"TestSuiteParsingErrorMessage", nil, [NSBundle bundleForClass:[self class]], nil);
    
    XCTAssertNotEqualObjects(@"TestSuiteParsingErrorMessage", localizedString);
    
}

- (void)testLocalizedTestSuiteParsingErrorMessage {
    
    NSString *message = [OCSPLocalizedMessageTable localizedTestSuiteParsingErrorMessage];
    
    NSString *expectedMessage = [OCSPLocalizedMessageTable localizedMessageWithKey:@"TestSuiteParsingErrorMessage" argument:nil];
    
    XCTAssertEqualObjects(expectedMessage, message);
    
}

- (void)testErrorMessageTestSuiteDataMissingErrorKeyDefined {
    
    NSString *localizedString = NSLocalizedStringFromTableInBundle(@"TestSuiteDataNotFound", nil, [NSBundle bundleForClass:[self class]], nil);
    
    XCTAssertNotEqualObjects(@"TestSuiteDataMissing", localizedString);
    
}

- (void)testLocalizedTestSuiteDataMissingErrorMessage {
    
    NSString *message = [OCSPLocalizedMessageTable localizedTestSuiteReportDataNotFound];
    
    NSString *expectedMessage = [OCSPLocalizedMessageTable localizedMessageWithKey:@"TestSuiteDataNotFound" argument:nil];
    
    XCTAssertEqualObjects(expectedMessage, message);
    
}

- (void)testErrorMessageTestSuiteErrorsOccurredKeyDefined {
    
    NSString *localizedString = NSLocalizedStringFromTableInBundle(@"TestSuiteErrorsOccurred", nil, [NSBundle bundleForClass:[self class]], nil);
    
    XCTAssertNotEqualObjects(@"TestSuiteErrorsOccurred", localizedString);
    
}


- (void)testLocalizedTestSuiteErrorsOccurredMessage {
    
    NSString *message = [OCSPLocalizedMessageTable localizedTestSuiteErrorsOccurredMessageWithCount:3];
    
    NSString *expectedMessage = [OCSPLocalizedMessageTable localizedMessageWithKey:@"TestSuiteErrorsOccurred" argument:@"3"];
    
    XCTAssertEqualObjects(expectedMessage, message);
    
}


@end
