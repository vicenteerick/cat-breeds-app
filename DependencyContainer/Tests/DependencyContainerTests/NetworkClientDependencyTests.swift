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

    func testRegister_WhenTypeIsHTTPClient_ShouldHaveHTTPClientPropertyNotNil() throws {
        dependencyContainer.register(type: ClientPublishing.self) { FakeClientPublisher() }
        XCTAssertNotNil(try dependencyContainer.networkClient)
    }

    func testRegister_WhenTypeHTTPClient_IsNotRegistered_ShouldCallFatalError() throws {
        do {
            _ = try dependencyContainer.networkClient
        } catch let error as DependencyError {
            XCTAssertEqual(error, .resolveError("Network Client should've been registered before being called"))
        }
    }
}
