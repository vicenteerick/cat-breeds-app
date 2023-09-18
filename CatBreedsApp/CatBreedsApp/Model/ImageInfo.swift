import Foundation

struct ImageInfo: Decodable {
    let id: String
    let url: URL
    let width: Int
    let height: Int
    let breeds: [Breed]
}
