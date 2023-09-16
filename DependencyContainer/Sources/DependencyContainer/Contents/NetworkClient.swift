import Foundation
import protocol Network.ClientPublishing

public protocol HasNetworkClient {
    var networkClient: ClientPublishing { get throws }
}

extension DependencyContainer: HasNetworkClient {

    public var networkClient: ClientPublishing {
        get throws {
            guard let client = resolve(type: ClientPublishing.self) else {
                throw DependencyError.resolveError("Network Client should've been registered before being called")
            }
            return client
        }
    }
}
