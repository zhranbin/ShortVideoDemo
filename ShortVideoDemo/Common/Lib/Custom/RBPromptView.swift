//
//  RBPromptView.swift
//  VerifyAPP
//
//  Created by 冉彬 on 2020/2/17.
//  Copyright © 2020 BigWhite. All rights reserved.
//

import UIKit

class RBPromptView {
    var showTime:TimeInterval = 2.2
    
    lazy var view:UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44 + topSafeAreaHeight))
        v.backgroundColor = hexColor(0x3366ff)
        v.addSubview(textLabel)
        return v
    }()
    
    lazy var textLabel:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: topSafeAreaHeight, width: screenWidth, height: 44))
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    init() {
//        self.view.addSubview(self.textLabel)
    }
    
    /// 显示提示框
    /// - Parameters:
    ///   - message: 提示信息
    class func show(message:String) {
        DispatchQueue.main.async {
            let promptView = RBPromptView()
            promptView.textLabel.text = message
            promptView.showView()
        }
        
    }
    
    /// 显示提示框
    /// - Parameters:
    ///   - message: 提示信息
    ///   - time: 保留时间
    class func show(message:String, time:TimeInterval) {
        let promptView = RBPromptView()
        promptView.showTime = time
        promptView.textLabel.text = message
        promptView.showView()
        
    }
    
    /// 将view加载到window上
    private func showView() {
        let app = UIApplication.shared.delegate as? AppDelegate
        let window = app?.window
        if (window != nil) {
            window!.addSubview(self.view)
            self.showAnimation()
        }
    }
    
    /// 展示动画
    private func showAnimation() {
        self.view.y = -self.view.height
        UIView.animate(withDuration: 0.15, animations: {
            self.view.y = 0
        }) { (isCompletion) in
            if isCompletion {
                self.hiddenAnimation()
            }
        }
    }
    
    /// 隐藏动画
    private func hiddenAnimation() {
        UIView.animate(withDuration: 0.15, delay: self.showTime, options: .curveEaseIn, animations: {
            self.view.y = -self.view.height
        }) { (isCompletion) in
            if isCompletion {
                self.view.removeFromSuperview()
            }
        }
    }
    
}
