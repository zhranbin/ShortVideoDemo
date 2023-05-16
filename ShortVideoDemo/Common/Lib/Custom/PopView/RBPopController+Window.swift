//
//  RBPopController+Alert.swift
//  ReviewAPP
//
//  Created by 冉彬 on 2020/5/26.
//  Copyright © 2020 BigWhite. All rights reserved.
//

import Foundation
import UIKit

extension RBPopController {
    
    
    
//    lazy var popView: BGPopView = {
//        let app = UIApplication.shared.delegate as? AppDelegate
//        let window = app?.window
//        let view = BGPopView(frame: CGRect(x: 0, y: 0, width: window!.frame.size.width, height: window!.frame.size.height))
//        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
//
//        view.addTarget(self, action: #selector(popViewAction), for: .touchUpInside)
//
//        return view
//    }()
    
//    @objc func popViewAction(sender: UIControl){
//        if isClickHidden {
//            self.hiddenAnimate()
//        }
//    }
    
    
    /// 弹出一个屏幕中间的view
    /// - Parameter view: 需要弹出的view
    class func showInWindowCenter(view: UIView) {
        self.showView(view: view, type: .center, isClick: false)
        
    }
    
    /// 弹出一个屏幕底部的view
    /// - Parameter view: 需要弹出的view
    class func showInWindowBottom(view: UIView) {
        self.showView(view: view, type: .bottom, isClick: true)
    }
    
    
    /// 弹出一个View
    /// - Parameters:
    ///   - view: 需要弹出的view
    ///   - type: 位置类型
    ///   - isClick: 是否允许点击隐藏
    class func showInWindowView(view: UIView, type: LocationType, isClick: Bool) {
        
        switch type {
        case .center:
            view.center = CGPoint(x: self.shared.popView.frame.size.width/2, y: self.shared.popView.frame.size.height/2)
            self.showView(view: view, frame: view.frame, animateType: .alpha, duration: 0.2, isClickHidden: isClick)
        case .bottom:
            view.center = CGPoint(x: self.shared.popView.frame.size.width/2, y: self.shared.popView.frame.size.height/2 + (self.shared.popView.frame.size.height - view.frame.size.height)/2)
            self.showView(view: view, frame: view.frame, animateType: .bottom, duration: 0.2, isClickHidden: isClick)
        }
        
        
    }
    
    
    
    /// 弹出一个View
    /// - Parameters:
    ///   - view: 需要弹出的view
    ///   - frame: view的位置（相对于window）
    ///   - animateType: 弹出动画类型
    ///   - duration: 动画持续时间
    ///   - isClickHidden: 是否允许点击隐藏
    class func showInWindowView(view: UIView, frame: CGRect, animateType: AnimateType, duration: TimeInterval, isClickHidden: Bool) {
        self.shared.removeSubViews()
        let app = UIApplication.shared.delegate as? AppDelegate
        let window = app?.window
        view.frame = frame
        self.shared.popView.addSubview(view)
        window?.addSubview(self.shared.popView)
        self.shared.contentView = view
        self.shared.animateType = animateType
        self.shared.animateDuration = duration
        self.shared.isClickHidden = isClickHidden
        self.shared.showAnimate()
    }
    
}
