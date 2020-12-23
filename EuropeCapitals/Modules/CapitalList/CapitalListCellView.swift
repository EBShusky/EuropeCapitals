import UIKit

class CapitalListCellView: UITableViewCell {

    static let reuseIdentifier = "CapitalListCellView"

    let nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let pictureImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor.clear
        addSubviews()
        setupLayout()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
    }

    private func addSubviews() {
        addSubview(nameLabel)
        addSubview(pictureImageView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            pictureImageView.widthAnchor.constraint(equalToConstant: 140),
            pictureImageView.heightAnchor.constraint(equalToConstant: 140),
            pictureImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            pictureImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            pictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16)
        ])
    }

    required init?(coder: NSCoder) { return nil }
}
