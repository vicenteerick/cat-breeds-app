import Foundation
import protocol Network.ClientPublishing

public protocol HasNetworkClient {
    var networkClient: ClientPublishing { get }
}

extension DependencyContainer: HasNetworkClient {

    public var networkClient: ClientPublishing {
        guard let client = resolve(type: ClientPublishing.self) else {
            fatalError("Network Client should've been registered before being called")
        }
        return client
    }
}
