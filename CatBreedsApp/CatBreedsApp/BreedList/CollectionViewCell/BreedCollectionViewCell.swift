import Combine
import Kingfisher
import UIKit

class BreedCollectionViewCell: UICollectionViewCell, ViewCellHandler {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @Published var data: ImageInfo?

    private var cancellables = Set<AnyCancellable>()

    override func awakeFromNib() {
        super.awakeFromNib()
        bindData()
    }

    private func bindData() {
        $data
            .compactMap { $0 }
            .sink { [weak imageView, activityIndicator] item in
                activityIndicator?.startAnimating()
                imageView?.kf.setImage(with: item.url) { [weak self] _ in
                    self?.activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)
    }

}
