//
//  RBPlayerManager.swift
//  RBPlayerDemo
//
//  Created by 冉彬 on 2023/4/23.
//

import Foundation
import AVFoundation


class RBPlayerManager: NSObject {
    
    var currentUrl: String = ""
    // 全局变量
    static let shared = RBPlayerManager()
    private override init() {}
   
    // 正在播放以及预加载的数据
    private var dataModels: [RBPlayerDataModel] = []
    
    
    /// 播放
    /// - Parameter urlStr: 资源url
    func play(urlStr: String) {
        dataModels.forEach { model in
            model.player.seek(to: CMTime.zero)
            model.player.pause()
        }
        getPlayer(urlStr: urlStr).play()
    }
    
    
    /// 预加载
    /// - Parameter urlStr: 资源url
    /// - Returns: 播放器
    @discardableResult
    func preload(urlStr: String) -> AVPlayer {
        return getPlayer(urlStr: urlStr)
    }
    
    
    
    /// 通过url获取一个播放器(获取后会在预加载数据中添加)
    /// - Parameter urlStr: url
    /// - Returns: 播放器
    private func getPlayer(urlStr: String) -> AVPlayer {
        let lock = NSLock()
        lock.lock()
        defer{ lock.unlock() }
        var model: RBPlayerDataModel? = nil
        // 预加载数据中找
        for (index, model1) in dataModels.enumerated() {
            if model1.urlStr == urlStr {
                dataModels.remove(at: index)
                model = model1
                break
            }
        }
        // 预加载数据中没找到就创建一个新的
        if model == nil {
            model = RBPlayerDataModel()
            model!.urlStr = urlStr
            model!.player = createPlayer(urlStr: urlStr)
        }
        addModel(model!)
        return model!.player
    }
    
    
    /// 添加数据到预加载数组中
    /// - Parameter model: model
    private func addModel(_ model: RBPlayerDataModel) {
        let lock = NSLock()
        lock.lock()
        defer{ lock.unlock() }
        if dataModels.count > 10 {
            dataModels.remove(at: 0)
        }
        dataModels.append(model)
    }
    
    
    /// 创建新的播放器
    /// - Parameter urlStr: 资源url
    /// - Returns: 播放器
    private func createPlayer(urlStr: String) -> AVPlayer {
        guard let url = URL(string: urlStr) else {
            return AVPlayer()
        }
        let asset = AVURLAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        return AVPlayer(playerItem: playerItem)
    }
    
    
    
}


class RBPlayerDataModel {
    var urlStr: String = ""
    var player: AVPlayer = AVPlayer()
}

