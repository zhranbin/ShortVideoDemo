//
//  RBRandomCode.swift
//  BangJiaJia
//
//  Created by 冉彬 on 2022/2/12.
//

import Foundation
import UIKit

let RBRandomCodeDefault = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
struct RBRandomCode {
    
    /// 生成图片验证码
    /// - Parameters:
    ///   - codeArray: 验证码字符串数组
    ///   - number: 验证码个数
    ///   - size: 图片大小
    /// - Returns: 结果
    static func getRandomCode( size: CGSize, codeArray: [String] = RBRandomCodeDefault, number: Int = 4,backgroundColor: UIColor = .white) -> (result: String, image: UIImage?) {
        if codeArray.count == 0 || number == 0 {
            return ("", nil)
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.backgroundColor = backgroundColor
        ganrao(view: view)
        var codeStr = ""
        for index in 0..<number {
            let str = codeArray[Int(arc4random_uniform(UInt32(codeArray.count)))]
//            randomStrAry.append(str)
//            labelAry.append()
            let w = size.width / CGFloat(number)
            let label = createLabel(size: CGSize(width: w, height: size.height), text: str)
            label.x = CGFloat(index) * w
            label.y = 0
            let u: Double = arc4random_uniform(1000)%2 == 0 ? -1 : 1
            let angle = Double(arc4random_uniform(100))/100 * u
            label.transform = CGAffineTransform(rotationAngle: angle)
            view.addSubview(label)
            codeStr += str
        }
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return (codeStr, image)
    }
    
    
    /// 干扰线
    /// - Parameter view: view
    private static func ganrao(view: UIView) {
        for _ in 0...6 {
            let path = UIBezierPath()
            let pX = arc4random_uniform(UInt32(view.frame.width))
            let pY = arc4random_uniform(UInt32(view.frame.height))
            path.move(to: CGPoint(x: CGFloat(pX), y: CGFloat(pY)))
            let ptX = arc4random_uniform(UInt32(view.frame.width))
            let ptY = arc4random_uniform(UInt32(view.frame.height))
            path.addLine(to: CGPoint(x: CGFloat(ptX), y: CGFloat(ptY)))
            
            let layer = CAShapeLayer()
            layer.strokeColor = UIColor.hexColor(hexColor: 0x000000, alpha: 0.5).cgColor
            layer.lineWidth = 1
            layer.strokeEnd = 1
            layer.fillColor = UIColor.clear.cgColor
            layer.path = path.cgPath
            view.layer.addSublayer(layer)
        }
    }
    
    private static func createLabel(size: CGSize, text: String) -> UILabel {
        let fontNum = min(size.width, size.height)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        label.text = text
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: fontNum)
        label.textAlignment = .center
        return label
    }
    
    
    
}
