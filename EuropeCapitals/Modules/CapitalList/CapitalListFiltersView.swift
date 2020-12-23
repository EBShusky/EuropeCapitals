import UIKit

class CapitalListFiltersView: UIView {

    let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = NSLocalizedString("capitalListFiltersFavourite", comment: "")
        return view
    }()

    let favouritesSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var showFavouritesChangedAction: ((Bool) -> ())?

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        setupSwitch()
        backgroundColor = UIColor.white
    }

    @objc public func switchValueDidChange(sender: UISwitch) {
        showFavouritesChangedAction?(sender.isOn)
    }

    private func addSubviews() {
        addSubview(label)
        addSubview(favouritesSwitch)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: favouritesSwitch.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            favouritesSwitch.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            favouritesSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            favouritesSwitch.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    private func setupSwitch() {
        favouritesSwitch.addTarget(self, action: #selector(self.switchValueDidChange), for: .valueChanged)
    }

    required init?(coder _: NSCoder) { return nil }
}
