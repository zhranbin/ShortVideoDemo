//
//  RBLoading.swift
//  BWRefresh
//
//  Created by 冉彬 on 2020/4/24.
//  Copyright © 2020 BigWhite. All rights reserved.
//

import UIKit

enum RBLoadingStyle {
    case light // 白色风格
    case dark  // 黑暗风格
}


class RBLoading: UIView {
    
    private var _style: RBLoadingStyle = .dark
    private var style: RBLoadingStyle {
        get {
            return _style
        }
        set {
            _style = newValue
            if _style == .dark {
                self.contentView.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
                self.activityIndicator.color = .white
                self.textLabel.textColor = .white
            }else {
                self.contentView.backgroundColor = UIColor(white: 1, alpha: 1.0)
                self.activityIndicator.color = .lightGray
                self.textLabel.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
            }
        }
    }
    
    private var _text: String = ""
    private var text: String {
        get {
            return _text
        }
        set {
            _text = newValue
            if _text.count > 0 {
                
//                self.activityIndicator.style = .medium
                self.textLabel.isHidden = false
                self.textLabel.text = _text
                self.textLabel.sizeToFit()
                let maxH = self.contentView.frame.size.height - 20 - 20 - 5
                var frame = self.textLabel.frame
                frame.size.height = self.textLabel.frame.size.height > maxH ? maxH : self.textLabel.frame.size.height
                self.textLabel.frame = frame
                
                // 上下边距
                let sp = (self.contentView.frame.size.height - 36 - self.textLabel.frame.size.height - 5)/2
                
                self.activityIndicator.center = CGPoint(x: self.contentView.frame.size.width/2, y: 36/2 + sp)
                self.textLabel.center = CGPoint(x: self.contentView.frame.size.width/2, y: self.contentView.frame.size.height - self.textLabel.frame.size.height/2 - sp)
                
            } else {
//                self.activityIndicator.style = .large
                self.activityIndicator.center = CGPoint(x: self.contentView.frame.size.width/2, y: self.contentView.frame.size.height/2)
                self.textLabel.isHidden = true
            }
        }
    }
    
    
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            view.style = .large
        } else {
            view.style = .whiteLarge
            // Fallback on earlier versions
        }
        view.color = .lightGray
        view.backgroundColor = .clear
        view.startAnimating()
        return view
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width - 20, height: 1000))
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 100))
        view.backgroundColor = .white
        view.addSubview(self.activityIndicator)
        view.addSubview(self.textLabel)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        return view
    }()
    
    
    
    private init(text: String, style: RBLoadingStyle) {
        super.init(frame: UIScreen.main.bounds)
        self.text = text
        self.style = style
        self.backgroundColor = UIColor(white: 0.1, alpha: 0.2)
        self.addSubview(self.contentView)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 显示加载框
    /// - Parameters:
    ///   - text: 加载文字
    ///   - style: 风格
    class func showLoding(text: String = "", style: RBLoadingStyle = .dark) {
        self.hiddenLoding()
        let view = RBLoading(text: text, style: style)
        let app = UIApplication.shared.delegate as? AppDelegate
        let window = app?.window
        DispatchQueue.main.async {
            window?.addSubview(view)
        }
        
        
    }
    
    /// 隐藏加载框
    class func hiddenLoding() {
        DispatchQueue.main.async {
            let app = UIApplication.shared.delegate as? AppDelegate
            let window = app?.window ?? UIWindow()
            for view in window.subviews {
                if view is RBLoading {
                    DispatchQueue.main.async {
                        view.removeFromSuperview()
                    }
                    
                }
            }
        }
        
    }
    
    
    

}
