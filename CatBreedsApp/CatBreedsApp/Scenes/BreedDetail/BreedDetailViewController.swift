import Combine
import Kingfisher
import UIKit

class BreedDetailViewController: UIViewController, Identifiable {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!

    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private let viewModel: BreedDetailViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: BreedDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: Self.identifier, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Breed Detail"
        bindViewModelToView()
        viewModel.build()
    }

    private func bindViewModelToView() {
        viewModel.$title
            .receive(on: RunLoop.main)
            .compactMap { $0 }
            .assign(to: \.text, on: titleLabel)
            .store(in: &cancellables)

        viewModel.$description
            .receive(on: RunLoop.main)
            .compactMap { $0 }
            .assign(to: \.text, on: descriptionLabel)
            .store(in: &cancellables)

        viewModel.$temperament
            .receive(on: RunLoop.main)
            .compactMap { $0 }
            .assign(to: \.text, on: temperamentLabel)
            .store(in: &cancellables)

        viewModel.$imageURL
            .receive(on: RunLoop.main)
            .compactMap { $0 }
            .sink { [weak imageView, imageActivityIndicator] url in
                imageActivityIndicator?.startAnimating()
                imageView?.kf.setImage(with: url) { [weak self] _ in
                    self?.imageActivityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)

        let stateValueHandler: (BreedDetailViewModelState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                self?.loadingView.isHidden = false
            case .finishedLoading:
                self?.loadingView.isHidden = true
            case .error(let error):
                self?.loadingView.isHidden = true
                self?.showError(error)
            }
        }

        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &cancellables)
    }

    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { [unowned self] _ in
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
