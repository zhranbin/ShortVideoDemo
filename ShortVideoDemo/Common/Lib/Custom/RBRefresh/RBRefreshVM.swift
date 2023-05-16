//
//  RBRefreshViewProtocol.swift
//  RBRefresh
//
//  Created by 冉彬 on 2020/4/26.
//  Copyright © 2020 BigWhite. All rights reserved.
//

import Foundation
import UIKit

enum RBRefreshVMState {
    case normal
    case willRefresh
    case refreshing
}

protocol RBRefreshVM: AnyObject {
    var view: UIView { get set }
    var state: RBRefreshVMState {get set}
    var isShow: Bool {get set}
    var refreshHeight: CGFloat {get set}  // 滑动超过内容高度 此数值后进入 willRefresh
    var isQuick: Bool {get set} // 是否是灵敏模式（滑动超过内容高度立即进入refreshing）
    
    var refreshAction: (() -> Void)? {get}
    func stateChanged(state: RBRefreshVMState)
    
    
}

protocol RBRefreshHeaderProtocol: RBRefreshVM{
    //
    
}


protocol RBRefreshFooterProtocol: RBRefreshVM{
    //
}





var stateKey = "stateKey"
var isShowKey = "isShowKey"
extension RBRefreshVM {
    
    var isShow: Bool {
        get {
            return objc_getAssociatedObject(self, &isShowKey) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(self, &isShowKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            DispatchQueue.main.async {[weak self] in
                self?.view.isHidden = !newValue
            }
            
            
        }
    }
    
    func endRefresh() {
        self.state = .normal
    }
    
    
    
}

extension RBRefreshHeaderProtocol {
    var state: RBRefreshVMState {
            get {
                return objc_getAssociatedObject(self, &stateKey) as? RBRefreshVMState ?? RBRefreshVMState.normal
            }
            set {
                objc_setAssociatedObject(self, &stateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                self.stateChanged(state: newValue)
//                var isscro = false
//                if sView.contentInset.bottom == viewH  {
//                    isscro = true
//                }
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else {return}
                    let sView = self.view.superview as! UIScrollView
                    let viewH = self.view.frame.size.height
                    if self.isShow && newValue == .refreshing {
                        UIView.animate(withDuration: 0.2) {[weak self, sView] in
                            sView.contentInset = UIEdgeInsets(top: viewH, left: 0, bottom: 0, right: 0)
                            self?.refreshAction?()
                        }
                        
                    }else {
                        UIView.animate(withDuration: 0.2) {[sView] in
                            sView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //                        print(self?.view as Any)
                        }
                        
                    }
                }
                
            }
    }

}

extension RBRefreshFooterProtocol {
    
    var state: RBRefreshVMState {
        get {
            return objc_getAssociatedObject(self, &stateKey) as? RBRefreshVMState ?? RBRefreshVMState.normal
        }
        set {
            objc_setAssociatedObject(self, &stateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            DispatchQueue.main.async {[weak self] in
                guard let self = self else {return}
                self.stateChanged(state: newValue)
                let sView = self.view.superview as! UIScrollView
                let viewH = self.view.frame.size.height
                var isscro = false
                if sView.contentInset.bottom == viewH  {
                    isscro = true
                }
                
                if self.isShow && newValue == .refreshing {
                    
                    UIView.animate(withDuration: 0.2) {
                        sView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: viewH, right: 0)
                    } completion: {[weak self] (com) in
                        if com {
                            self?.refreshAction?()
                        }
                    }
                    
                }else {
                    sView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                    if isscro {
                        // 处理界面闪动
                        sView.contentOffset = CGPoint(x: sView.contentOffset.x, y: sView.contentOffset.y + viewH)
                    }
                }
            }
        }
    }
}



