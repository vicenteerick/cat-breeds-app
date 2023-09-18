import Foundation

enum BreedDetailViewModelError: Error, Equatable {
    case breedNotFound
}

enum BreedDetailViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(BreedDetailViewModelError)
}

final class BreedDetailViewModel {

    @Published private(set) var imageURL: URL?
    @Published private(set) var title: String?
    @Published private(set) var description: String?
    @Published private(set) var temperament: String?

    @Published private(set) var state: BreedDetailViewModelState = .loading

    private let info: ImageInfo

    init(info: ImageInfo) {
        self.info = info
    }

    func build() {
        state = .loading
        guard let breed = info.breeds.first else {
            state = .error(.breedNotFound)
            return
        }

        imageURL = info.url
        title = breed.name
        description = breed.description
        temperament = breed.temperament
        state = .finishedLoading
    }
}
