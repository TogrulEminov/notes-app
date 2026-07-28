import UIKit

final class JSONLabViewController: UIViewController {
    private let textView: UITextView = {
        let view = UITextView()
        view.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        view.isEditable = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let validButton = UIButton.configurationButton(title: "Decode Valid JSON")
    private let missingKeyButton = UIButton.configurationButton(title: "Decode Missing Key")
    private let wrongTypeButton = UIButton.configurationButton(title: "Decode Wrong Type")
    private let corruptedButton = UIButton.configurationButton(title: "Decode Corrupted JSON")

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureActions()
        showBundledJSON(named: "valid_notes")
    }

    private func configureUI() {
        title = "JSON Lab"
        view.backgroundColor = .systemBackground

        let stack = UIStackView(arrangedSubviews: [
            validButton,
            missingKeyButton,
            wrongTypeButton,
            corruptedButton
        ])
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        view.addSubview(textView)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            textView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    private func configureActions() {
        validButton.addTarget(self, action: #selector(validTapped), for: .touchUpInside)
        missingKeyButton.addTarget(self, action: #selector(missingKeyTapped), for: .touchUpInside)
        wrongTypeButton.addTarget(self, action: #selector(wrongTypeTapped), for: .touchUpInside)
        corruptedButton.addTarget(self, action: #selector(corruptedTapped), for: .touchUpInside)
    }

    private func showBundledJSON(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json"),
              let text = try? String(contentsOf: url) else {
            textView.text = "File not found"
            return
        }
        textView.text = text
    }

    private func decodeBundledJSON(named name: String) {
        showBundledJSON(named: name)
    }

    @objc private func validTapped() { decodeBundledJSON(named: "valid_notes") }
    @objc private func missingKeyTapped() { decodeBundledJSON(named: "missing_key_notes") }
    @objc private func wrongTypeTapped() { decodeBundledJSON(named: "wrong_type_notes") }
    @objc private func corruptedTapped() { decodeBundledJSON(named: "corrupted_notes") }
}

private extension UIButton {
    static func configurationButton(title: String) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.cornerStyle = .medium
        return UIButton(configuration: configuration)
    }
}
