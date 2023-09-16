import Foundation
import Combine
import protocol Network.ClientPublishing
import protocol Network.Endpoint
import enum Network.ServiceError
import XCTest

final class FakeClientPublisher: ClientPublishing {
    func request<T>(setup: Endpoint) -> AnyPublisher<T, ServiceError> where T: Decodable {
        XCTFail("It shouln't be called")
        return AnyPublisher(Empty<T, ServiceError>())
    }
}
