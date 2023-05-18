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
    
    
    private var ob: NSKeyValueObservation?
    private var obs: [NSKeyValueObservation?] = []
    private var playerLayer: AVPlayerLayer?
//    private var exportSession: AVAssetExportSession?
    @objc dynamic private var player: AVPlayer = AVPlayer()
    
    
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
            player = RBPlayerManager.shared.preload(urlStr: model.videoUrl)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer!.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            playerView.layer.addSublayer(playerLayer!)
            obs.removeAll()
            obs.append(observe(\.player.currentItem?.loadedTimeRanges, changeHandler: { [weak self] _, _ in
                guard let playerItem = self?.player.currentItem else {
                    return
                }
                // 当前缓冲进度
                let arr = playerItem.loadedTimeRanges
                guard false == arr.isEmpty else {return}
                guard let timeRange = arr[0] as? CMTimeRange else {return}
                let start = CMTimeGetSeconds(timeRange.start)
                let duration = CMTimeGetSeconds(timeRange.duration)
                let total = start + duration
                printLog("\(model.videoUrl)\n缓冲进度:\(total)/\(CMTimeGetSeconds(playerItem.duration))")
                if total >= CMTimeGetSeconds(playerItem.duration) {
                    printLog("缓冲完成")
                }
            }))
            
            obs.append(observe(\.player.status, changeHandler: { [weak self] _, _ in
                guard let self = self else {return}
                switch self.player.status {
                case .unknown:
                    printLog("播放器状态 - unknown")
                case .readyToPlay:
                    printLog("播放器状态 - 准备好可以播放-\(model.videoUrl)")
                case .failed:
                    printLog("播放器状态 - failed")
                @unknown default:
                    printLog("播放器状态 - unknown default")
                }
            }))
            if let playerItem = player.currentItem {
                // 监听播放完成通知
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerItem, queue: .main) {[weak self] _ in
                    guard let self = self else {return}
                    printLog("播放完成")
                    // 重新播放视频
                    self.player.seek(to: CMTime.zero)
                    self.player.play()
                }
            }
            
            
        }
        
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerLayer?.removeFromSuperlayer()
    }
    
    
}
