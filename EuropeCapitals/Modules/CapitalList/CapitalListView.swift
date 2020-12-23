import UIKit

class CapitalListView: UIView {

    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()

    let filtersView: CapitalListFiltersView = {
        let view = CapitalListFiltersView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()

    let errorRetryView: ErrorRetryView = {
        let view = ErrorRetryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        backgroundColor = UIColor.white
    }

    private func addSubviews() {
        addSubview(tableView)
        addSubview(activityIndicator)
        addSubview(filtersView)
        addSubview(errorRetryView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),

            filtersView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            filtersView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filtersView.leadingAnchor.constraint(equalTo: leadingAnchor),

            tableView.topAnchor.constraint(equalTo: filtersView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),

            errorRetryView.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorRetryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorRetryView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    required init?(coder _: NSCoder) { return nil }
}
