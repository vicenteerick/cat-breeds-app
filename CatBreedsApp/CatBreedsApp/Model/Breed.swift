import Foundation

struct Breed: Decodable, PickerItem {
    let id: String
    let name: String
    let description: String
    let temperament: String
}
