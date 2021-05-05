import UIKit
import Kingfisher
import AVFoundation

class PlayerViewController: UIViewController {
    private enum Constants {
        static let emptyLabel = ""
    }

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var prevSongButton: UIButton!
    @IBOutlet weak var nextSongButton: UIButton!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var songProgressView: UIProgressView!
    @IBOutlet weak var volumeProgressView: UIProgressView!
    private var isPlayButtonPressed = false
    private var isCurrentSoundPlay = false
    public var position: Int = 0
    public var song: Song?
    var songsArray: [Song] = []
    var currentProgress: Int = 0
    private var audioPlayer = AVAudioPlayer()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        artistLabel.text = song?.artist
        songLabel.text = song?.title
        //        songImageView.kf.setImage(with: song?.imgUrl)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.setImage(UIImage(systemName: "play"), for: .normal)
        prevSongButton.setImage(UIImage(systemName: "backward"), for: .normal)
        nextSongButton.setImage(UIImage(systemName: "forward"), for: .normal)
    }

    func soundsFiles() {
        let bundle = Bundle.main
        guard let sound = bundle.path(forResource: "songs", ofType: "json") else {
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            print("sound has been found")
        } catch {
            print("sound has not been found")
        }
    }

    @IBAction func pressedNextSongButton(_ sender: UIButton) {
        for i in songsArray {
            position = [i].startIndex + 1
        }
    }

    @IBAction func pressedPrevSongButton(_ sender: UIButton) {
        for i in songsArray {
            position = [i].startIndex - 1
        }
    }

    @IBAction func pressedPlayButton(_ sender: UIButton) {
        playingMusic()
    }

    func playingMusic() {
        soundsFiles()
        audioPlayer.play()
        isPlayButtonPressed = true
        playButton.setImage(UIImage(systemName: "pause"), for: .normal)
    }

    func songProcess() {
        let timer = Timer(timeInterval: 0.1, repeats: false, block: {_ in
            let i = self.currentProgress
            let max = 10 //need get max length of each song
            if i <= max {
                let ratio = Float(i) / Float(max)
                self.songProgressView.progress = Float(ratio)
                self.currentProgress += 1
            }
        })
        timer.fire()
    }
}
