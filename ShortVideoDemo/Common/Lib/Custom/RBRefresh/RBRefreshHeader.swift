//
//  RBRefreshHeader.swift
//  RBRefresh
//
//  Created by 冉彬 on 2020/4/29.
//  Copyright © 2020 BigWhite. All rights reserved.
//

import UIKit

class RBRefreshHeader: RBRefreshHeaderProtocol {
    var isQuick: Bool = false
    var refreshHeight: CGFloat = 0
    var refreshAction: (() -> Void)? = nil
    lazy var view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: RBRefreshFooterViewH))
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: RBRefreshFooterViewH))
        label.backgroundColor = .clear
        label.text = "下拉刷新"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .init(white: 0.2, alpha: 1)
        label.sizeToFit()
        label.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            view.style = .medium
        } else {
            view.style = .gray
        }
        view.color = .init(white: 0.2, alpha: 1)
        view.backgroundColor = .clear
        view.startAnimating()
        view.center = CGPoint(x: self.textLabel.centerX, y: self.textLabel.center.y)
        view.isHidden = true
        return view
    }()
    
    
    func stateChanged(state: RBRefreshVMState) {
        //
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            var isShowActivityIndicator = false
                    self.activityIndicator.isHidden = true
                    switch state {
                    case .normal:
                        self.textLabel.text = "下拉刷新"
                        isShowActivityIndicator = false
                    case .willRefresh:
                        self.textLabel.text = "松手开始刷新"
                        isShowActivityIndicator = false
                    case .refreshing:
                        if self.isShow {
                            self.textLabel.text = ""
                            isShowActivityIndicator = true
                        }
                        
                    }
                    self.textLabel.sizeToFit()
                    self.textLabel.center = CGPoint(x: self.view.frame.size.width/2 + (isShowActivityIndicator ? 20 : 0), y: self.view.frame.size.height/2)
                    if self.textLabel.text?.count ?? 0 > 0 {
                        self.activityIndicator.center = CGPoint(x: self.textLabel.frame.origin.x - 20, y: self.textLabel.center.y)
                    } else {
                        self.activityIndicator.center = CGPoint(x: self.view.frame.size.width/2, y: self.textLabel.center.y)
                    }
                    self.activityIndicator.isHidden = !isShowActivityIndicator
        }
        
        
        
    }
    
    func setUI() {
        self.view.addSubview(self.textLabel)
        self.view.addSubview(self.activityIndicator)
        
    }
    
    
    
    
    init(action: (() -> Void)?) {
        self.setUI()
        self.refreshAction = action
        self.isShow = true
        self.refreshHeight = 55
        self.isQuick = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
