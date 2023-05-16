//
//  UILabel+RBCocoa.swift
//  Housekeeping
//
//  Created by RanBin on 2021/10/24.
//

import Foundation
import UIKit

extension UILabel {
    
}

extension UILabel {
    
    @discardableResult
    override func frameSet(_ frame: CGRect) -> UILabel {
        return super.frameSet(frame) as! UILabel
    }
    
    @discardableResult
    override func xSet(_ x: CGFloat) -> UILabel {
        return super.xSet(x) as! UILabel
    }
    
    @discardableResult
    override func ySet(_ y: CGFloat) -> UILabel {
        return super.ySet(y) as! UILabel
    }
    
    @discardableResult
    override func widthSet(_ width: CGFloat) -> UILabel {
        return super.widthSet(width) as! UILabel
    }
    
    @discardableResult
    override func heightSet(_ height: CGFloat) -> UILabel {
        return super.heightSet(height) as! UILabel
    }
    
    @discardableResult
    override func sizeSet(_ size: CGSize) -> UILabel {
        return super.sizeSet(size) as! UILabel
    }
    
    @discardableResult
    override func centerSet(_ center: CGPoint) -> UILabel {
        return super.centerSet(center) as! UILabel
    }
    
    @discardableResult
    override func centerXSet(_ x: CGFloat) -> UILabel {
        return super.centerXSet(x) as! UILabel
    }
    
    @discardableResult
    override func centerYSet(_ y: CGFloat) -> UILabel {
        return super.centerYSet(y) as! UILabel
    }
    
    @discardableResult
    override func backgroundColorSet(_ color: UIColor) -> UILabel {
        return super.backgroundColorSet(color) as! UILabel
    }
    
    @discardableResult
    override func alphaSet(_ alpha: CGFloat) -> UILabel {
        return super.alphaSet(alpha) as! UILabel
    }
    
    @discardableResult
    override func isHiddenSet(_ isHidden: Bool) -> UILabel {
        return super.isHiddenSet(isHidden) as! UILabel
    }
    
    @discardableResult
    override func contentModeSet(_ contentMode: UIView.ContentMode) -> UILabel {
        return super.contentModeSet(contentMode) as! UILabel
    }
    
    @discardableResult
    override func isOpaqueSet(_ isOpaque: Bool) -> UILabel {
        return super.isOpaqueSet(isOpaque) as! UILabel
    }
    
    @discardableResult
    override func clipsToBoundsSet(_ clipsToBounds: Bool) -> UILabel {
        return super.clipsToBoundsSet(clipsToBounds) as! UILabel
    }
    
    @discardableResult
    override func addTo(superView: UIView) -> UILabel {
        return super.addTo(superView: superView) as! UILabel
    }
    
}
