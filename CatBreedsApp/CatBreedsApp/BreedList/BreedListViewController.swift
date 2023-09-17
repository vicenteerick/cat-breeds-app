import Combine
import UIKit

final class BreedListViewController: UIViewController, Identifiable {
    private typealias DataSource = UICollectionViewDataSource

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!

    private let viewModel: BreedListViewModel
    private var colelctionDataSource: CollectionDataSource<BreedCollectionViewCell, ImageInfo>!
    private var pickerDataSource: PickerViewDataSource!

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: BreedListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: BreedListViewController.identifier, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupController()
    }

    private func setupController() {
        registerCollectionCell()
        bindViewToViewModel()
        bindViewModelToView()
        viewModel.build()
    }

    private func registerCollectionCell() {
        collectionView.register(
            BreedCollectionViewCell.self,
            forCellWithReuseIdentifier: BreedCollectionViewCell.identifier
        )
    }

    private func bindViewToViewModel() {
        textField.textPublisher
            .sink { _ in }
            .store(in: &cancellables)
    }

    private func bindViewModelToView() {
        viewModel.$breeds
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                self?.createPickerView(data: data)
            }
            .store(in: &cancellables)

        let stateValueHandler: (BreedListViewModelState) -> Void = { [weak self] state in
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

    private func updateCollection(data: [ImageInfo]) {
        colelctionDataSource = CollectionDataSource(items: data)
        collectionView.dataSource = colelctionDataSource
    }

    private func createPickerView(data: [String]) {
        pickerDataSource = PickerViewDataSource(data: data)
        let pickerView = UIPickerView()
        pickerView.delegate = pickerDataSource
        textField.inputView = pickerView
        dismissPickerView()

        pickerDataSource.$selectedText
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .assign(to: \.text, on: textField)
            .store(in: &cancellables)
    }

    private func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }

    @objc func action() {
        view.endEditing(true)
    }

    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Retry", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
