//
//  LocationManager.swift
//  LocationProject
//
//  Created by mac on 2021/12/28.
//


import UIKit
import CoreLocation


enum LocationStatus: String {
    case success = "定位成功"
    case locating = "正在定位中"
    case notEnabled = "定位服务不可用"
    case notDetermined = "定位授权未选择"
    case restricted = "定位权限受限制"
    case denied = "用户拒绝了定位权限"
    case failed = "获取定位信息失败"
    case unknow = "未知"
}


typealias LocationResultAction = (LocationStatus,CLLocation?) -> Void
/// 队列（保证定位器不被销毁）
var locationManagerAry: [LocationManager] = []


class LocationManager: NSObject,CLLocationManagerDelegate {
    
    /// 结果回调
    private var resultAction: LocationResultAction? = nil
    /// 是否只获取一次
    private var isOnce: Bool = false
    private var manager:  CLLocationManager?
    private var location: CLLocation?
    /// 是否正在定位中
    public var isLocating: Bool = false
    
    fileprivate override init() {
        super.init()
        self.manager = CLLocationManager()
        self.manager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.manager?.requestWhenInUseAuthorization()
        self.manager?.delegate = self
        self.isLocating = false
    }
    
    
    /// 获取一次定位
    /// - Parameter resultAction: 结果回调
    public class func updateLocationOnce(_ resultAction: @escaping LocationResultAction) {
        let locationManager = LocationManager()
        locationManager.isOnce = true
        locationManager.resultAction = resultAction
        locationManagerAry.append(locationManager)
        locationManager.startUpdateLocation()
    }
    
    /// 创建
    /// - Parameter resultAction: 结果回调
    /// - Returns: LocationManager
    public class func createLocationManager(resultAction: @escaping LocationResultAction) -> LocationManager {
        let locationManager = LocationManager()
        locationManager.isOnce = false
        locationManager.resultAction = resultAction
        return locationManager
    }
    
    
    /// 开始更新位置信息
    public func startUpdateLocation() {
        if self.isLocating {
            self.resultAction?(.locating, self.location)
            return
        }
        if CLLocationManager.locationServicesEnabled() {
            var status: CLAuthorizationStatus = .notDetermined
            if #available(iOS 14.0, *) {
                status = self.manager?.authorizationStatus ?? .notDetermined
            } else {
                status = CLLocationManager.authorizationStatus()
            }
            switch status {
            case .notDetermined, .authorizedAlways, .authorizedWhenInUse:
                self.manager?.startUpdatingLocation()
                self.isLocating = true
            case .restricted:
                self.resultAction?(.restricted,nil)
                self.checkEndOnce()
            case .denied:
                self.resultAction?(.denied,nil)
                self.checkEndOnce()
            
            @unknown default:
                self.resultAction?(.unknow,nil)
                self.checkEndOnce()
            }
            
        }else{
            self.resultAction?(.notEnabled,nil)
        }
    }
    
    /// 结束更新
    public func stopUpdateLocation() {
        if self.isLocating {
            self.manager?.stopUpdatingLocation()
            self.isLocating = false
        }
    }
    
    /// 从队列中移除
    private func removeFromeAry() {
        for index in 0 ..< locationManagerAry.count {
            let lm = locationManagerAry[index]
            if lm == self {
                locationManagerAry.remove(at: index)
                return
            }
        }
    }
    
    private func checkEndOnce() {
        if self.isOnce {
            self.stopUpdateLocation()
            self.removeFromeAry()
        }
    }
    
    deinit {
        print("LocationManager销毁")
    }
    
    // MARK: CLLocationManagerDelegate
    
    // 代理方法，当定位授权更新时回调
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        if status == .notDetermined {
            self.startUpdateLocation()
        }
//        print("状态：\(status.rawValue)")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let status: CLAuthorizationStatus?
        if #available(iOS 14.0, *) {
            status = self.manager?.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        
        if status != nil {
            if status != .notDetermined {
                switch status {
                case .restricted:
                    self.resultAction?(.restricted,nil)
                case .denied:
                    self.resultAction?(.denied,nil)
                default:
                    self.resultAction?(.failed,nil)
                }
                self.checkEndOnce()
            }
        } else {
            self.resultAction?(.failed,nil)
            self.checkEndOnce()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.resultAction?(.success,locations.last)
        self.location = locations.last
        self.checkEndOnce()
    }
    
}
