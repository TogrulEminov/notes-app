import UIKit

final class SettingsViewController: UIViewController {
    var onLogout: (() -> Void)?

    private let themeSwitch: UISwitch = {
        let control = UISwitch()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Dark Mode"
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let logoutButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "Logout"
        configuration.baseForegroundColor = .systemRed
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadSettings()
    }

    private func configureUI() {
        title = "Settings"
        view.backgroundColor = .systemBackground

        themeSwitch.addTarget(self, action: #selector(themeChanged), for: .valueChanged)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)

        view.addSubview(themeLabel)
        view.addSubview(themeSwitch)
        view.addSubview(logoutButton)

        NSLayoutConstraint.activate([
            themeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            themeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            themeSwitch.centerYAnchor.constraint(equalTo: themeLabel.centerYAnchor),
            themeSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            logoutButton.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 40),
            logoutButton.leadingAnchor.constraint(equalTo: themeLabel.leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: themeSwitch.trailingAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func loadSettings() {
        themeSwitch.isOn = PreferencesManager.shared.isDarkModeEnabled
    }

    @objc
    private func themeChanged() {
        PreferencesManager.shared.isDarkModeEnabled = themeSwitch.isOn
        view.window?.overrideUserInterfaceStyle = themeSwitch.isOn ? .dark : .light
    }

    @objc
    private func logoutTapped() {
        onLogout?()
    }
}
