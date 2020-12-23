import UIKit

class ErrorRetryView: UIView {

    let label: UILabel = {
        let view = UILabel()
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = NSLocalizedString("generalDataError", comment: "")
        return view
    }()

    let retryButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(NSLocalizedString("generalRetry", comment: ""), for: .normal)
        return view
    }()

    var retryTappedAction: (() -> ())?

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        setupRetryButton()
        backgroundColor = UIColor.clear
    }

    @objc public func retryAction() {
        retryTappedAction?()
    }

    private func addSubviews() {
        addSubview(label)
        addSubview(retryButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),

            retryButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    private func setupRetryButton() {
        retryButton.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
    }

    required init?(coder _: NSCoder) { return nil }
}
