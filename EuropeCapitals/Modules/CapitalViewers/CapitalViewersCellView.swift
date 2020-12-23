import UIKit

class CapitalViewerCellView: UITableViewCell {

    static let reuseIdentifier = "CapitalViewerCellView"

    let nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor.clear
        addSubviews()
        setupLayout()
    }

    private func addSubviews() {
        addSubview(nameLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16)
        ])
    }

    required init?(coder: NSCoder) { return nil }
}
