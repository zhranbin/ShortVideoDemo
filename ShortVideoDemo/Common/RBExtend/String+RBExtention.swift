//
//  String+RBExtention.swift
//  RBExtendDemo
//
//  Created by RanBin on 2021/9/4.
//

import Foundation
import UIKit
import CommonCrypto

// MARK: - 常用功能
extension String {
    
//    var md5: String {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        CC_MD5(str!, strLen, result)
//        let hash = NSMutableString()
//
//        for i in 0..<digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//
//        result.deallocate()
//        return hash as String
//    }
    
    
    
    /// 去掉首尾空格
    var removeHeadAndTailSpace: String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    /// 去掉首尾空格与换行
    var removeHeadAndTailSpaceNewLine: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// 去掉所有空格
    var removeAllSpace: String {
        
        do {
            let regularExpression = try NSRegularExpression(pattern: "\\s*", options: .caseInsensitive)
            return regularExpression.stringByReplacingMatches(in: self, options: .withTransparentBounds, range: NSRange(location: 0, length: self.count), withTemplate: "")
            
        } catch _ {
            return self.replacingOccurrences(of: "　", with: "", options: .literal, range: nil).replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        }
    }
    
    /// 获取字符串在label中显示的宽
    /// - Parameters:
    ///   - font: 字体
    ///   - height: label高度
    /// - Returns: 显示宽
    func getWidth(font: UIFont, height: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat(MAXFLOAT), height: height))
        label.text = self
        label.font = font
        label.textAlignment = .left
        label.sizeToFit()
        return label.width
    }
    
    /// 获取字符串在label中显示的高
    /// - Parameters:
    ///   - font: 字体
    ///   - width: label宽
    /// - Returns: 显示高
    func getHeight(font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT)))
        label.text = self
        label.font = font
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        return label.height
    }
    
    /// MD5加密
    var md5:String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }.lowercased()
    }
    
    /// SHA256
    var sha256: String {
        let ccharArray = self.cString(using: String.Encoding.utf8)
    
        var uint8Array = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        
        CC_SHA256(ccharArray, CC_LONG(ccharArray!.count - 1), &uint8Array)
        
        return uint8Array.reduce("") { $0 + String(format: "%02X", $1) }
    }
    
    
    
    /// 生成随机字符串
    ///
    /// - Parameters:
    ///   - count: 生成字符串长度
    ///   - isLetter: false=大小写字母和数字组成，true=大小写字母组成，默认为false
    /// - Returns: String
    static func random(_ count: Int, _ isLetter: Bool = false) -> String {
        
//        var ch: [CChar] = Array(repeating: 0, count: count)
//        for index in 0..<count {
//            var num = isLetter ? arc4random_uniform(58)+65:arc4random_uniform(75)+48
//            if num>57 && num<65 && isLetter==false { num = num%57+48 }
//            else if num>90 && num<97 { num = num%90+65 }
//
//            ch[index] = CChar(num)
//        }
//
//        return String(cString: ch)
        let letters : NSString = isLetter ? "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" : "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: count)
        for _ in 0..<count {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString as String
        
        
        
        
        
    }
}



// MARK: - 验证
extension String {
    
    /// 邮箱验证
    func isValidateEmail() -> Bool {
        let emailRegex = "^[a-z0-9A-Z]+[- | a-z0-9A-Z . _]+@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-z]{2,}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with:self)
    }
    
    /// 电话验证
    func isTelPhone() -> Bool {
        
        let telRegex1 = "^[0-9]{10}$";
        let telRegex2 = "^[0-9]{3}-[0-9]{3}-[0-9]{4}$";
        let telRegex3 = "^\\([0-9]{3}\\)[0-9]{3}-[0-9]{4}$";
        let telRegex4 = "^\\([0-9]{3}\\)[0-9]{7}$";
        let telRegex5 = "^[0-9]{3}-[0-9]{4}$";
        let telRegex6 = "^[0-9]{3}\\.[0-9]{3}\\.[0-9]{4}$";
        
        let telTest1 = NSPredicate(format: "SELF MATCHES %@", telRegex1)
        let telTest2 = NSPredicate(format: "SELF MATCHES %@", telRegex2)
        let telTest3 = NSPredicate(format: "SELF MATCHES %@", telRegex3)
        let telTest4 = NSPredicate(format: "SELF MATCHES %@", telRegex4)
        let telTest5 = NSPredicate(format: "SELF MATCHES %@", telRegex5)
        let telTest6 = NSPredicate(format: "SELF MATCHES %@", telRegex6)
        return telTest1.evaluate(with:self)||telTest2.evaluate(with:self)||telTest3.evaluate(with:self)||telTest4.evaluate(with:self)||telTest5.evaluate(with:self)||telTest6.evaluate(with:self) || isPhone()
    }
    
    
    /// 手机号码验证
    /// - Returns: 验证结果
    func isPhone() -> Bool {
        let phoneRegex = "^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with:self)
    }
    
    
    /// 是否包含汉字
    func isIncludeChineseIn() -> Bool {
        
        for (_, value) in self.enumerated() {

            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        
        return false
    }
    
    
    func isNumber() -> Bool {
        let numRegex = "\\d$"
        let numTest = NSPredicate(format: "SELF MATCHES %@", numRegex)
        return numTest.evaluate(with:self)
    }
    
}


// MARK: - 时间相关
extension String {
    
    /// 获取当前时间戳（秒）
    static func getNowTimeStamp() -> String {
        //获取当前时间
        let now = Date()
        //当前时间的时间戳
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    /// 获取当前时间戳（毫秒）
    static func getNowTimeMilliStamp() -> String {
        //获取当前时间
        let now = Date()
        //当前时间的时间戳
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    
    /// 获取当前时间
    /// - Parameter dateFormat: 时间格式（如：yyyy-MM-dd HH:mm:ss）
    static func getNowTimeString(dateFormat: String) -> String {
        //获取当前时间
        let now = Date()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = dateFormat
        return dformatter.string(from: now)
    }
    
    /// 时间戳转格式化时间（秒）
    /// - Parameter dateFormat: 时间格式（如：yyyy-MM-dd HH:mm:ss）
    func getTimeString(dateFormat: String) -> String {
        guard let timeStamp = Double(self) else { return "" }
        //转换为时间
        let timeInterval:TimeInterval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSince1970: timeInterval)
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = dateFormat
        return dformatter.string(from: date)
        
    }
    
    /// 时间戳转格式化时间（毫秒）
    /// - Parameter dateFormat: 时间格式（如：yyyy-MM-dd HH:mm:ss）
    func getMilliTimeString(dateFormat: String) -> String {
        guard let timeStamp = Double(self) else { return "" }
        //转换为时间
        let timeInterval:TimeInterval = TimeInterval(timeStamp/1000)
        let date = Date(timeIntervalSince1970: timeInterval)
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = dateFormat
        return dformatter.string(from: date)
        
    }
    
    
    /// 字符串转日期
    /// - Parameters:
    ///   - dateFormat: 时间格式（如：yyyy-MM-dd HH:mm:ss
    /// - Returns: 日期
    func toDate(dateFormat: String) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: self)
        return date!
    }
    
    
}
