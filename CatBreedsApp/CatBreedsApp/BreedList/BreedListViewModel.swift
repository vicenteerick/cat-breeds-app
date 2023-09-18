import Combine
import DependencyContainer
import Foundation
import enum Network.NetworkError

enum BreedListViewModelError: Error, Equatable {
    case breedsFetch
    case imagesFetch
}

enum BreedListViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(BreedListViewModelError)
}

final class BreedListViewModel {

    @Published private(set) var breeds: [Breed] = []
    @Published private(set) var images: [ImageInfo] = []
    @Published private(set) var state: BreedListViewModelState = .loading

    private var service: BreedServicing
    private var cancellables = Set<AnyCancellable>()

    init(service: BreedServicing) {
        self.service = service
    }
}

extension BreedListViewModel {
    func fetchBreeds() {
        state = .loading

        let fetchBreedsCompletionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure:
                self?.state = .error(.breedsFetch)
            case .finished:
                self?.state = .finishedLoading
            }
        }

        let fetchBreedsValueHandler: ([Breed]) -> Void = { [weak self] breeds in
            self?.breeds = breeds
        }

        service
            .fetchBreeds()
            .sink(receiveCompletion: fetchBreedsCompletionHandler,
                  receiveValue: fetchBreedsValueHandler)
            .store(in: &cancellables)
    }

    func fetchImages(breedId: String) {
        state = .loading

        let fetchImagesCompletionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure:
                self?.state = .error(.breedsFetch)
            case .finished:
                self?.state = .finishedLoading
            }
        }

        let fetchImagesValueHandler: ([ImageInfo]) -> Void = { [weak self] images in
            self?.images = images
        }

        service
            .fetchImages(breedId: breedId)
            .sink(receiveCompletion: fetchImagesCompletionHandler,
                  receiveValue: fetchImagesValueHandler)
            .store(in: &cancellables)
    }
}
