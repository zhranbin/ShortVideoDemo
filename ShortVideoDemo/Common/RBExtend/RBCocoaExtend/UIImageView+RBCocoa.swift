//
//  UIImageView+RBCocoa.swift
//  Housekeeping
//
//  Created by RanBin on 2021/10/24.
//

import Foundation
import UIKit

extension UIImageView {
    
}

extension UIImageView {
    
    @discardableResult
    override func frameSet(_ frame: CGRect) -> UIImageView {
        return super.frameSet(frame) as! UIImageView
    }
    
    @discardableResult
    override func xSet(_ x: CGFloat) -> UIImageView {
        return super.xSet(x) as! UIImageView
    }
    
    @discardableResult
    override func ySet(_ y: CGFloat) -> UIImageView {
        return super.ySet(y) as! UIImageView
    }
    
    @discardableResult
    override func widthSet(_ width: CGFloat) -> UIImageView {
        return super.widthSet(width) as! UIImageView
    }
    
    @discardableResult
    override func heightSet(_ height: CGFloat) -> UIImageView {
        return super.heightSet(height) as! UIImageView
    }
    
    @discardableResult
    override func sizeSet(_ size: CGSize) -> UIImageView {
        return super.sizeSet(size) as! UIImageView
    }
    
    @discardableResult
    override func centerSet(_ center: CGPoint) -> UIImageView {
        return super.centerSet(center) as! UIImageView
    }
    
    @discardableResult
    override func centerXSet(_ x: CGFloat) -> UIImageView {
        return super.centerXSet(x) as! UIImageView
    }
    
    @discardableResult
    override func centerYSet(_ y: CGFloat) -> UIImageView {
        return super.centerYSet(y) as! UIImageView
    }
    
    @discardableResult
    override func backgroundColorSet(_ color: UIColor) -> UIImageView {
        return super.backgroundColorSet(color) as! UIImageView
    }
    
    @discardableResult
    override func alphaSet(_ alpha: CGFloat) -> UIImageView {
        return super.alphaSet(alpha) as! UIImageView
    }
    
    @discardableResult
    override func isHiddenSet(_ isHidden: Bool) -> UIImageView {
        return super.isHiddenSet(isHidden) as! UIImageView
    }
    
    @discardableResult
    override func contentModeSet(_ contentMode: UIView.ContentMode) -> UIImageView {
        return super.contentModeSet(contentMode) as! UIImageView
    }
    
    @discardableResult
    override func isOpaqueSet(_ isOpaque: Bool) -> UIImageView {
        return super.isOpaqueSet(isOpaque) as! UIImageView
    }
    
    @discardableResult
    override func clipsToBoundsSet(_ clipsToBounds: Bool) -> UIImageView {
        return super.clipsToBoundsSet(clipsToBounds) as! UIImageView
    }
    
    @discardableResult
    override func addTo(superView: UIView) -> UIImageView {
        return super.addTo(superView: superView) as! UIImageView
    }
    
}
