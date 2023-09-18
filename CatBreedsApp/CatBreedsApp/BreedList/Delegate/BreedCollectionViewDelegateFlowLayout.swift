import UIKit

class BreedCollectionViewDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {
    private let items: [ImageInfo]

    init(items: [ImageInfo]) {
        self.items = items
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = items[indexPath.row]

        let imageWidth = CGFloat(item.width)
        let imageHeight = CGFloat(item.height)

        let ratio =  imageWidth / imageHeight
        let height = floor(collectionView.frame.width / ratio)

        return CGSize(width: collectionView.frame.width, height: height)
    }
}
