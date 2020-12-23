import UIKit

class CapitalListViewController: UIViewController {

    private let viewModel: CapitalListViewModelProtocol
    private let ownView = CapitalListView()

    private var dataSource: [CapitalListCellViewData] = []

    override func loadView() {
        view = ownView
    }

    init(viewModel: CapitalListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.handleEvent(event: .fetch)
    }

    private func bindView() {
        viewModel.isLoading.bind { [weak self] isLoading in
            self?.ownView.activityIndicator.isHidden = !isLoading
        }

        viewModel.showError.bind { [weak self] showError in
            self?.ownView.errorRetryView.isHidden = !showError
        }

        viewModel.dataSource.bind { [weak self] dataSource in
            self?.dataSource = dataSource
            self?.ownView.tableView.reloadData()
        }

        ownView.errorRetryView.retryTappedAction = { [weak self] in
            self?.viewModel.handleEvent(event: .fetch)
        }

        ownView.filtersView.showFavouritesChangedAction = { [weak self] isSelected in
            self?.viewModel.handleEvent(event: .showFavouritesSelected(selected: isSelected))
        }
    }

    private func setupTableView() {
        ownView.tableView.delegate = self
        ownView.tableView.dataSource = self
        ownView.tableView.register(CapitalListCellView.self, forCellReuseIdentifier: CapitalListCellView.reuseIdentifier)
    }

    required init?(coder: NSCoder) { return nil }
}

extension CapitalListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataSourceItem = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CapitalListCellView.reuseIdentifier) as? CapitalListCellView
        cell?.nameLabel.text = dataSourceItem.name
        cell?.pictureImageView.load(url: dataSourceItem.imageUrl)
        return cell ?? UITableViewCell()
    }
}

extension CapitalListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataSourceItem = dataSource[indexPath.row]
        viewModel.handleEvent(event: .capitalPicked(viewData: dataSourceItem))
    }
}
