//
//  Double+RBExtention.swift
//  FrogRich
//
//  Created by ltx on 2022/12/8.
//

import Foundation

enum RBRoundedType {
    /// 向下取
    case down
    /// 向上取
    case up
    /// 四舍五入
    case roundOff
}

extension Double {
    
    /// 转字符串
    /// - Parameters:
    ///   - keep: 保留小数位（-1:不做处理）
    ///   - rounded: 舍入类型
    /// - Returns: string
    func toString(_ keep: Int, rounded: RBRoundedType = .down) -> String {
        if keep < 0 {
            return "\(self)"
        }
        let pow = Double(pow(10, CGFloat(keep)))
        var num: Double = 0
        let formatStr: String = "%.\(keep)f"
        switch rounded {
        case .down:
            num = (self*pow).rounded(.down)/pow
        case .up:
            num = (self*pow).rounded(.up)/pow
        case .roundOff:
            num = self
        }
        return String(format: formatStr, num)
        
    }
    
    
    func rounded(_ keep: Int, rounded: RBRoundedType = .down) -> Double {
        let pow = Double(pow(10, CGFloat(keep)))
        var num: Double = 0
        switch rounded {
        case .down:
            num = (self*pow).rounded(.down)/pow
        case .up:
            num = (self*pow).rounded(.up)/pow
        case .roundOff:
            num = Double(self.toString(keep, rounded: .roundOff)) ?? self
        }
        return num
    }
    
    
}


extension String {
    
    
    static func formate(format: String, _ double: Double) -> String {
        return String(format: format, double.rounded(2))
    }
    
    
}
