//
//  UIScrollerView+RBCocoa.swift
//  Housekeeping
//
//  Created by RanBin on 2021/10/24.
//

import Foundation
import UIKit

extension UICollectionView {
    
}

extension UICollectionView {
    
    @discardableResult
    override func frameSet(_ frame: CGRect) -> UICollectionView {
        return super.frameSet(frame) as! UICollectionView
    }
    
    @discardableResult
    override func xSet(_ x: CGFloat) -> UICollectionView {
        return super.xSet(x) as! UICollectionView
    }
    
    @discardableResult
    override func ySet(_ y: CGFloat) -> UICollectionView {
        return super.ySet(y) as! UICollectionView
    }
    
    @discardableResult
    override func widthSet(_ width: CGFloat) -> UICollectionView {
        return super.widthSet(width) as! UICollectionView
    }
    
    @discardableResult
    override func heightSet(_ height: CGFloat) -> UICollectionView {
        return super.heightSet(height) as! UICollectionView
    }
    
    @discardableResult
    override func sizeSet(_ size: CGSize) -> UICollectionView {
        return super.sizeSet(size) as! UICollectionView
    }
    
    @discardableResult
    override func centerSet(_ center: CGPoint) -> UICollectionView {
        return super.centerSet(center) as! UICollectionView
    }
    
    @discardableResult
    override func centerXSet(_ x: CGFloat) -> UICollectionView {
        return super.centerXSet(x) as! UICollectionView
    }
    
    @discardableResult
    override func centerYSet(_ y: CGFloat) -> UICollectionView {
        return super.centerYSet(y) as! UICollectionView
    }
    
    @discardableResult
    override func backgroundColorSet(_ color: UIColor) -> UICollectionView {
        return super.backgroundColorSet(color) as! UICollectionView
    }
    
    @discardableResult
    override func alphaSet(_ alpha: CGFloat) -> UICollectionView {
        return super.alphaSet(alpha) as! UICollectionView
    }
    
    @discardableResult
    override func isHiddenSet(_ isHidden: Bool) -> UICollectionView {
        return super.isHiddenSet(isHidden) as! UICollectionView
    }
    
    @discardableResult
    override func contentModeSet(_ contentMode: UIView.ContentMode) -> UICollectionView {
        return super.contentModeSet(contentMode) as! UICollectionView
    }
    
    @discardableResult
    override func isOpaqueSet(_ isOpaque: Bool) -> UICollectionView {
        return super.isOpaqueSet(isOpaque) as! UICollectionView
    }
    
    @discardableResult
    override func clipsToBoundsSet(_ clipsToBounds: Bool) -> UICollectionView {
        return super.clipsToBoundsSet(clipsToBounds) as! UICollectionView
    }
    
    @discardableResult
    override func addTo(superView: UIView) -> UICollectionView {
        return super.addTo(superView: superView) as! UICollectionView
    }
    
}
