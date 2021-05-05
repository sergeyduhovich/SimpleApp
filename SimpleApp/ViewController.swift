import UIKit

class ViewController: UIViewController {
    @IBOutlet private(set) var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "label"
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        let controller = SongsListTableViewController(fetcher: Manager.shared)
        navigationController?.pushViewController(controller, animated: true)
    }

    private func showHomeController() {
        let tabBarVC = UITabBarController()
        let songsListVC = UINavigationController(
            rootViewController: SongsListTableViewController(fetcher: Manager.shared)
        )
        let playerVC = UINavigationController(rootViewController: PlayerViewController())
        songsListVC.title = "Songs"
        playerVC.title = "Player"
        tabBarVC.setViewControllers([songsListVC, playerVC], animated: true)
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        let images = ["house", "star"]
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true, completion: nil)
    }
}
