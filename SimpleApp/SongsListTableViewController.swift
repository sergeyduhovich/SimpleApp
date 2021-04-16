import UIKit

class SongsListTableViewController: UIViewController {
    private enum Constants {
        static let cellReuseIdentifier = "cellReuseIdentifier"
    }

    @IBOutlet var table: UITableView!
    private var songsArray: [SongObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }

    private func setupTable() {
        table.delegate = self
        table.dataSource = self
        table.register(SongTableViewCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
    }
}

extension SongsListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row

        guard let controller = PlayerViewController(
                nibName: "PlayerViewController",
                bundle: nil
        ) as? PlayerViewController else {
            return
        }

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
            withIdentifier: Constants.cellReuseIdentifier,
                for: indexPath
        ) as? SongTableViewCell else {
            return UITableViewCell()
        }
        let song = songsArray[indexPath.row]
        cell.songLabel.text = song.title
        cell.artistLabel.text = song.artist
        cell.accessoryType = .disclosureIndicator
        cell.songImageView.image = UIImage(named: song.imgUrl)
        cell.songLabel.font = UIFont(name: "Halvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Halvetica", size: 17)

        return cell
    }
}
