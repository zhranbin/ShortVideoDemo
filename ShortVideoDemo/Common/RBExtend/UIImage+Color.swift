//
//  UIImage+Color.swift
//  Mall
//
//  Created by ltx on 2022/9/27.
//

import Foundation
import UIKit


enum UIImageGradientDirection {
    /// 垂直方向
    case vertical
    /// 水平方向
    case horizontal
}


extension UIImage {
    
    
    /// 生成渐变色图片
    /// - Parameters:
    ///   - startColor: 开始颜色
    ///   - endColor: 结束颜色
    ///   - font: 字体
    ///   - str: 文字
    ///   - direction: 方向
    /// - Returns: 图片
    class func getGradientImage(startColor: UIColor, endColor: UIColor, font: UIFont, str: String, direction: UIImageGradientDirection) -> UIImage {
        let H = font.pointSize + 4
        let W = str.getWidth(font: font, height: H)
        
        let size = CGSize(width: W, height: H)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else{return UIImage()}
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradientRef = CGGradient(colorsSpace: colorSpace, colors: [startColor.cgColor, endColor.cgColor] as CFArray, locations: nil)!
        var startPoint = CGPoint(x: 0, y: 0)
        var endPoint = CGPoint(x: 0, y: 0)
        switch direction {
        case .vertical:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 0, y: size.height)
        case .horizontal:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: size.width, y: 0)
        }
        context.drawLinearGradient(gradientRef, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(arrayLiteral: .drawsBeforeStartLocation,.drawsAfterEndLocation))
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return gradientImage ?? UIImage()
    }
    
    
    
    /// 生成渐变颜色图片
    /// - Parameters:
    ///   - startColor: 开始颜色
    ///   - endColor: 结束颜色
    ///   - size: size
    ///   - direction: 方向
    /// - Returns: 图片
    class func getGradientImage(startColor: UIColor, endColor: UIColor, size: CGSize, direction: UIImageGradientDirection) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else{return UIImage()}
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradientRef = CGGradient(colorsSpace: colorSpace, colors: [startColor.cgColor, endColor.cgColor] as CFArray, locations: nil)!
        var startPoint = CGPoint(x: 0, y: 0)
        var endPoint = CGPoint(x: 0, y: 0)
        switch direction {
        case .vertical:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 0, y: size.height)
        case .horizontal:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: size.width, y: 0)
        }
        context.drawLinearGradient(gradientRef, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(arrayLiteral: .drawsBeforeStartLocation,.drawsAfterEndLocation))
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return gradientImage ?? UIImage()
    }
    
    
}
