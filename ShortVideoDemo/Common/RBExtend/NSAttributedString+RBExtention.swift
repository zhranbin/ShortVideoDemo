//
//  NSAttributedString+RBExtention.swift
//  RBExtendDemo
//
//  Created by mac on 2021/12/31.
//

import Foundation
import UIKit

enum RBUnderlineStyle: Int {
    /// 取消设置
    case none = 0
    /// 单细线（2-7 逐渐加粗）
    case single = 1
    case single1 = 2
    case single2 = 3
    case single3 = 4
    case single4 = 5
    case single5 = 6
    case single6 = 7
    /// 双细线（10-15逐渐加粗）
    case double = 9
    case double1 = 10
    case double2 = 12
    case double3 = 13
    case double4 = 14
    case double5 = 15
}


/// 富文本key
enum NSAttributedStringKey {
    /// 文本字体
    case font(UIFont)
    /// 文本字、行间距，对齐等
    case paragraphStyle(NSParagraphStyle)
    /// 字体颜色
    case foregroundColor(UIColor)
    /// 背景色
    case backgroundColor(UIColor)
    /// 连字符(0 和 1 两个值：0表示没有连字符，而1是默认的连字符)
    case ligature(Int)
    /// 字符间距（正值间距加宽，负值间距变窄，0表示默认效果）
    case kern(CGFloat)
    /// 删除线
    case strikethroughStyle(RBUnderlineStyle)
    /// 删除线颜色
    case strikethroughColor(UIColor)
    /// 下划线
    case underlineStyle(RBUnderlineStyle)
    /// 下划线颜色
    case underlineColor(UIColor)
    /// 描边颜色 （描边颜色要搭配非0的描边宽度才会生效，如果只设置了描边颜色，描边宽度为0，则没有描边效果）
    case strokeColor(UIColor)
    /// 描边宽度
    /// 描边宽度是正数，会对文字进行描边，但文字中心不填充（ 一种经典的空心文本样式是在该值为3.0）
    /// 描边宽度是负数，会对文字进行描边，而且会同时对文字中心进行填充（填充的颜色为文字本来的字体颜色）
    case strokeWidth(NSNumber)
    /// 文本阴影
    case shadow(NSShadow)
    /// 链接（UILabel无法使用该属性, 但UITextView 控件可以使用）
    case link(NSURL)
    /// 基础偏移量（正值向上偏移，负值向下偏移，默认0（不偏移））
    case baselineOffset(NSNumber)
    /// 字体倾斜（正值向右倾斜，负值向左倾斜， 默认0（不倾斜））
    case obliqueness(NSNumber)
    /// 文本扁平化（横向拉伸）（正值横向拉伸，负值横向压缩，默认0（不拉伸））
    case expansion(NSNumber)

}


extension NSMutableAttributedString {
    
    @discardableResult
    /// 添加富文本属性
    /// - Parameters:
    ///   - key: NSAttributedStringKey
    ///   - range: 范围
    /// - Returns: 富文本自己
    func rb_addAttribute(_ key: NSAttributedStringKey, range: NSRange? = nil) -> Self {
        var valueRange = NSRange(location: 0, length: self.length)
        if range != nil && range!.location + range!.length <= self.length {
            valueRange = range!
        }
        var name: NSAttributedString.Key
        var value: Any
        switch key {
        case .font(let v):
            name = .font
            value = v
        case .paragraphStyle(let v):
            name = .paragraphStyle
            value = v
        case .foregroundColor(let v):
            name = .foregroundColor
            value = v
        case .backgroundColor(let v):
            name = .backgroundColor
            value = v
        case .ligature(let v):
            name = .ligature
            value = v
        case .kern(let v):
            name = .kern
            value = v
        case .strikethroughStyle(let v):
            name = .strikethroughStyle
            value = v.rawValue
        case .strikethroughColor(let v):
            name = .strikethroughColor
            value = v
        case .underlineStyle(let v):
            name = .underlineStyle
            value = v.rawValue
        case .underlineColor(let v):
            name = .underlineColor
            value = v
        case .strokeColor(let v):
            name = .strokeColor
            value = v
        case .strokeWidth(let v):
            name = .strokeWidth
            value = v
        case .shadow(let v):
            name = .shadow
            value = v
        case .link(let v):
            name = .link
            value = v
        case .baselineOffset(let v):
            name = .baselineOffset
            value = v
        case .obliqueness(let v):
            name = .obliqueness
            value = v
        case .expansion(let v):
            name = .expansion
            value = v
        }
        self.addAttribute(name, value: value, range: valueRange)
        return self
    }
    
    
    /// 字体
    /// - Parameters:
    ///   - font: 字体
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addFont(_ font: UIFont, range: NSRange? = nil) -> Self {
        self.rb_addAttribute(.font(font), range: range)
        return self
    }
    
