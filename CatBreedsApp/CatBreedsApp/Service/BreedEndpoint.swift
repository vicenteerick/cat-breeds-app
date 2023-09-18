import Foundation
import Network
import SharedSource

extension API.Version {
    static var v1: API.Version { API.Version(rawValue: "v1")! }
}

enum BreedEndpoint: Endpoint {
    case all
    case images(String)

    var endpoint: String {
        switch self {
        case .all:
            return "/breeds"
        case .images:
            return "/images/search"
        }
    }

    var queries: [URLQueryItem]? {
        switch self {
        case .all:
            return [URLQueryItem(name: "limit", value: "30")]
        case let .images(breedId):
            return [
                URLQueryItem(name: "limit", value: "30"),
                URLQueryItem(name: "breed_id", value: breedId),
            ]
        }
    }

    var method: HTTPMethod { .get }
    var version: API.Version { .v1 }
    var header: HTTPHeader { ["x-api-key": EnvironmentVars.apiKey] }
}
