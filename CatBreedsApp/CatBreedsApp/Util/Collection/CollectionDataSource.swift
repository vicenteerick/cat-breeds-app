import UIKit

final class CollectionDataSource<Cell: UICollectionViewCell, Item>: NSObject, UICollectionViewDataSource where Cell: ViewCellHandler, Item == Cell.Item {
    private let items: [Item]

    init(items: [Item]) {
        self.items = items
        super.init()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusable(fromIndexPath: indexPath) as Cell
        cell.data = items[indexPath.row]
        return cell
    }

}
