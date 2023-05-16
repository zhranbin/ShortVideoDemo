//
//  RequestProtocol.swift
//  ReviewAPP
//
//  Created by 冉彬 on 2020/3/31.
//  Copyright © 2020 BigWhite. All rights reserved.
//

import UIKit


public enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case head = "HEAD"
    case delete = "DELETE"
    case patch = "PATCH"
    case trace = "TRACE"
    case options = "OPTIONS"
    case connect = "CONNECT"

    
    /// 是否需要将参数拼接到url中
    public var isSplitParameters: Bool {
        switch self {
        case .get, .head, .delete:
            return true

        default:
            return false
        }
    }
}

public enum ParameterEncodeType {
    /// 表单（请求头的“Content-Type”赋值为“application/x-www-form-urlencoded; charset=utf-8”）
    case form
    /// json（请求头的“Content-Type”赋值为“application/json”）
    case json
    
    
    func getContentType() -> String {
        switch self {
        case .form:
            return "application/x-www-form-urlencoded; charset=utf-8"
        case .json:
            return "application/json"
        }
    }
}



/// 请求体协议
protocol Request {
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameter: [String: Any]? { get }
    var head: [AnyHashable : Any]? { get set }
    /// 编码类型
    var encodeType: ParameterEncodeType { get set }
    
    func parameterData() throws -> Data?
    func url() -> (URL?, String)
    
}


extension Request {
    
    /// 参数字段数据（用于将参数添加到body中）
    /// - Returns: Data
    func parameterData() throws -> Data? {
        guard let parameter = parameter else { return nil }
        if method.isSplitParameters { return nil }
        switch encodeType {
        case .form:
            return Data(query(parameter).utf8)
        case .json:
            do {
                return try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
            }catch {
                throw RBNetError.parameterEncodeError(parameter: parameter)
            }
        }
    }
    
    /// 请求的url
    /// - Returns: url
    func url() -> (URL?, String) {
        var urlStr: String
        // 有参数，并且参数需要拼接到url中
        if let parameter = parameter, method.isSplitParameters {
            let parameterStr = self.query(parameter)
            urlStr = "\(host)\(path)?\(parameterStr)"
            return (URL(string: urlStr), urlStr)
        }
        urlStr = "\(host)\(path)"
        return (URL(string: urlStr), urlStr)
        
    }
    
    
    
    /// 将参数字典转成query参数形式的字符串
    /// - Parameter parameters: 参数字典
    /// - Returns: 参数字符串
    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        // key 排序并拆分成元组数组
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += [(escape(key), escape("\(value)"))]
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    
    /// 处理特殊字符
    /// - Parameter string: 待处理的字符串
    /// - Returns: String
    private func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        let encodableDelimiters = CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        let allowedCharacterSet = CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
    }
}

