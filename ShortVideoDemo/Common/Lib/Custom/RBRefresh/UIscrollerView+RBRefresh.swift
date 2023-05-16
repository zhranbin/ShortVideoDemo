//
//  UIscrollerView+RBRefresh.swift
//  RBRefresh
//
//  Created by 冉彬 on 2020/4/23.
//  Copyright © 2020 BigWhite. All rights reserved.
//
import UIKit

private var headerkey = "header"
private var footerkey = "footer"
private var managerkey = "managerkey"

extension UIScrollView {
    
    /// 管理器
    var refreshManager: RBRefreshManager? {
        get{
            return objc_getAssociatedObject(self, &managerkey) as? RBRefreshManager
        }
        set(newValue) {
            objc_setAssociatedObject(self, &managerkey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            refreshManager?.bindingScrollerView(scrollView: self)
        }
    }
    
    /// header
    var rb_header: RBRefreshHeaderProtocol? {
        get{
            return objc_getAssociatedObject(self, &headerkey) as? RBRefreshHeaderProtocol
        }
        set(newValue) {
            if newValue == nil {
                rb_header?.view.removeFromSuperview()
            }else{
                rb_header?.view.removeFromSuperview()
                self.insertSubview(newValue!.view, at: 0)
                var frame = newValue?.view.frame
                frame?.origin.x = 0
                frame?.origin.y = -(newValue?.view.frame.size.height ?? 0)
                newValue?.view.frame = frame!
                newValue?.view.center = CGPoint(x: self.frame.size.width/2, y: newValue!.view.center.y)
            }
            objc_setAssociatedObject(self, &headerkey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            // 设置管理器
            if self.rb_footer == nil && self.rb_header == nil {
                self.refreshManager = nil
            } else if self.refreshManager == nil {
                self.refreshManager = RBRefreshManager()
            }
        }
    }
    
    /// footer
    var rb_footer: RBRefreshFooterProtocol? {
        get{
            return objc_getAssociatedObject(self, &footerkey) as? RBRefreshFooterProtocol
        }
        set(newValue) {
            if newValue == nil {
                rb_footer?.view.removeFromSuperview()
            }else{
                rb_footer?.view.removeFromSuperview()
                self.addSubview(newValue!.view)
                newValue!.view.center = CGPoint(x: self.frame.width/2, y: newValue!.view.center.y)
            }
            objc_setAssociatedObject(self, &footerkey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            // 设置管理器
            if self.rb_footer == nil && self.rb_header == nil  {
                self.refreshManager = nil
            } else if self.refreshManager == nil {
                self.refreshManager = RBRefreshManager()
            }
        }
    }
    
    
}
