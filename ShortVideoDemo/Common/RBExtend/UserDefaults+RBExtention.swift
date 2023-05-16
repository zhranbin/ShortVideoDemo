//
//  UserDefaults+RBExtention.swift
//  RBExtendDemo
//
//  Created by RanBin on 2021/9/4.
//

import Foundation

// MARK: - UserDefaults常用封装
protocol UserDefaultsSettable {
    associatedtype defaultKeys: RawRepresentable
}


extension UserDefaultsSettable where defaultKeys.RawValue==String {
    
    static func setValue(_ value: Any?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    static func string(forKey key: defaultKeys) -> String? {
        let aKey = key.rawValue
        return UserDefaults.standard.string(forKey: aKey)
    }
    static func int(forKey key: defaultKeys) -> Int? {
        let aKey = key.rawValue
        return Int(UserDefaults.standard.integer(forKey: aKey))
    }
    static func array(forKey key: defaultKeys) -> [Any]? {
        let aKey = key.rawValue
        return UserDefaults.standard.array(forKey: aKey)
    }
    static func object(forKey key: defaultKeys) -> Any? {
        let aKey = key.rawValue
        return UserDefaults.standard.dictionary(forKey: aKey)
    }
    
}


extension UserDefaultsSettable where defaultKeys.RawValue==String {
    
    static func set(value: Any?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    
}



/**
 使用：
 
 UserDefaults.LoginInfo.set(value: "token", forKey: .token)
 UserDefaults.LoginInfo.string(forKey: .token)
 
 */
extension UserDefaults {
    
    // 登录信息
    struct LoginInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            /// 历史电话（上一次登陆）
            case historyPhone
            /// 历史密码（上一次登陆）
            case historyPassword
            case token
            case userId
            case userName
//            case loginStatus
            
        }
    }
    
    // 账户信息
    struct AccountInfo: UserDefaultsSettable {
        enum defaultKeys: String {
//            /// 历史电话（上一次登陆）
//            case historyPhone
//            /// 历史密码（上一次登陆）
//            case historyPassword
            /// 搜索历史
            case searchHistory
        }
    }
    
    // APP信息
    struct APPInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            /// 上一次启动版本号
            case version
            /// 同意用户隐私协议
            case agree
        }
    }
    
    // 数据信息
    struct DataInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            /// 订单列表
            case orderList
            /// 地址列表
            case addressList
            /// 签到记录
            case signList
        }
    }
    
    
    
    
    
    
}
