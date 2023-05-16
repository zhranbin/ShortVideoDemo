//
//  RBRefreshFooter.swift
//  RBRefresh
//
//  Created by 冉彬 on 2020/4/26.
//  Copyright © 2020 BigWhite. All rights reserved.
//

import UIKit

let RBRefreshFooterViewH: CGFloat = 50


class RBRefreshFooter: RBRefreshFooterProtocol {
    var isQuick: Bool = false
    var refreshHeight: CGFloat = 0
    var refreshAction: (() -> Void)? = nil
//    var isHidden: Bool = false {
//        didSet {
//            view.isHidden = isHidden
//            if isHidden {
//                self.endRefresh()
//            }
//        }
//    }
    
    lazy var view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: RBRefreshFooterViewH))
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: RBRefreshFooterViewH))
        label.backgroundColor = .clear
        label.text = "上拉加载更多"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .init(white: 0.2, alpha: 1)
        label.sizeToFit()
        label.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.center = CGPoint(x: self.textLabel.frame.origin.x - view.frame.size.width - 5, y: self.textLabel.center.y)
        if #available(iOS 13.0, *) {
            view.style = .medium
        } else {
            view.style = .gray
        }
        view.color = .init(white: 0.2, alpha: 1)
        view.backgroundColor = .clear
        view.startAnimating()
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
                self.textLabel.text = "上拉加载更多"
                isShowActivityIndicator = false
            case .willRefresh:
                self.textLabel.text = "松手开始加载"
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
        self.isQuick = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
