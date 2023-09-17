import Foundation

protocol ViewCellHandler: Identifiable {
    associatedtype Item
    var data: Item? { get set }
}
