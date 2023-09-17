@testable import DependencyContainer
import protocol Network.ClientPublishing
import XCTest

final class NetworkClientDependencyTests: XCTestCase {
    var dependencyContainer: DependencyContainer!

    override func setUp() {
        super.setUp()
        dependencyContainer = DependencyContainer()
    }

    override func tearDown() {
        super.tearDown()
        dependencyContainer = nil
    }

    func testRegister_WhenTypeIsHTTPClient_ShouldHaveHTTPClientPropertyNotNil() {
        dependencyContainer.register(type: ClientPublishing.self) { FakeClientPublisher() }
        XCTAssertNotNil(dependencyContainer.networkClient)
    }

    func testRegister_WhenTypeHTTPClient_IsNotRegistered_ShouldCallFatalError() {
        expectFatalError(expectedMessage: "Network Client should've been registered before being called") {
            _ = self.dependencyContainer.networkClient
        }
    }
}
