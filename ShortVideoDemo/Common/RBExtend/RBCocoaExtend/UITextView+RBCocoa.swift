//
//  UITextView+RBCocoa.swift
//  Housekeeping
//
//  Created by RanBin on 2021/10/24.
//

import Foundation
import UIKit

extension UITextView {
    
}

extension UITextView {
    
    @discardableResult
    override func frameSet(_ frame: CGRect) -> UITextView {
        return super.frameSet(frame) as! UITextView
    }
    
    @discardableResult
    override func xSet(_ x: CGFloat) -> UITextView {
        return super.xSet(x) as! UITextView
    }
    
    @discardableResult
    override func ySet(_ y: CGFloat) -> UITextView {
        return super.ySet(y) as! UITextView
    }
    
    @discardableResult
    override func widthSet(_ width: CGFloat) -> UITextView {
        return super.widthSet(width) as! UITextView
    }
    
    @discardableResult
    override func heightSet(_ height: CGFloat) -> UITextView {
        return super.heightSet(height) as! UITextView
    }
    
    @discardableResult
    override func sizeSet(_ size: CGSize) -> UITextView {
        return super.sizeSet(size) as! UITextView
    }
    
    @discardableResult
    override func centerSet(_ center: CGPoint) -> UITextView {
        return super.centerSet(center) as! UITextView
    }
    
    @discardableResult
    override func centerXSet(_ x: CGFloat) -> UITextView {
        return super.centerXSet(x) as! UITextView
    }
    
    @discardableResult
    override func centerYSet(_ y: CGFloat) -> UITextView {
        return super.centerYSet(y) as! UITextView
    }
    
    @discardableResult
    override func backgroundColorSet(_ color: UIColor) -> UITextView {
        return super.backgroundColorSet(color) as! UITextView
    }
    
    @discardableResult
    override func alphaSet(_ alpha: CGFloat) -> UITextView {
        return super.alphaSet(alpha) as! UITextView
    }
    
    @discardableResult
    override func isHiddenSet(_ isHidden: Bool) -> UITextView {
        return super.isHiddenSet(isHidden) as! UITextView
    }
    
    @discardableResult
    override func contentModeSet(_ contentMode: UIView.ContentMode) -> UITextView {
        return super.contentModeSet(contentMode) as! UITextView
    }
    
    @discardableResult
    override func isOpaqueSet(_ isOpaque: Bool) -> UITextView {
        return super.isOpaqueSet(isOpaque) as! UITextView
    }
    
    @discardableResult
    override func clipsToBoundsSet(_ clipsToBounds: Bool) -> UITextView {
        return super.clipsToBoundsSet(clipsToBounds) as! UITextView
    }
    
    @discardableResult
    override func addTo(superView: UIView) -> UITextView {
        return super.addTo(superView: superView) as! UITextView
    }
    
}
