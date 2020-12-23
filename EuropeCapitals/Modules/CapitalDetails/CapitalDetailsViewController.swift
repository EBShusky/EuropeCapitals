import UIKit

class CapitalDetailsViewController: UIViewController {

    private let viewModel: CapitalDetailsViewModelProtocol
    private let ownView = CapitalDetailsView()

    override func loadView() {
        view = ownView
    }

    init(viewModel: CapitalDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()

        viewModel.handleEvent(event: .fetch)
    }

    private func bindView() {
        viewModel.isLoading.bind { [weak self] isLoading in
            self?.ownView.activityIndicator.isHidden = !isLoading
        }

        viewModel.details.bind { [weak self] viewData in
            self?.ownView.mainView.bind(viewData: viewData)
        }

        viewModel.isFavourite.bind { [weak self] isFavourite in
            self?.ownView.mainView.favouriteButton.isSelected = isFavourite
        }

        viewModel.showError.bind { [weak self] showError in
            self?.ownView.errorRetryView.isHidden = !showError
        }

        ownView.errorRetryView.retryTappedAction = { [weak self] in
            self?.viewModel.handleEvent(event: .fetch)
        }

        ownView.mainView.viewerButtonTappedAction = { [weak self] in
            self?.viewModel.handleEvent(event: .viewersTapped)
        }

        ownView.mainView.favouriteButtonTappedAction = { [weak self] in
            self?.viewModel.handleEvent(event: .favouriteStatusChanged)
        }
    }

    required init?(coder: NSCoder) { return nil }
}
