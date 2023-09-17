import UIKit

final class BreedListViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!

    private let viewModel: BreedListViewModel

    init(viewModel: BreedListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: BreedListViewController.name, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
