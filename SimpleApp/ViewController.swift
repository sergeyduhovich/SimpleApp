import UIKit

class ViewController: UIViewController {
    @IBOutlet private(set) var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "label"
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        let controller = SongsListTableViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
