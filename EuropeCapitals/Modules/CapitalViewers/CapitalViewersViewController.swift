import UIKit

class CapitalViewersViewController: UIViewController {

    private let viewModel: CapitalViewersViewModelProtocol
    private let ownView = CapitalViewersView()

    private var dataSource: [CapitalViewersCellViewData] = []

    override func loadView() {
        view = ownView
    }

    init(viewModel: CapitalViewersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBarButtons()
        bindView()

        viewModel.handleEvent(event: .fetch)
    }

    @objc public func doneTapped() {
        dismiss(animated: true, completion: nil)
    }

    private func bindView() {
        viewModel.dataSource.bind { [weak self] dataSource in
            self?.dataSource = dataSource
            self?.ownView.tableView.reloadData()
        }
    }

    private func setupTableView() {
        ownView.tableView.dataSource = self
        ownView.tableView.register(CapitalViewerCellView.self, forCellReuseIdentifier: CapitalViewerCellView.reuseIdentifier)
    }

    private func setupNavigationBarButtons() {
        let doneButton = UIBarButtonItem(title: NSLocalizedString("generalDone", comment: ""),
                                         style: .done,
                                         target: self,
                                         action: #selector(doneTapped))
        navigationItem.rightBarButtonItem = doneButton
    }

    required init?(coder: NSCoder) { return nil }
}

extension CapitalViewersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataSourceItem = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CapitalViewerCellView.reuseIdentifier) as? CapitalViewerCellView
        cell?.nameLabel.text = dataSourceItem.name
        return cell ?? UITableViewCell()
    }
}
