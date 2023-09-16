import Foundation

struct SuccessStub: Decodable {
    let response: String?

    init(response: String?) {
        self.response = response
    }
}
