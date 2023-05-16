//
//  UIView+RBCocoa.swift
//  Housekeeping
//
//  Created by RanBin on 2021/10/22.
//

import Foundation
import UIKit

/*
 注：
 extension 中的方法默认是直接调度。
 直接调度不能被继承。
 为了重写父类扩展的方法，需要添加 @objc 来改变方法的调度为消息调度。
 */
extension UIView {
    
    @discardableResult
    @objc func frameSet(_ frame: CGRect) -> UIView {
        self.frame = frame
        return self
    }
    
    @discardableResult
    @objc func xSet(_ x: CGFloat) -> UIView {
        self.frame = CGRect(x: x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        return self
    }
    
    @discardableResult
    @objc func ySet(_ y: CGFloat) -> UIView {
        self.frame = CGRect(x: self.frame.origin.x, y: y, width: self.frame.size.width, height: self.frame.size.height)
        return self
    }
    
    @discardableResult
    @objc func widthSet(_ width: CGFloat) -> UIView {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: self.frame.size.height)
        return self
    }
    
    @discardableResult
    @objc func heightSet(_ height: CGFloat) -> UIView {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: height)
        return self
    }
    
    @discardableResult
    @objc func sizeSet(_ size: CGSize) -> UIView {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: size.width, height: size.height)
        return self
    }
    
    @discardableResult
    @objc func centerSet(_ center: CGPoint) -> UIView {
        self.center = center
        return self
    }
    
    @discardableResult
    @objc func centerXSet(_ x: CGFloat) -> UIView {
        self.center = CGPoint(x: x, y: center.y)
        return self
    }
    
    @discardableResult
    @objc func centerYSet(_ y: CGFloat) -> UIView {
        self.center = CGPoint(x: center.x, y: y)
        return self
    }
    
    @discardableResult
    @objc func backgroundColorSet(_ color: UIColor) -> UIView {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    @objc func alphaSet(_ alpha: CGFloat) -> UIView {
        self.alpha = alpha
        return self
    }
    
    @discardableResult
    @objc func isHiddenSet(_ isHidden: Bool) -> UIView {
        self.isHidden = isHidden
        return self
    }
    
    @discardableResult
    @objc func contentModeSet(_ contentMode: UIView.ContentMode) -> UIView {
        self.contentMode = contentMode
        return self
    }
    
    @discardableResult
    @objc func isOpaqueSet(_ isOpaque: Bool) -> UIView {
        self.isOpaque = isOpaque
        return self
    }
    
    @discardableResult
    @objc func clipsToBoundsSet(_ clipsToBounds: Bool) -> UIView {
        self.clipsToBounds = clipsToBounds
        return self
    }
    
    @discardableResult
    @objc func addTo(superView: UIView) -> UIView {
        superView.addSubview(self)
        return self
    }
    
}



