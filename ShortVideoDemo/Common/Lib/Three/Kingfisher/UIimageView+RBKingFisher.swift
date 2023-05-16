//
//  UIimageView+RBKingFisher.swift
//  FrogRich
//
//  Created by ltx on 2022/10/20.
//

import Foundation
import UIKit

extension UIImageView {
    
    
    /// 设置网络图片
    /// - Parameters:
    ///   - urlStr: urlStr
    ///   - placeholder: 占位图名称
    func kfSetImage(_ urlStr: String, placeholderName: String = "kf_resource.bundle/placeholder.png") {
        
        var imageUrl = urlStr
        if imageUrl.hasPrefix("//") {
            imageUrl = "https:\(imageUrl)"
        }
        
        if let url = URL(string: imageUrl.kfUrlString() ?? "") {
            self.kf.setImage(with: url, placeholder: UIImage(named: placeholderName))
        } else {
            self.image = UIImage(named: placeholderName)
        }
        
    }
    
    /// 设置网络图片
    /// - Parameters:
    ///   - urlStr: urlStr
    ///   - placeholder: 占位图名称
    func kfSetImage(urlStr: String, placeholder: UIImage? = UIImage(named: "kf_resource.bundle/placeholder.png")) {
        var imageUrl = urlStr
        if imageUrl.hasPrefix("//") {
            imageUrl = "https:\(imageUrl)"
        }
        if let url = URL(string: imageUrl.kfUrlString() ?? "") {
            self.kf.setImage(with: url, placeholder: placeholder)
        } else {
            self.image = placeholder
        }
        
    }
}

extension String {
    
    /// 格式化url
    /// - Returns: 格式化url字符串
    func kfUrlString() -> String? {
        if self.count == 0 {
            return nil
        }
        
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "!$&'()*+,-./:;=?@_~%#[]")
        let urlStr = addingPercentEncoding(withAllowedCharacters: charSet as CharacterSet)
        if urlStr == nil || urlStr?.count == 0 {
            return nil
        }
        return urlStr
    }
}
