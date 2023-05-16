//
//  UploadProtocol.swift
//  ReviewAPP
//
//  Created by 冉彬 on 2020/4/8.
//  Copyright © 2020 BigWhite. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices


/// 上传
protocol Upload {
    func upload<T: Request>(_ r: T, image: UIImage, handler: @escaping (Data?) -> Void)
    func upload<T: Request>(_ r: T, filePath: String, handler: @escaping (Data?) -> Void)
    
    /// 上传
    /// - Parameters:
    ///   - r: Request
    ///   - data: 上传数据
    ///   - name: 字段名（后台获取数据用的字段）
    ///   - mimeType: 数据类型
    ///   - filename: 文件名
    ///   - handler: 回调
    func upload<T: Request>(_ r: T, data: Data, name: String, mimeType: String?, filename: String, handler: @escaping (Data?) -> Void) -> URLSessionDataTask?
    
}

extension Upload {
    
    func upload<T: Request>(_ r: T, image: UIImage, handler: @escaping (Data?) -> Void) {
        guard let url = r.url().0 else {
            print("url 错误")
            DispatchQueue.main.async {
                handler(nil)
            }
            handler(nil)
            return
        }
        let configure = URLSessionConfiguration.default
        if r.head != nil {
            configure.httpAdditionalHeaders = r.head
        }
        
        let session = URLSession.init(configuration: configure)
        var request = URLRequest(url: url)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createBody(parameters: r.parameter as? [String : String],
                                boundary: boundary,
                                data: image.jpegData(compressionQuality:1.0)!,
                                mimeType: "image/JPG",
                                filename: "imageName.JPG")
        
        request.httpMethod = r.method.rawValue
        let task = session.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print(error!)
            }
            
            DispatchQueue.main.async {
                handler(data)
            }
        }
        task.resume()
    }
    
    
    func upload<T: Request>(_ r: T, filePath: String, handler: @escaping (Data?) -> Void ) {
        guard let url = r.url().0 else {
            print("url 错误")
            DispatchQueue.main.async {
                handler(nil)
            }
            handler(nil)
            return
        }
        
        let configure = URLSessionConfiguration.default
        if r.head != nil {
            configure.httpAdditionalHeaders = r.head
        }
        
        let session = URLSession.init(configuration: configure)
        var request = URLRequest(url: url)
        var data: Data? = nil
        if FileManager.default.fileExists(atPath: filePath) {
            data = FileManager.default.contents(atPath: filePath)
            //            data = Data.dataWithContentsOfMappedFile(path) as? NSData
        }
        if data == nil {
            print("文件不存在")
            handler(nil)
        }
        let fileName = String(filePath.split(separator: "/").last ?? Substring(""))
        let mime = self.mimeType(pathExtension: String(filePath.split(separator: ".").last ?? Substring("")))
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createBody(parameters: r.parameter as? [String : String],
                                boundary: boundary,
                                data: data!,
                                mimeType: mime,
                                filename: fileName)
        
        request.httpMethod = r.method.rawValue
        let task = session.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print(error!)
            }
            
            DispatchQueue.main.async {
                handler(data)
            }
        }
        task.resume()
    }
    
    
    
    func upload<T: Request>(_ r: T, data: Data, name: String, mimeType: String?, filename: String, handler: @escaping (Data?) -> Void) -> URLSessionDataTask? {
        guard let url = r.url().0 else {
            print("url 错误")
            DispatchQueue.main.async {
                handler(nil)
            }
            handler(nil)
            return nil
        }
        
        let configure = URLSessionConfiguration.default
        if r.head != nil {
            configure.httpAdditionalHeaders = r.head
        }
        
        let session = URLSession.init(configuration: configure)
        var request = URLRequest(url: url)
//        request.timeoutInterval = 1200
        var parame = r.parameter ?? [:]
        parame["filename"] = filename
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createBody(parameters: parame as? [String : String],
                                      boundary: boundary,
                                      data: data,
                                      name: name,
                                      mimeType: mimeType,
                                      filename: filename)
        
        request.httpMethod = r.method.rawValue
        let task = session.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print(error!)
            }
            
            DispatchQueue.main.async {
                handler(data)
            }
        }
        task.resume()
        return task
    }
    
    
    
    
    func createBody(parameters: [String: String]?,
                    boundary: String,
                    data: Data,
                    name: String = "file",
                    mimeType: String? = nil,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        if let parameters {
            for (key, value) in parameters {
                body.appendString(boundaryPrefix)
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n")
        if let mimeType {
            body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        }
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
    
    //根据后缀获取对应的Mime-Type
        func mimeType(pathExtension: String) -> String {
            if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                               pathExtension as NSString,
                                                               nil)?.takeRetainedValue() {
                if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?
                    .takeRetainedValue() {
                    return mimetype as String
                }
            }
            //文件资源类型如果不知道，传万能类型application/octet-stream，服务器会自动解析文件类
            return "application/octet-stream"
        }
    
    
}


extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
