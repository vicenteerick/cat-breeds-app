import Foundation
import Combine
import protocol Network.ClientPublishing
import protocol Network.Endpoint
import enum Network.NetworkError
import XCTest

final class FakeClientPublisher: ClientPublishing {
    func request<T>(setup: Endpoint) -> AnyPublisher<T, NetworkError> where T: Decodable {
        XCTFail("It shouln't be called")
        return AnyPublisher(Empty<T, NetworkError>())
    }
}
