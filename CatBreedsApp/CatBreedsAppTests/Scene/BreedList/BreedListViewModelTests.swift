@testable import CatBreedsApp
import Combine
import Network
import XCTest

final class BreedListViewModelTests: XCTestCase {
    private var sut: BreedListViewModel!
    private var serviceMock: BreedServiceMock!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        serviceMock = BreedServiceMock(fetchResult: .failure(.badRequest))
        sut = BreedListViewModel(service: serviceMock)
    }

    override func tearDown() {
        serviceMock = nil
        sut = nil
    }

    func testFetchBreeds_WhenStart_ShouldState_ReturnsLoading() {
        sut.fetchBreeds()

        sut.$state
            .dropFirst()
            .first(where: { _ in true })
            .sink { state in
                XCTAssertEqual(state, .loading)
            }
            .store(in: &cancellables)
    }

    func testFetchBreeds_WhenFailure_ShouldState_ReturnsError() {
        sut.fetchBreeds()
        XCTAssertEqual(sut.state, .error(.breedsFetch))
    }

    func testFetchBreeds_WhenSuccess_ShouldState_ReturnsFinishedLoading() {
        serviceMock.fetchResult = .success([Breed(id: "id", name: "name", description: "description", temperament: "temperament")])
        sut.fetchBreeds()
        XCTAssertEqual(sut.state, .finishedLoading)
    }

    func testFetchBreeds_WhenSuccess_ShouldBreeds_ReturnsValue() {
        serviceMock.fetchResult = .success([Breed(id: "id", name: "name", description: "description", temperament: "temperament")])
        sut.fetchBreeds()
        XCTAssertFalse(sut.breeds.isEmpty)
    }

    func testFetchImages_WhenStart_ShouldState_ReturnsLoading() {
        sut.fetchImages(breedId: "breedId")

        sut.$state
            .dropFirst()
            .first(where: { _ in true })
            .sink { state in
                XCTAssertEqual(state, .loading)
            }
            .store(in: &cancellables)
    }

    func testFetchImages_WhenFailure_ShouldState_ReturnsError() {
        sut.fetchImages(breedId: "breedId")
        XCTAssertEqual(sut.state, .error(.breedsFetch))
    }

    func testFetchImages_WhenSuccess_ShouldState_ReturnsFinishedLoading() {
        serviceMock.fetchResult = .success([ImageInfo(id: "id", url: URL(string: "http://google.com")!, width: 0, height: 0, breeds: [])])
        sut.fetchImages(breedId: "breedId")
        XCTAssertEqual(sut.state, .finishedLoading)
    }

    func testFetchImages_WhenSuccess_ShouldImages_ReturnsValue() {
        serviceMock.fetchResult = .success([ImageInfo(id: "id", url: URL(string: "http://google.com")!, width: 0, height: 0, breeds: [])])
        sut.fetchImages(breedId: "breedId")
        XCTAssertFalse(sut.images.isEmpty)
    }

    func testSelectItem_ShouldDetailModel_ReturnsValue() {
        sut.selectItem(imageInfo: ImageInfo(id: "id", url: URL(string: "http://google.com")!, width: 0, height: 0, breeds: []))
        XCTAssertNotNil(sut.$detailModel)
    }
}
