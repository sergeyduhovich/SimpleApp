import UIKit
import Kingfisher

class SongTableViewCell: UITableViewCell {
    @IBOutlet private var artistLabel: UILabel!
    @IBOutlet private var songLabel: UILabel!
    @IBOutlet private var songImageView: UIImageView!

    var song: Song? {
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

    override func awakeFromNib() {
        super.awakeFromNib()

        accessoryType = .disclosureIndicator
        songLabel.font = UIFont(name: "Halvetica-Bold", size: 18)
    }
}
