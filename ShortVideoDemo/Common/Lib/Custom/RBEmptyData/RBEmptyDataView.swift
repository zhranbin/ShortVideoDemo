//
//  RBEmptyDataView.swift
//  BangJiaJia
//
//  Created by 冉彬 on 2021/12/26.
//

import UIKit

class RBEmptyDataView: UIView {
    
    
    private lazy var imageView: UIImageView = {
        let image: UIImage = UIImage(named: "resource.bundle/empty_icon.png") ?? UIImage()
        let imageV = UIImageView(image: image)
        imageV.contentMode = .center
        return imageV
        
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "这里空空如也"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(red: 143/255, green: 155/255, blue: 179/255, alpha: 1)
        return label
    }()
    
    private lazy var subTextLabel: UILabel = {
        let label = UILabel()
        label.text = "愿清风里都掺着淡淡的麦香"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()
    
    private var customView: UIView?
    
    
    /// 默认界面
    /// - Returns: 默认样式默认值
    public class func defauleView() -> RBEmptyDataView {
        return RBEmptyDataView(image: nil, text: nil, subText: nil)
    }
    
    
    ///  默认样式
    /// - Parameters:
    ///   - image: 图片
    ///   - text: 文字
    ///   - subText: 子文本
    public init(image: UIImage?, text: String?, subText: String?) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.addSubview(imageView)
        self.addSubview(textLabel)
        self.addSubview(subTextLabel)
        if image != nil {
            self.imageView.image = image
        }
        if text != nil {
            self.textLabel.text = text
        }
        if subText != nil {
            self.subTextLabel.text = subText
        }
    }
    
    /// 自定义界面（会默认布局在中间）
    /// - Parameter customView: 自定义view
    public init(customView: UIView) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.customView = customView
        self.addSubview(customView)
        
    }
    
    
    /// 刷新界面UI
    public func refreshUI() {
        self.imageView.sizeToFit()
        self.textLabel.sizeToFit()
        self.subTextLabel.sizeToFit()
        let selfW = self.bounds.width
        let selfH = self.bounds.height
        self.imageView.center = CGPoint(x: selfW/2, y: selfH/3)
        self.textLabel.center = CGPoint(x: selfW/2, y: self.imageView.center.y + self.imageView.bounds.height/2 + 8 + self.textLabel.bounds.height/2)
        self.subTextLabel.center = CGPoint(x: selfW/2, y: self.textLabel.center.y + self.textLabel.bounds.height/2 + 8 + self.subTextLabel.bounds.height/2)
        if self.customView != nil {
            self.customView?.center = CGPoint(x: selfW/2, y: selfH/2)
        }
    }
    
    
    private init() {
        super.init(frame: .zero)
    }
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
