import UIKit

protocol Identifiable { }

extension Identifiable where Self: UIView {
    static var identifier: String { String(describing: self) }
}

extension Identifiable where Self: UIViewController {
    static var identifier: String { String(describing: self) }
}
