//
//  ReachableManager.swift
//  BangJiaJia
//
//  Created by 冉彬 on 2023/1/3.
//

import Foundation

enum ReachableConnection: String {
    /// wifi
    case wifi = "wifi"
    /// 蜂窝数据
    case cellular = "cellular"
}


enum ReachableStatus {
    /// 网络可用
    case useful(connection: ReachableConnection)
    /// 网络不可用
    case useless
    /// 网络未知
    case unknown
}



class ReachableManager {
    
    // 全局变量
    static let shared = ReachableManager()
    private init() {}
    var reachability: Reachability?
    
    var status: ReachableStatus = .unknown
    
    
    func checkNetworkState(result: ((ReachableStatus) -> Void)?){
        if reachability == nil {
            guard let reachability = try? Reachability() else {
                result?(.unknown)
                return
            }
            self.reachability = reachability
        }
        
        self.reachability?.whenReachable = { reach in
            switch reach.connection {
            case .wifi:
                self.status = .useful(connection: .wifi)
                printLog("网络状态： WiFi")
            case .cellular:
                self.status = .useful(connection: .cellular)
                printLog("网络状态： Cellular")
            case .unavailable:
                self.status = .useless
                printLog("网络不可用-unavailable")
            }
            result?(self.status)
        }
        
        self.reachability?.whenUnreachable = { _ in
            self.status = .useless
            printLog("网络不可用")
        }
        
        do {
            try self.reachability?.startNotifier()
        } catch {
            result?(.unknown)
            return
        }
        
        
    }
    
    
    func stopCheckNetworkState() {
        self.reachability?.stopNotifier()
    }
    
}
