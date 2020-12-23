import UIKit

class CapitalDetailsView: UIView {

    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()

    let errorRetryView: ErrorRetryView = {
        let view = ErrorRetryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    let mainView: CapitalDetailsDetailsView = {
        let view = CapitalDetailsDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        backgroundColor = UIColor.white
    }

    private func addSubviews() {
        addSubview(mainView)
        addSubview(activityIndicator)
        addSubview(errorRetryView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),

            mainView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),

            errorRetryView.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorRetryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorRetryView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    required init?(coder _: NSCoder) { return nil }
}
