//
//  RBRefreshManager.swift
//  RBRefresh
//
//  Created by 冉彬 on 2020/4/23.
//  Copyright © 2020 BigWhite. All rights reserved.
//

import UIKit

let RBContentOffsetKey:String = "contentOffset"
let RBContentSizeKey:String = "contentSize"
let RBStateKey:String = "state"

class RBRefreshManager: NSObject {
    weak var scrollView: UIScrollView?  // 监听的scrollerView
    weak var gesture: UIPanGestureRecognizer?  // 监听手势
    
    
    deinit {
        self.removeObservers()
    }
    
    /// 绑定scrollerView
    /// - Parameter scrollView: scrollerView
    func bindingScrollerView(scrollView: UIScrollView) {
        self.scrollView = scrollView
        if scrollView is UITableView {
            // （预估高度设为0）避免滑动过程中contentSize不断变化， 坑！！！
            (self.scrollView as! UITableView).estimatedRowHeight = 0
        }
        self.addObservers()
    }
    
    /// 添加监听
    func addObservers() {
        self.scrollView?.addObserver(self, forKeyPath: RBContentOffsetKey, options: [.new,.old], context: nil)
        self.scrollView?.addObserver(self, forKeyPath: RBContentSizeKey, options: [.new,.old], context: nil)
        // 监听手势
        self.gesture = self.scrollView?.panGestureRecognizer
        self.gesture?.addObserver(self, forKeyPath: RBStateKey, options: [.new,.old], context: nil)
        
    }
    
    /// 移除监听
    func removeObservers() {
        self.scrollView?.removeObserver(self, forKeyPath: RBContentOffsetKey)
        self.scrollView?.removeObserver(self, forKeyPath: RBContentSizeKey)
        self.gesture?.removeObserver(self, forKeyPath: RBStateKey)
    }
    
    
    /// 监听触发
    /// - Parameters:
    ///   - keyPath: 监听的属性
    ///   - object: 被监听对象
    ///   - change: 改变后的数据
    ///   - context: context
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        var frame = scrollView?.rb_header?.view.frame ?? CGRect.zero
        frame.origin.x = 0
        frame.size.width = scrollView?.frame.width ?? 0
        scrollView?.rb_header?.view.frame = frame
        var frame1 = scrollView?.rb_footer?.view.frame ?? CGRect.zero
        frame1.origin.x = 0
        frame1.size.width = scrollView?.frame.width ?? 0
        scrollView?.rb_footer?.view.frame = frame1
        
        
        let scConH = scrollView?.contentSize.height ?? 0
        // content大小发生变化
        if keyPath == RBContentSizeKey {
            var rect = scrollView?.rb_footer?.view.frame
            rect?.origin.y = scConH
            scrollView?.rb_footer?.view.frame = rect!
        }

        // content位置改变
        if keyPath == RBContentOffsetKey {

            if scrollView?.rb_footer != nil {
                self.contentOffsetKeyChangeFoot()
            }
            if scrollView?.rb_header != nil {
                self.contentOffsetKeyChangeHead()
            }
        }
        
        // 手势状态发生改变
        if keyPath == RBStateKey {
            if scrollView?.rb_footer != nil {
                if gesture?.state == .ended && scrollView?.rb_footer?.state == .willRefresh  {
                    scrollView?.rb_footer?.state = .refreshing
                }
            }
            
            if scrollView?.rb_header != nil {
                if gesture?.state == .began {
                    scrollView?.rb_header?.state = .normal
                }
                
                if gesture?.state == .ended {
                    if scrollView?.rb_header?.state == .willRefresh  {
                        scrollView?.rb_header?.state = .refreshing
                    }
                }
            }
            
        }
        
    }
    
    
    
    func contentOffsetKeyChangeHead() {
        let scY = (scrollView?.contentOffset.y ?? 0) + (scrollView?.adjustedContentInset.top ?? 0)
        if (scY + (scrollView?.rb_header?.refreshHeight ?? 0)) < 0
            && scrollView?.rb_header?.state == .normal
            && gesture?.state == .changed
        {
            scrollView?.rb_header?.state = .willRefresh
        }
        
    }
    
    func contentOffsetKeyChangeFoot() {
        
        let scH = scrollView?.frame.size.height ?? 0
        let scConH = scrollView?.contentSize.height ?? 0
        let scY = scrollView?.contentOffset.y ?? 0
        let h = scConH - scH
        let refreshH = scrollView?.rb_footer?.refreshHeight ?? 0
        
        if scrollView?.rb_footer?.isQuick ?? false {
            // 灵敏模式
            if h>0
                && (scY-h) > scrollView?.rb_footer?.refreshHeight ?? 60
                && scrollView?.rb_footer?.state == .normal
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {[weak self] in
                    guard let self = self else {return}
                    self.scrollView?.rb_footer?.state = .refreshing
                }
                
            }
        }else {
            
            if h>0
                && (scY-h) > refreshH
                && scrollView?.rb_footer?.state == .normal
                && gesture?.state == .changed
            {
                scrollView?.rb_footer?.state = .willRefresh
            }
            
        }
    }
    
    
    
    
}