    /// 段落样式
    /// - Parameters:
    ///   - paragraphStyle: 样式
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addParagraphStyle(_ paragraphStyle: NSParagraphStyle, range: NSRange? = nil) -> Self {
/*               paragraphStyle.lineSpacing            = 0.0; //增加行高
                 paragraphStyle.headIndent             = 0;   //头部缩进，相当于左padding
                 paragraphStyle.tailIndent             = 0;   //相当于右padding
                 paragraphStyle.lineHeightMultiple     = 0;   //行间距是多少倍
                 paragraphStyle.alignment              = NSTextAlignmentLeft;//对齐方式
                 paragraphStyle.firstLineHeadIndent    = 0;   //首行头缩进
                 paragraphStyle.paragraphSpacing       = 0;   //段落后面的间距
                 paragraphStyle.paragraphSpacingBefore = 0;   //段落之前的间距
*/
        self.rb_addAttribute(.paragraphStyle(paragraphStyle), range: range)
        return self
    }
    
    /// 字体颜色
    /// - Parameters:
    ///   - color: 颜色
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addTextColor(_ color: UIColor, range: NSRange? = nil) -> Self {
        self.rb_addAttribute(.foregroundColor(color), range: range)
        return self
    }
    
    /// 背景色
    /// - Parameters:
    ///   - backgroundColor: 背景色
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addBackgroundColor(_ backgroundColor: UIColor, range: NSRange? = nil) -> Self {
        self.rb_addAttribute(.backgroundColor(backgroundColor), range: range)
        return self
    }
    
    /// 连字符
    /// - Parameters:
    ///   - ligature: 是否有连字符
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addLigature(_ ligature: Bool, range: NSRange? = nil) -> Self {
        self.rb_addAttribute(.ligature(ligature ? 1 : 0), range: range)
        return self
    }
    
    /// 字符间距
    /// - Parameters:
    ///   - kern: 间距（正值间距加宽，负值间距变窄，0表示默认效果）
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addKern(_ kern: CGFloat, range: NSRange? = nil) -> Self {
        self.rb_addAttribute(.kern(kern), range: range)
        return self
    }
    
    /// 删除线
    /// - Parameters:
    ///   - style: 样式
    ///   - color: 颜色（默认为字体颜色）
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addStrikethrough(style: RBUnderlineStyle, color: UIColor? = nil, range: NSRange? = nil) -> Self {
        self.rb_addAttribute(.strikethroughStyle(style), range: range)
        if color != nil {
            self.rb_addAttribute(.strikethroughColor(color!), range: range)
        }
        return self
    }
    
    /// 下划线
    /// - Parameters:
    ///   - style: 样式
    ///   - color: 颜色（默认为字体颜色）
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addUnderline(style: RBUnderlineStyle, color: UIColor? = nil, range: NSRange? = nil) -> Self {
        self.rb_addAttribute(.underlineStyle(style), range: range)
        if color != nil {
            self.rb_addAttribute(.underlineColor(color!), range: range)
        }
        return self
    }
    
    /// 字体描边
    /// - Parameters:
    ///   - width: 描边宽度 (相对于字体 size 的百分比)
    ///                  （正数-文字中心不填充）（ 经典的空心文本样式是在该值为3.0）
    ///                  （负数-文字中心要填充，填充颜色为字体颜色）
    ///   - color: 颜色
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addStroke(width: NSNumber, color: UIColor, range: NSRange? = nil) -> Self {
        self.rb_addAttribute(.strokeColor(color), range: range)
        self.rb_addAttribute(.strokeWidth(width), range: range)
        return self
    }
    
    /// 文本阴影
    /// - Parameters:
    ///   - shadow: 阴影
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addShadow(_ shadow: NSShadow, range: NSRange? = nil) -> Self {
        self.rb_addAttribute(.shadow(shadow), range: range)
        return self
    }
    
    /// 链接（UILabel无法使用该属性, 但UITextView 控件可以使用）
    /// - Parameters:
    ///   - url: url
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addLink(url: URL, range: NSRange? = nil) -> Self {
        self.rb_addAttribute(.link(url as NSURL), range: range)
        return self
    }
    
    /// 基础偏移量
    /// - Parameters:
    ///   - offset: 偏移量（正值向上偏移，负值向下偏移，默认0（不偏移））
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addBaselineOffset(_ offset: NSNumber, range: NSRange? = nil) -> Self {
        self.rb_addAttribute(.baselineOffset(offset), range: range)
        return self
    }
    
    /// 字体倾斜
    /// - Parameters:
    ///   - number: 正值向右倾斜，负值向左倾斜， 默认0（不倾斜）
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addObliqueness(_ number: NSNumber, range: NSRange? = nil) -> Self {
        self.rb_addAttribute(.obliqueness(number), range: range)
        return self
    }
    
    /// 文本扁平化（横向拉伸）
    /// - Parameters:
    ///   - number: 正值横向拉伸，负值横向压缩，默认0（不拉伸）
    ///   - range: 范围
    /// - Returns: self
    @discardableResult
    func addExpansion(_ number: NSNumber, range: NSRange? = nil) -> Self {
        self.rb_addAttribute(.expansion(number), range: range)
        return self
    }
    
    
    /// 添加图片
    /// - Parameters:
    ///   - image: 图片
    ///   - size: 图片大小
    ///   - offSet: 图片偏移量（正：上移， 负下移）
    ///   - at: 插入位置
    /// - Returns: self
    @discardableResult
    func addImage(_ image: UIImage?, size: CGSize, offSet: CGFloat = 0, at: Int) -> Self {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: offSet, width: size.width, height: size.height)
        let att = NSAttributedString(attachment: attachment)
        self.insert(att, at: at)
        
        return self
    }
    
    
}


