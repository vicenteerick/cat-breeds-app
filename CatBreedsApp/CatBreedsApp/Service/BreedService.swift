import Combine
import DependencyContainer
import Foundation
import Network

protocol BreedServicing {
    func fetchBreeds() -> AnyPublisher<[Breed], NetworkError>
}

class BreedService: BreedServicing {
    typealias Dependencies = HasNetworkClient

    private var dependencies: Dependencies
    private lazy var networkClient: ClientPublishing = { dependencies.networkClient }()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func fetchBreeds() -> AnyPublisher<[Breed], NetworkError> {
        networkClient.request(setup: BreedEndpoint.all)
    }
}
