//
//  ListCell.swift
//  RBPlayerDemo
//
//  Created by 冉彬 on 2023/4/22.
//

import UIKit
import AVFoundation

struct ListCellModel: RBTableViewRowModel {
    var videoUrl: String = ""
    
    func defauleCellName() -> String {
        ListCell.className
    }
}


class ListCell: RBTableViewCell {

    @IBOutlet weak var backgroundImageV: UIImageView! {
        didSet {
            backgroundImageV.image = UIImage(systemName: "lasso.and.sparkles")
        }
    }
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    
    private var playerLayer: AVPlayerLayer?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func loadUI(model: RBTableViewRowModel, indexPath: IndexPath) {
        tipLabel.text = "row - \(indexPath.row)"
        if let model = model as? ListCellModel {
            playerLayer?.removeFromSuperlayer()
            playerLayer = AVPlayerLayer(player: RBPlayerManager.shared.preload(urlStr: model.videoUrl))
            playerLayer!.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            playerView.layer.addSublayer(playerLayer!)
        }
        
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerLayer?.removeFromSuperlayer()
    }
    
}
