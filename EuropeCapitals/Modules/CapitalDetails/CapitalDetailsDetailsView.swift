import UIKit

class CapitalDetailsDetailsView: UIView {

    let nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return view
    }()

    let ratingLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let viewersButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let pictureImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()

    let favouriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favouriteOn"), for: .selected)
        button.setImage(UIImage(named: "favouriteOff"), for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5
        return button
    }()

    var viewerButtonTappedAction: (() -> ())?
    var favouriteButtonTappedAction: (() -> ())?

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        setupButtonsAction()
        backgroundColor = UIColor.white
    }

    public func bind(viewData: CapitalDetailsViewData) {
        nameLabel.text = viewData.capitalName
        pictureImageView.load(url: viewData.capitalImageUrl)
        ratingLabel.text = String(format: NSLocalizedString("capitalDetailsScore", comment: ""), viewData.capitalRating)
        viewersButton.setTitle(String(format: NSLocalizedString("capitalDetailsViewers", comment: ""), viewData.capitalViewers), for: .normal)
    }

    @objc public func viewersButtonAction() {
        viewerButtonTappedAction?()
    }

    @objc public func favouriteButtonAction() {
        favouriteButtonTappedAction?()
    }

    private func setupButtonsAction() {
        viewersButton.addTarget(self, action: #selector(viewersButtonAction), for: .touchUpInside)
        favouriteButton.addTarget(self, action: #selector(favouriteButtonAction), for: .touchUpInside)
    }

    private func addSubviews() {
        [nameLabel,
         ratingLabel,
         viewersButton,
         pictureImageView,
         favouriteButton].forEach(addSubview)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            pictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pictureImageView.heightAnchor.constraint(equalToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 36),
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            viewersButton.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8),
            viewersButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            viewersButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),

            favouriteButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            favouriteButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            favouriteButton.heightAnchor.constraint(equalToConstant: 50),
            favouriteButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    required init?(coder _: NSCoder) { return nil }
}
