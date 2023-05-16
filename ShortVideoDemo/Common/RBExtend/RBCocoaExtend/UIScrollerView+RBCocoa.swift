//
//  UIScrollerView+RBCocoa.swift
//  Housekeeping
//
//  Created by RanBin on 2021/10/24.
//

import Foundation
import UIKit

extension UIScrollView {
    
}

extension UIScrollView {
    
    @discardableResult
    override func frameSet(_ frame: CGRect) -> UIScrollView {
        return super.frameSet(frame) as! UIScrollView
    }
    
    @discardableResult
    override func xSet(_ x: CGFloat) -> UIScrollView {
        return super.xSet(x) as! UIScrollView
    }
    
    @discardableResult
    override func ySet(_ y: CGFloat) -> UIScrollView {
        return super.ySet(y) as! UIScrollView
    }
    
    @discardableResult
    override func widthSet(_ width: CGFloat) -> UIScrollView {
        return super.widthSet(width) as! UIScrollView
    }
    
    @discardableResult
    override func heightSet(_ height: CGFloat) -> UIScrollView {
        return super.heightSet(height) as! UIScrollView
    }
    
    @discardableResult
    override func sizeSet(_ size: CGSize) -> UIScrollView {
        return super.sizeSet(size) as! UIScrollView
    }
    
    @discardableResult
    override func centerSet(_ center: CGPoint) -> UIScrollView {
        return super.centerSet(center) as! UIScrollView
    }
    
    @discardableResult
    override func centerXSet(_ x: CGFloat) -> UIScrollView {
        return super.centerXSet(x) as! UIScrollView
    }
    
    @discardableResult
    override func centerYSet(_ y: CGFloat) -> UIScrollView {
        return super.centerYSet(y) as! UIScrollView
    }
    
    @discardableResult
    override func backgroundColorSet(_ color: UIColor) -> UIScrollView {
        return super.backgroundColorSet(color) as! UIScrollView
    }
    
    @discardableResult
    override func alphaSet(_ alpha: CGFloat) -> UIScrollView {
        return super.alphaSet(alpha) as! UIScrollView
    }
    
    @discardableResult
    override func isHiddenSet(_ isHidden: Bool) -> UIScrollView {
        return super.isHiddenSet(isHidden) as! UIScrollView
    }
    
    @discardableResult
    override func contentModeSet(_ contentMode: UIView.ContentMode) -> UIScrollView {
        return super.contentModeSet(contentMode) as! UIScrollView
    }
    
    @discardableResult
    override func isOpaqueSet(_ isOpaque: Bool) -> UIScrollView {
        return super.isOpaqueSet(isOpaque) as! UIScrollView
    }
    
    @discardableResult
    override func clipsToBoundsSet(_ clipsToBounds: Bool) -> UIScrollView {
        return super.clipsToBoundsSet(clipsToBounds) as! UIScrollView
    }
    
    @discardableResult
    override func addTo(superView: UIView) -> UIScrollView {
        return super.addTo(superView: superView) as! UIScrollView
    }
    
}
