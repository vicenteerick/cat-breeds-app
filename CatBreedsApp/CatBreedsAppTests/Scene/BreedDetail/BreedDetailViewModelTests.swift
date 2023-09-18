@testable import CatBreedsApp
import Combine
import XCTest

final class BreedDetailViewModelTests: XCTestCase {
    private var sut: BreedDetailViewModel!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        sut = BreedDetailViewModel(
            info: ImageInfo(id: "id",
                            url: URL(string: "http://google.com")!,
                            width: 0,
                            height: 0,
                            breeds: [.init(id: "id",
                                           name: "name",
                                           description: "description",
                                           temperament: "temperament")])
        )
    }

    func testBuild_WhenStart_ShouldState_ReturnsLoading() {
        sut.build()

        sut.$state
            .dropFirst()
            .first(where: { _ in true })
            .sink { state in
                XCTAssertEqual(state, .loading)
            }
            .store(in: &cancellables)
    }

    func testBuild_WhenHasEmptyBreed_ShouldState_ReturnsError() {
        sut = BreedDetailViewModel(
            info: ImageInfo(id: "id",
                            url: URL(string: "http://google.com")!,
                            width: 0,
                            height: 0,
                            breeds: [])
        )

        sut.build()
        XCTAssertEqual(sut.state, .error(.breedNotFound))
    }

    func testBuild_WhenSuccess_ShouldState_ReturnsFinishedLoading() {
        sut.build()
        XCTAssertEqual(sut.state, .finishedLoading)
    }

    func testBuild_WhenSuccess_ShouldDatas_ReturnsValue() {
        sut.build()
        XCTAssertEqual(sut.title, "name")
        XCTAssertEqual(sut.description, "description")
        XCTAssertEqual(sut.temperament, "temperament")
        XCTAssertEqual(sut.imageURL, URL(string: "http://google.com"))
    }

    override func tearDown() {
        sut = nil
    }
}
