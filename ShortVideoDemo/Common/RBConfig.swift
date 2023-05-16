//
//  RBConfig.swift
//  RBExtendDemo
//
//  Created by RanBin on 2021/9/4.
//

import UIKit

// MARK: - 接口配置相关
 // https://www.document.com/

/// 是否是测试环境
let isTest = true

/// 接口url
let testHost = "https://test.com"
let formalHost = "https://www.formal.com"
let hostString = (isTest ? testHost : formalHost)

/// 资源url
let testResourceHost = ""
let formalResourceHost = ""
let resourceHost = isTest ? testResourceHost : formalResourceHost

/// 应用商店地址
let appStoreUrl = "https://apps.apple.com/cn/app/123456789"


// MARK: - 屏幕尺寸相关
/// 屏幕宽
let screenWidth = UIScreen.main.bounds.size.width
func getScreenWidth() -> CGFloat {
    return UIScreen.main.bounds.size.width
}

/// 屏幕高
let screenHeight = UIScreen.main.bounds.size.height
func getScreenHeight() -> CGFloat {
    return UIScreen.main.bounds.size.height
}

/// 底部安全距离
let bottomSafeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0

/// 顶部的安全距离
let topSafeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0.0


//导航栏高度
let navigationHeight = CGFloat(44)

//大标题导航栏高度
let bignavH = CGFloat(64)


/// 状态栏高度
let statusBarHeight = getStatusBarHeight()
func getStatusBarHeight() -> CGFloat {
    var statusBarHeight: CGFloat = 0.0
    if #available(iOS 13.0, *){
        let statusBarManager:UIStatusBarManager = UIApplication.shared.windows.first!.windowScene!.statusBarManager!
        statusBarHeight = statusBarManager.statusBarFrame.size.height
    }
    else {
        statusBarHeight = UIApplication.shared.statusBarFrame.height
    }
    return statusBarHeight
}


// MARK: - 颜色
func hexColor(_ hexColor: Int) -> UIColor! {
    let color = UIColor(red: ((CGFloat)((hexColor & 0xFF0000) >> 16)) / 255.0,
                        green: ((CGFloat)((hexColor & 0xFF00) >> 8)) / 255.0,
                        blue: ((CGFloat)(hexColor & 0xFF)) / 255.0,alpha: 1.0)
    
    
    return color
}

func hexColor(hexColor: Int, alpha: Float) -> UIColor! {
    return UIColor(red: ((CGFloat)((hexColor & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((hexColor & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(hexColor & 0xFF)) / 255.0,alpha: CGFloat(alpha))
}


let defauleNoImage = "image_def_1"



// MARK: - 时间

/// 获取当前时间戳（秒）
func getNowTimeStamp() -> String {
    //获取当前时间
    let now = Date()
    //当前时间的时间戳
    let timeInterval:TimeInterval = now.timeIntervalSince1970
    let timeStamp = Int(timeInterval)
    return "\(timeStamp)"
}

/// 获取当前时间
/// - Parameter dateFormat: 时间格式（如：yyyy-MM-dd HH:mm:ss）
func getNowTimeString(dateFormat: String) -> String {
    //获取当前时间
    let now = Date()
    // 创建一个日期格式器
    let dformatter = DateFormatter()
    dformatter.dateFormat = dateFormat
    return dformatter.string(from: now)
}


// MARK: - 其他
/// 截屏
func screenSnapshot() -> UIImage? {
    guard UIScreen.main.bounds.size.height > 0 && UIScreen.main.bounds.size.width > 0 else {
        return nil
    }
    UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, true, UIScreen.main.scale)
    
    var window: UIWindow? = nil
    if #available(iOS 13.0, *) {
        window = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .last?.windows
            .filter({ $0.isKeyWindow })
            .last
    } else {
        window = UIApplication.shared.keyWindow
    }
    if window == nil {
        return nil
    }
    window!.drawHierarchy(in: window!.bounds, afterScreenUpdates: true)  // 高清截图
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}



