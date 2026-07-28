import UIKit

final class LoginViewController: UIViewController {
    var onLogin: (() -> Void)?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Local Notes"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Store the right data in the right place"
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let loginButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Login"
        configuration.cornerStyle = .large
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .systemBackground
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            loginButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    @objc
    private func loginTapped() {
        onLogin?()
    }
}
