import UIKit

class PlayerViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var prevSongButton: UIButton!
    @IBOutlet weak var nextSongButton: UIButton!

    private var isPlayButtonPressed = false
    public var position: Int = 0
    public var song: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.setImage(UIImage(systemName: "play"), for: .normal)
        prevSongButton.setImage(UIImage(systemName: "backward"), for: .normal)
        nextSongButton.setImage(UIImage(systemName: "forward"), for: .normal)
    }
    @IBAction func pressedNextSongButton(_ sender: UIButton) {
    }
    @IBAction func pressedPrevSongButton(_ sender: UIButton) {
    }
    @IBAction func pressedPlayButton(_ sender: UIButton) {
    }
}
