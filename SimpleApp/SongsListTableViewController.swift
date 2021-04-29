import UIKit

class SongsListTableViewController: UIViewController {
    private enum Constants {
        static let offset = 0
        static let limit = 20
        static let cellClassName = String(describing: SongTableViewCell.self)
    }

    @IBOutlet var table: UITableView!
    private var songsArray: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Manager.shared.loadItems(offset: Constants.offset, limit: Constants.limit) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let songList):
                print(songList)
                self?.songsArray = songList
                self?.table.reloadData()
            }
        }
    }

    private func setupTable() {
        table.delegate = self
        table.dataSource = self
        table.register(
            UINib(nibName: Constants.cellClassName, bundle: nil),
            forCellReuseIdentifier: Constants.cellClassName
        )
    }
}

extension SongsListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        _ = indexPath.row

        let controller = PlayerViewController()

        present(controller, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension SongsListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(
            withIdentifier: Constants.cellClassName,
                for: indexPath
        ) as? SongTableViewCell else {
            return UITableViewCell()
        }
        let song = songsArray[indexPath.row]
        cell.song = song

        return cell
    }
}
