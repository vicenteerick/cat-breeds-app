import UIKit

extension UICollectionView {
    func dequeueReusable<T: UICollectionViewCell>(fromIndexPath indexPath: IndexPath) -> T where T: Identifiable {

        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }

        return cell
    }

    func dequeueReusableSuplementaryView<T: UICollectionReusableView>(fromIndexPath indexPath: IndexPath, kind: String) -> T where T: Identifiable {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }

        return cell
    }
}
