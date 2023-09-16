import Combine
import Foundation
@testable import Network
import XCTest

final class URLUtilTests: XCTestCase {

    var request: URLRequest!

    override func setUpWithError() throws {
        try super.setUpWithError()
        request = try URLRequest(baseUrl: "https://www.test.com/home",
                                 setup: EndpointMock.detail)
    }

    func testInitURL_WhenInvalid_ShouldThrowsError() throws {
        do {
            _ = try URL(baseUrl: "http://test.com:-80/", path: "")
        } catch let error as ServiceError {
            XCTAssertEqual(error, .invalidBaseUrl)
        }
    }

    func testdataTaskAnyPublisher_WhenValid_ShouldReturnAnyPublisher() {
        let pulisher = URLSession(configuration: URLSessionConfiguration.default)
            .dataTaskAnyPublisher(for: request)
        XCTAssertNotNil(pulisher)
    }

    func testInitURL_WhenValid_ShouldReturnURL_WithPath() {
        let url = try? URL(baseUrl: "https://www.test.com", path: "/home")
        XCTAssertEqual(url?.absoluteString, "https://www.test.com/home")
    }

    func testInitURLRequest_ShouldHandlePath() {
        let urlRequestDetail = try? URLRequest(baseUrl: "https://www.test.com",
                                               setup: EndpointMock.detail)
        XCTAssertEqual(urlRequestDetail?.url?.path, "/v1/product/detail")

        let urlRequestImages = try? URLRequest(baseUrl: "https://www.test.com",
                                               setup: EndpointMock.images)
        XCTAssertEqual(urlRequestImages?.url?.path, "/v1/product/images")
    }

    func testInitURLRequest_ShouldHandleBodyParameters() {
        let urlRequest = try? URLRequest(baseUrl: "https://www.test.com",
                                         setup: EndpointMock.detail)
        XCTAssertNotNil(urlRequest?.httpBody)
        XCTAssertNil(urlRequest?.url?.query)
    }

    func testInitURLRequest_ShouldHandleQueryParameters() {
        let urlRequest = try? URLRequest(baseUrl: "https://www.test.com",
                                         setup: EndpointMock.imagesFiltered("test"))
        XCTAssertNil(urlRequest?.httpBody)
        XCTAssertEqual(urlRequest?.url?.query, "param=test")
    }

    func testInitURLRequest_ShouldHandleMethod() {
        let urlRequestDetail = try? URLRequest(baseUrl: "https://www.test.com",
                                               setup: EndpointMock.detail)
        XCTAssertEqual(urlRequestDetail?.httpMethod, "POST")

        let urlRequestImages = try? URLRequest(baseUrl: "https://www.test.com",
                                               setup: EndpointMock.images)
        XCTAssertEqual(urlRequestImages?.httpMethod, "GET")
    }

    func testInitURLRequest_ShouldHandleHeader_ForBodyParameteres() {
        let urlRequest = try? URLRequest(baseUrl: "https://www.test.com",
                                         setup: EndpointMock.detail)
        XCTAssertEqual(urlRequest?.value(forHTTPHeaderField: "header"), "test")
        XCTAssertEqual(urlRequest?.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    func testInitURLRequest_ShouldHandleHeader_ForQueryParameteres() {
        let urlRequest = try? URLRequest(baseUrl: "https://www.test.com",
                                         setup: EndpointMock.images)
        XCTAssertEqual(urlRequest?.value(forHTTPHeaderField: "header"), "test")
        XCTAssertNil(urlRequest?.value(forHTTPHeaderField: "Content-Type"))
    }

    override func tearDown() {
        super.tearDown()
        request = nil
    }
}
