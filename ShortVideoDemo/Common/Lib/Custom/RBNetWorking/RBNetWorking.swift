//
//  RBNetWorking.swift
//  RBNetWorkingDemo
//
//  Created by RanBin on 2021/9/15.
//

import Foundation


struct RBNetWorkModel<T: RBCodable>: RBCodable {
    var code: Int?
    var data: T?
    var message: String?
}


struct RBNetWorking: Connect, Upload {
    
    
    /// 请求
    /// - Parameters:
    ///   - host: host
    ///   - path: path
    ///   - method: 请求方式
    ///   - parameter: 参数
    ///   - encodeType: 参数编码方式（form, json）
    ///   - head: 额外的请求头
    ///   - isShowTip: 是否显示错误提示
    ///   - clz: 返回值解析类（回调闭包指定后可以不传）
    ///   - result: 回调闭包
    static func request<T: RBCodable>(host: String,
                                      path: String,
                                      method: HTTPMethod,
                                      parameter: [String: Any]? = nil,
                                      encodeType: ParameterEncodeType = .json,
                                      head: [AnyHashable: Any]? = nil,
                                      isShowTip: Bool = true,
                                      clz: T.Type? = nil,
                                      result: ((T?, RBNetError?) -> Void)? = {_, _ in}) {
        
        let request = RBRequest(host: host, path: path, method: method, parameter: parameter, head: loadRequestHeader(head: head), encodeType: encodeType)
        self.init().send(request) { data, resoonse in
            /// 解析data
            if let data = data, let netModel = RBNetWorkModel<T>.decodeData(from: data) {
                switch netModel.code {
                case RBNetWorkingCode.success.rawValue: // 0
                    DispatchQueue.main.async {
                        if netModel.data == nil {
                            result?(RBBaseModel() as? T, nil)
                        }else {
                            result?(netModel.data, nil)
                        }
                    }
                default:
                    var describe = ""
                    if let c = RBNetWorkingCode(rawValue: netModel.code ?? -8888888) {
                        describe = c.getDescribe()
                    } else {
                        describe = RBNetWorkingCode.other.getDescribe()
                    }
                    let er = RBNetError.resuleError(request: request, description: netModel.message ?? describe, code: netModel.code ?? -8888888)
                    if isShowTip { RBToast.showMessage(er.localizedDescription) }
                    DispatchQueue.main.async {
                        result?(netModel.data, er)
                    }
                }
                
                return
            }
            /// json解析失败
            DispatchQueue.main.async {
                let er = RBNetError.parseJSONError(request: request, data: data)
                if isShowTip { RBToast.showMessage(er.localizedDescription) }
                result?(nil, er)
            }
        } failAction: { error, resoonse in
            /// 请求失败
            if isShowTip { RBToast.showMessage(error.localizedDescription) }
            DispatchQueue.main.async {
                result?(nil, error)
            }
        }
        
    }
    
    
    
    /// 加载请求头
    /// - Parameter head: 头
    /// - Returns: 结果
    static func loadRequestHeader(head: [AnyHashable: Any]?) -> [AnyHashable: Any]? {
        var header: [AnyHashable: Any] = [:]
        let secret = String.random(32, true)
        let timestamp = String.getNowTimeStamp()
        let signature = "\(timestamp)\(secret)@wlzw"
        header["secret"] = secret
        header["timestamp"] = timestamp
        header["signature"] = signature.md5
        if APPSingle.shared.token.count > 0 {
            header["Authorization"] = "bearer " + APPSingle.shared.token
        }
        if let h = head {
            h.forEach { (key, value) in
                header[key] = value
            }
        }
        print("请求头：\(header)")
        return header
    }
    
    
    
}
