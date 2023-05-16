//
//  UIButton+RBCocoa.swift
//  Housekeeping
//
//  Created by RanBin on 2021/10/22.
//

import Foundation
import UIKit


extension UIButton {
    
    @discardableResult
    func setTitle(_ title: String?, state: UIControl.State) -> UIButton {
        self.setTitle(title, for: state)
        return self
    }
    
    @discardableResult
    func setTitleColor(_ color: UIColor?, state: UIControl.State) -> UIButton {
        self.setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    func setTitleFont(_ font: UIFont?) -> UIButton {
        self.titleLabel?.font = font
        return self
    }
    
    @discardableResult
    func setImage(_ image: UIImage?, state: UIControl.State) -> UIButton {
        self.setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func setBackgroundImage(_ image: UIImage?, state: UIControl.State) -> UIButton {
        self.setBackgroundImage(image, for: state)
        return self
    }
    
    
    
    
}

extension UIButton {
    
    @discardableResult
    override func frameSet(_ frame: CGRect) -> UIButton {
        return super.frameSet(frame) as! UIButton
    }
    
    @discardableResult
    override func xSet(_ x: CGFloat) -> UIButton {
        return super.xSet(x) as! UIButton
    }
    
    @discardableResult
    override func ySet(_ y: CGFloat) -> UIButton {
        return super.ySet(y) as! UIButton
    }
    
    @discardableResult
    override func widthSet(_ width: CGFloat) -> UIButton {
        return super.widthSet(width) as! UIButton
    }
    
    @discardableResult
    override func heightSet(_ height: CGFloat) -> UIButton {
        return super.heightSet(height) as! UIButton
    }
    
    @discardableResult
    override func sizeSet(_ size: CGSize) -> UIButton {
        return super.sizeSet(size) as! UIButton
    }
    
    @discardableResult
    override func centerSet(_ center: CGPoint) -> UIButton {
        return super.centerSet(center) as! UIButton
    }
    
    @discardableResult
    override func centerXSet(_ x: CGFloat) -> UIButton {
        return super.centerXSet(x) as! UIButton
    }
    
    @discardableResult
    override func centerYSet(_ y: CGFloat) -> UIButton {
        return super.centerYSet(y) as! UIButton
    }
    
    @discardableResult
    override func backgroundColorSet(_ color: UIColor) -> UIButton {
        return super.backgroundColorSet(color) as! UIButton
    }
    
    @discardableResult
    override func alphaSet(_ alpha: CGFloat) -> UIButton {
        return super.alphaSet(alpha) as! UIButton
    }
    
    @discardableResult
    override func isHiddenSet(_ isHidden: Bool) -> UIButton {
        return super.isHiddenSet(isHidden) as! UIButton
    }
    
    @discardableResult
    override func contentModeSet(_ contentMode: UIView.ContentMode) -> UIButton {
        return super.contentModeSet(contentMode) as! UIButton
    }
    
    @discardableResult
    override func isOpaqueSet(_ isOpaque: Bool) -> UIButton {
        return super.isOpaqueSet(isOpaque) as! UIButton
    }
    
    @discardableResult
    override func clipsToBoundsSet(_ clipsToBounds: Bool) -> UIButton {
        return super.clipsToBoundsSet(clipsToBounds) as! UIButton
    }
    
    @discardableResult
    override func addTo(superView: UIView) -> UIButton {
        return super.addTo(superView: superView) as! UIButton
    }
    
}
