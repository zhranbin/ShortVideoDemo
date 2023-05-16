//
//  APPSingle.swift
//  ReviewAPP
//
//  Created by 冉彬 on 2020/4/2.
//  Copyright © 2020 BigWhite. All rights reserved.
//



import UIKit

class APPSingle {
    // 全局变量
    static let shared = APPSingle()
    private init() {}
   /// 是否登录
//    var _isLogin:Bool = false;
    var isLogin: Bool{
        get{
            if let token = UserDefaults.LoginInfo.string(forKey: .token){
                if !token.isEmpty {
                    return true
                }
            }
            return false
            
        }
        
    }
    
    /// 是否显示过版本提示
    var isShowVersionTip: Bool = false
    
    
    // token
    var token:String{
        set{
            UserDefaults.LoginInfo.set(value: newValue, forKey: .token)
        }
        get{
            UserDefaults.LoginInfo.string(forKey: .token) ?? "";
        }
    }
    
    
    
    /// 搜索历史记录
    var _searchHistoryAry: [String]?
    var searchHistoryAry: [String] {
        set{
            _searchHistoryAry = newValue.removeRepetition
            
            if _searchHistoryAry!.count > 15 {
                var ary = [String]()
                for index in 0 ..< 15 {
                    ary.append(_searchHistoryAry![index])
                }
                _searchHistoryAry = ary
            }
            
            UserDefaults.AccountInfo.set(value: _searchHistoryAry, forKey: .searchHistory)
        }
        get{
            if _searchHistoryAry == nil {
                guard let ary = UserDefaults.AccountInfo.array(forKey: .searchHistory) as? [String] else {
                    return []
                }
                return ary
            }else {
                return _searchHistoryAry!
            }
           
        }
    }
    
    
}




