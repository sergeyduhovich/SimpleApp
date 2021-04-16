import UIKit
import Kingfisher

class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var songImageView: UIImageView!

    var song: SongObject? {
        didSet {
            artistLabel.text = song?.artist
            songLabel.text = song?.title
            guard let song = song,
                let urlImage = URL(string: song.imgUrl) else {
                songImageView.image = nil
                return
            }
            songImageView.kf.setImage(with: urlImage)
        }
    }
}
