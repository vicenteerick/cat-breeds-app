import DependencyContainer
import Foundation

final class BreedListViewModel {
    typealias Dependencies = HasNetworkClient

    private var dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

}
