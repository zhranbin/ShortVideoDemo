//
//  RBNetWorkingApi.swift
//  WeiZhiYou
//
//  Created by 冉彬 on 2022/4/17.
//

import Foundation

enum RBNetWorkingCode: Int {
    /// 未知错误
    case other = -8888888
    /// 请求成功
    case success = 0
    /// 登陆失效
    case unauthorized = 10003
    /// 登陆失效1
    case unauthorized1 = 10004
    /// 被禁止的
    case forbidden = 403
    /// 未发现服务
    case notFound = 404
    
    func getDescribe() -> String {
        switch self {
        case .other:
            return "未知错误"
        case .success:
            return "请求成功"
        case .unauthorized, .unauthorized1:
            return "登陆失效"
        case .forbidden:
            return "请求被禁止"
        case .notFound:
            return "未发现服务"
        }
    }
    
}



enum RBNetWorkingApi: String {
    // MARK: Test
    /// post请求
    case postApi = "/post"
    /// get请求
    case getApi = "/get"
    
    
}
