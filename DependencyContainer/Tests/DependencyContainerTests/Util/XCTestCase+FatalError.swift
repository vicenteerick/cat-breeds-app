@testable import DependencyContainer
import Foundation
import XCTest

extension XCTestCase {
    func expectFatalError(expectedMessage: String, testcase: @escaping () -> Void) {
            let expect = expectation(description: "expectingFatalError")
            var assertionMessage: String?

            FatalErrorUtil.replaceFatalError { message, _, _ in
                assertionMessage = message
                expect.fulfill()
                Thread.exit()
                fatalError("It will never be executed")
            }

            Thread(block: testcase).start()

            waitForExpectations(timeout: 0.1) { _ in
                XCTAssertEqual(assertionMessage, expectedMessage)
                FatalErrorUtil.restoreFatalError()
            }
        }
}
