//
//  RBToast.swift
//  WeiZhiYou
//
//  Created by 冉彬 on 2022/4/9.
//

import UIKit

/// 风格
enum RBToastaStyle {
    /// 黑色
    case dark
    /// 白色
    case light
    /// 自定义(文字颜色，字体，背景颜色)
    case custom(textColor: UIColor, textFont: UIFont, backgroundColor: UIColor)
}


class RBToast: UIView {
    
    /// 默认字体颜色(黑色风格)
    let defauleDarkTextColor: UIColor = .white
    /// 默认字体颜色(黑色风格)
    let defauleDarkTextFont: UIFont = .systemFont(ofSize: 14)
    /// 默认字体颜色(黑色风格)
    let defauleDarkBackgroundColor: UIColor = UIColor(red: 0.275, green: 0.275, blue: 0.275, alpha: 1)
    
    /// 默认字体颜色(白色风格)
    let defauleLightTextColor: UIColor = UIColor(red: 0.233, green: 0.199, blue: 0.199, alpha: 1)
    /// 默认字体颜色(白色风格)
    let defauleLightTextFont: UIFont = .systemFont(ofSize: 14)
    /// 默认字体颜色(白色风格)
    let defauleLightBackgroundColor: UIColor = .white
    
    
    private var textLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 60, height: 10000))
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadSubViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func loadSubViews() {
        addSubview(textLabel)
    }
    
    private func refreshUI(text: String, style: RBToastaStyle) {
        self.textLabel.text = text
        switch style {
        case .dark:
            self.textLabel.font = defauleDarkTextFont
            self.textLabel.textColor = defauleDarkTextColor
            self.backgroundColor = defauleDarkBackgroundColor
        case .light:
            self.textLabel.font = defauleLightTextFont
            self.textLabel.textColor = defauleLightTextColor
            self.backgroundColor = defauleLightBackgroundColor
        case .custom(let textColor, let textFont, let backgroundColor):
            self.textLabel.font = textFont
            self.textLabel.textColor = textColor
            self.backgroundColor = backgroundColor
        }
        let edg = UIEdgeInsets(top: 12, left: 22, bottom: 12, right: 22)
        let SW = UIScreen.main.bounds.size.width
        let SH = UIScreen.main.bounds.size.height
        self.textLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 80 - edg.left - edg.right, height: CGFloat(MAXFLOAT))
        self.textLabel.sizeToFit()
       
        let H: CGFloat = min(self.textLabel.bounds.height, SH - 160)
        let W = self.textLabel.bounds.width
        self.frame = CGRect(x: (SW - W - edg.left - edg.right)/2, y: (SH - H - edg.top - edg.bottom)/2, width: W + edg.left + edg.right, height: H + edg.top + edg.bottom)
        self.textLabel.frame = CGRect(x: edg.left, y: edg.top, width: W, height: H)
        self.layer.cornerRadius = 8
//        self.layer.masksToBounds = true
        //设置阴影颜色
        self.layer.shadowColor = UIColor(white: 0.88, alpha: 1).cgColor
        //设置透明度
        self.layer.shadowOpacity = 0.4
        //设置阴影半径
        self.layer.shadowRadius = 8
        //设置阴影偏移量
        self.layer.shadowOffset = .zero
        
        
        
        
    }
    
    
    /// 显示信息
    /// - Parameters:
    ///   - message: 文字
    ///   - style: 风格（默认黑色风格）
    ///   - time: 显示时间（默认3秒）
    class func showMessage(_ message: String, style: RBToastaStyle = .dark, time: TimeInterval = 3) {
        DispatchQueue.main.async {
            let toastView = RBToast(frame: .zero)
            toastView.refreshUI(text: message, style: style)
            if let window = getWindow() {
                let X = (window.bounds.width - toastView.bounds.width)/2
                let Y = (window.bounds.height - toastView.bounds.height)/2
                toastView.frame = CGRect(x: X, y: Y, width: toastView.bounds.width, height: toastView.bounds.height)
                toastView.alpha = 0
                window.addSubview(toastView)
                UIView.animate(withDuration: 0.2, delay: 0) {
                    toastView.alpha = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                    UIView.animate(withDuration: 0.2) {
                        toastView.alpha = 0
                    } completion: { _ in
                        toastView.removeFromSuperview()
                    }
                }
                
            }
        }
        
    }
    
    
    /// 获取当前Window
    /// - Returns: Window
    class func getWindow() -> UIWindow? {
        let app = UIApplication.shared
        
        if #available(iOS 13.0, *) {
            if let window = app.connectedScenes
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
    
}
