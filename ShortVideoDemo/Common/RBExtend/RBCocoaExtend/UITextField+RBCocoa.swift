//
//  UITextField+RBCocoa.swift
//  Housekeeping
//
//  Created by RanBin on 2021/10/24.
//

import Foundation
import UIKit

extension UITextField {
    
}

extension UITextField {
    
    @discardableResult
    override func frameSet(_ frame: CGRect) -> UITextField {
        return super.frameSet(frame) as! UITextField
    }
    
    @discardableResult
    override func xSet(_ x: CGFloat) -> UITextField {
        return super.xSet(x) as! UITextField
    }
    
    @discardableResult
    override func ySet(_ y: CGFloat) -> UITextField {
        return super.ySet(y) as! UITextField
    }
    
    @discardableResult
    override func widthSet(_ width: CGFloat) -> UITextField {
        return super.widthSet(width) as! UITextField
    }
    
    @discardableResult
    override func heightSet(_ height: CGFloat) -> UITextField {
        return super.heightSet(height) as! UITextField
    }
    
    @discardableResult
    override func sizeSet(_ size: CGSize) -> UITextField {
        return super.sizeSet(size) as! UITextField
    }
    
    @discardableResult
    override func centerSet(_ center: CGPoint) -> UITextField {
        return super.centerSet(center) as! UITextField
    }
    
    @discardableResult
    override func centerXSet(_ x: CGFloat) -> UITextField {
        return super.centerXSet(x) as! UITextField
    }
    
    @discardableResult
    override func centerYSet(_ y: CGFloat) -> UITextField {
        return super.centerYSet(y) as! UITextField
    }
    
    @discardableResult
    override func backgroundColorSet(_ color: UIColor) -> UITextField {
        return super.backgroundColorSet(color) as! UITextField
    }
    
    @discardableResult
    override func alphaSet(_ alpha: CGFloat) -> UITextField {
        return super.alphaSet(alpha) as! UITextField
    }
    
    @discardableResult
    override func isHiddenSet(_ isHidden: Bool) -> UITextField {
        return super.isHiddenSet(isHidden) as! UITextField
    }
    
    @discardableResult
    override func contentModeSet(_ contentMode: UIView.ContentMode) -> UITextField {
        return super.contentModeSet(contentMode) as! UITextField
    }
    
    @discardableResult
    override func isOpaqueSet(_ isOpaque: Bool) -> UITextField {
        return super.isOpaqueSet(isOpaque) as! UITextField
    }
    
    @discardableResult
    override func clipsToBoundsSet(_ clipsToBounds: Bool) -> UITextField {
        return super.clipsToBoundsSet(clipsToBounds) as! UITextField
    }
    
    @discardableResult
    override func addTo(superView: UIView) -> UITextField {
        return super.addTo(superView: superView) as! UITextField
    }
    
}
