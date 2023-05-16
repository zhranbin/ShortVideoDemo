//
//  ClientProtocol.swift
//  ReviewAPP
//
//  Created by 冉彬 on 2020/3/31.
//  Copyright © 2020 BigWhite. All rights reserved.
//

import UIKit

let clientProtocolShowLog = true

/// 封装了发送请求的方法
protocol Connect {
    func send<T: Request>(_ r: T, success: @escaping (Data?, URLResponse?) -> Void, failAction: ((RBNetError, URLResponse?) -> Void)?)
    
}

extension Connect {
    
    func send<T: Request>(_ r: T, success: @escaping (Data?, URLResponse?) -> Void, failAction: ((RBNetError, URLResponse?) -> Void)? = nil) {
        let urlTuple = r.url()
        guard let url = urlTuple.0 else {
            if clientProtocolShowLog { print("url 错误") }
            failAction?(RBNetError.urlError(urlStr: urlTuple.1), nil)
            return
        }
        let configure = URLSessionConfiguration.default
        let contentType = r.encodeType.getContentType()
        if var headers = r.head {
            if headers["Content-Type"] == nil {
                headers.updateValue(contentType, forKey: "Content-Type")
            }
            configure.httpAdditionalHeaders = headers
            if clientProtocolShowLog { printLog("\(r.host + r.path)\n请求头:\(headers)") }
        } else {
            configure.httpAdditionalHeaders = ["Content-Type": contentType]
            if clientProtocolShowLog { printLog("\(r.host + r.path)\n请求头:\(["Content-Type": contentType])") }
        }
        
        
        
        let session = URLSession.init(configuration: configure)
        var request = URLRequest(url: url)
        request.httpMethod = r.method.rawValue
        do {
            request.httpBody = try r.parameterData()
        } catch let error {
            switch error {
            case RBNetError.parameterEncodeError(_):
                failAction?(error as! RBNetError, nil)
            default:
                failAction?(RBNetError.parameterEncodeError(parameter: [:]), nil)
            }
        }
        
        request.timeoutInterval = 30
        if clientProtocolShowLog { print("⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️") }
        if clientProtocolShowLog { printLog("[\(r.method.rawValue)]:\(r.host + r.path)\n参数:\(r.parameter ?? [:])") }
        if clientProtocolShowLog { print("⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️") }
        let task = session.dataTask(with: request) {
            data, response, error in
            /// 日志打印
            if clientProtocolShowLog {
                resultLogAction(r, data, response, error)
            }
            
            if let err = error {
                failAction?(RBNetError.requestError(request: r, description: err.localizedDescription), response)
                return
            }
            
            success(data, response)
        }
        task.resume()
    }
    
}


/// 请求结果打印
/// - Parameters:
///   - r: Request
///   - data: data
///   - response: response
///   - error: error
func resultLogAction(_ r: Request, _ data: Data?, _ response: URLResponse?, _ error: Error?) {
    if (error != nil),let err = error{
        print("❌❌❌❌❌❌❌❌❌❌❌")
        printLog("[\(r.path)]:\(err.localizedDescription)")
        print("🤚🤚🤚🤚🤚🤚🤚🤚🤚🤚")
        return
    }
    if clientProtocolShowLog {
        print("👌👌👌👌👌👌👌👌👌👌")
        if (data != nil) {
            let jsonStr = String(data: data!, encoding: .utf8) ?? ""
            if let result = try? JsonParser.parse(text: jsonStr) {
                printLog("[\(r.path)]:返回数据：\n\(prettyJson(json: result))")
            } else {
                printLog("[\(r.path)]:返回数据：\n\(jsonStr)")
            }
            
        } else {
            printLog("[\(r.path)]:返回数据：nil")
        }
        print("🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺")
    }
}



// MARK:- 自定义打印方法
func printLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
#if DEBUG
    // 创建一个日期格式器
    let formatter = DateFormatter()
    // 为日期格式器设置格式字符串
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    // 使用日期格式器格式化当前日期、时间
    let datestr = formatter.string(from: Date())
    let fileName = (file as NSString).lastPathComponent
    print("[\(datestr)] [\(fileName)] [\(funcName)] [第\(lineNum)行]\n\(message)")
#endif
}
