import Foundation
import protocol Network.ClientPublishing
import class Network.NetworkClient
import struct SharedSource.EnvironmentVars

public struct DependencyBuilder {
    public static func build() -> DependencyContainer {
        let dependencies = DependencyContainer()
        dependencies.register(type: ClientPublishing.self) {
            NetworkClient(baseUrl: EnvironmentVars.baseUrl)
        }

        return dependencies
    }
}
