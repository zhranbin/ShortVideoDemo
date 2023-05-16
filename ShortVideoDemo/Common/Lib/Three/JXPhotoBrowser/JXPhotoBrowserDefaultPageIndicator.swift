//
//  JXPhotoBrowserDefaultPageIndicator.swift
//  JXPhotoBrowser
//
//  Created by JiongXing on 2019/11/25.
//  Copyright © 2019 JiongXing. All rights reserved.
//

import UIKit

open class JXPhotoBrowserDefaultPageIndicator: UIPageControl, JXPhotoBrowserPageIndicator {
    
    /// 页码与底部的距离
    open lazy var bottomPadding: CGFloat = {
        if #available(iOS 11.0, *),
            let window = getCurrentWindow(),
            window.safeAreaInsets.bottom > 0 {
            return 20
        }
        return 15
    }()
    
    open func setup(with browser: JXPhotoBrowser) {
        isEnabled = false
    }
    
    open func reloadData(numberOfItems: Int, pageIndex: Int) {
        numberOfPages = numberOfItems
        currentPage = min(pageIndex, numberOfPages - 1)
        sizeToFit()
        isHidden = numberOfPages <= 1
        if let view = superview {
            center.x = view.bounds.width / 2
            frame.origin.y = view.bounds.maxY - bottomPadding - bounds.height
        }
    }
    
    open func didChanged(pageIndex: Int) {
        currentPage = pageIndex
    }
    
    
    func getCurrentWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            if let window = UIApplication.shared.connectedScenes
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
