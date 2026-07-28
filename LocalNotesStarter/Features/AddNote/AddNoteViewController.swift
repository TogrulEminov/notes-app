import UIKit

final class AddNoteViewController: UIViewController {
    var onSave: ((Note) -> Void)?

    private let titleField: UITextField = {
        let field = UITextField()
        field.placeholder = "Title"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private let textView: UITextView = {
        let view = UITextView()
        view.font = .preferredFont(forTextStyle: .body)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.separator.cgColor
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        title = "New Note"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveTapped)
        )

        view.addSubview(titleField)
        view.addSubview(textView)

        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            textView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: titleField.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }

    @objc
    private func saveTapped() {
        let title = titleField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !title.isEmpty else {
            showAlert(title: "Missing Title", message: "Enter a title before saving.")
            return
        }

        let note = Note(
            id: UUID(),
            title: title,
            text: textView.text.trimmingCharacters(in: .whitespacesAndNewlines),
            createdAt: Date()
        )

        onSave?(note)
        navigationController?.popViewController(animated: true)
    }
}
