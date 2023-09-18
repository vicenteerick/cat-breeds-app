@testable import CatBreedsApp
import Combine
import Network
import XCTest

final class BreedServiceMock: BreedServicing {
    var fetchResult: Result<Decodable, NetworkError>?

    init(fetchResult: Result<Decodable, NetworkError>) {
        self.fetchResult = fetchResult
    }

    func fetchBreeds() -> AnyPublisher<[Breed], NetworkError> {
        fakePublisher(with: fetchResult)
    }

    func fetchImages(breedId: String) -> AnyPublisher<[ImageInfo], NetworkError> {
        fakePublisher(with: fetchResult)
    }
}

private extension BreedServiceMock {
    func fakePublisher<T: Decodable>(with result: Result<Decodable, NetworkError>?)
    -> AnyPublisher<T, NetworkError> {
        guard let result = result else {
            let failingTestError = "We should set a result before testing!"
            XCTFail(failingTestError)
            return AnyPublisher(Fail<T, NetworkError>(error: .unknown(failingTestError)))
        }

        switch result {
        case let .success(response):
            guard let response = response as? T else {
                let failingTestError = "Wrong Object type"
                XCTFail(failingTestError)
                return AnyPublisher(Fail<T, NetworkError>(error: .unknown(failingTestError)))
            }
            return Future<T, NetworkError> { promise in
                promise(.success(response))
            }.eraseToAnyPublisher()
        case let .failure(error):
            return AnyPublisher(Fail<T, NetworkError>(error: error))
        }
    }
}
