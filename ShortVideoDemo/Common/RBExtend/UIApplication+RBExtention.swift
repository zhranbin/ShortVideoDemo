//
//  UIApplication+RBExtention.swift
//  Housekeeping
//
//  Created by 冉彬 on 2021/11/24.
//

import Foundation
import UIKit

extension UIApplication {
    
    /// 当前窗口
    var currentWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            if let window = connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first{
                return window
            }else if let window = UIApplication.shared.delegate?.window{
                return window
            }else{
                return nil
            }
        } else {
            if let window = UIApplication.shared.delegate?.window{
                return window
            }else{
                return nil
            }
        }
    }
    
    /// 当前显示的viewcontroller
    var currentViewController: UIViewController? {
        get {
            return currentViewController()
        }
    }
    
    
    /// 找到当前显示的viewcontroller
    /// - Parameter base: base
    /// - Returns: viewcontroller
    private func currentViewController(base: UIViewController? = UIApplication.shared.currentWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        if let split = base as? UISplitViewController{
            return currentViewController(base: split.presentingViewController)
        }
        return base
    }
    
}


// MARK: infoDictionary
extension UIApplication {
    var version: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    var build: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    }
    
    var displayName: String {
        return Bundle.main.infoDictionary?["CFBundleName"] as! String
    }
    
    var bundleId: String {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String
    }
    
    func call(_ phone: String) {
        self.open(URL(string:"tel://\(phone)")!, options: [UIApplication.OpenExternalURLOptionsKey: Any](), completionHandler: nil)
    }
}
