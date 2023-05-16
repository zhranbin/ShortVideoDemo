//
//  ArrayAndString+PYExtention.swift
//  BangJiaJia
//
//  Created by 冉彬 on 2022/11/15.
//

import Foundation

extension String {
    
    /// 判断字符串中是否有中文
    func isIncludeChinese() -> Bool {
        for ch in self.unicodeScalars {
            if (0x4e00 < ch.value  && ch.value < 0x9fff) { return true } // 中文字符范围：0x4e00 ~ 0x9fff
        }
        return false
    }
    
    /// 将中文字符串转换为拼音
    ///
    /// - Parameter hasBlank: 是否带空格（默认不带空格）
    func transformToPinyin(hasBlank: Bool = false) -> String {
        
        let stringRef = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false) // 转换为带音标的拼音
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false) // 去掉音标
        let pinyin = stringRef as String
        return hasBlank ? pinyin : pinyin.replacingOccurrences(of: " ", with: "")
    }
    
    /// 获取中文首字母
    ///
    /// - Parameter lowercased: 是否小写（默认大写）
    func transformToPinyinHead(lowercased: Bool = false) -> String {
        let pinyin = self.transformToPinyin(hasBlank: true).capitalized // 字符串转换为首字母大写
        var headPinyinStr = ""
        for ch in pinyin {
            if ch <= "Z" && ch >= "A" {
                headPinyinStr.append(ch) // 获取所有大写字母
            }
        }
        return lowercased ? headPinyinStr.lowercased() : headPinyinStr
    }
    
    
    
    
}


extension Array where Element == String {
    
    /// 数组内中文按拼音字母排序
    ///
    /// - Parameter ascending: 是否升序（默认升序）
    func sortedByPinyin(ascending: Bool = true) -> Array<String> {
        return self.sorted { (value1, value2) -> Bool in
            let pinyin1 = value1.transformToPinyin()
            let pinyin2 = value2.transformToPinyin()
            return pinyin1.compare(pinyin2) == (ascending ? .orderedAscending : .orderedDescending)
        }
    }
}
