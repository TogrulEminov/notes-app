import UIKit

final class NotesViewController: UIViewController {
    private var notes: [Note] = []

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No notes yet"
        label.font = .preferredFont(forTextStyle: .title3)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadNotes()
    }

    private func configureUI() {
        title = "Notes"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped)
        )

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)

        view.addSubview(tableView)
        view.addSubview(emptyLabel)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        updateEmptyState()
    }

    private func loadNotes() {
    }

    private func saveNotes() {
    }

    private func updateEmptyState() {
        emptyLabel.isHidden = !notes.isEmpty
    }

    @objc
    private func addTapped() {
        let controller = AddNoteViewController()
        controller.onSave = { [weak self] note in
            self?.notes.append(note)
            self?.saveNotes()
            self?.tableView.reloadData()
            self?.updateEmptyState()
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NoteCell.reuseIdentifier,
            for: indexPath
        ) as? NoteCell else {
            return UITableViewCell()
        }

        cell.configure(with: notes[indexPath.row])
        return cell
    }
}

extension NotesViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            self?.notes.remove(at: indexPath.row)
            self?.saveNotes()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self?.updateEmptyState()
            completion(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
