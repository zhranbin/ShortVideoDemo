//
//  RBCodable.swift
//  ReviewAPP
//
//  Created by 冉彬 on 2020/3/13.
//  Copyright © 2020 BigWhite. All rights reserved.
//

import Foundation

struct RBBaseModel: RBCodable {
}

/// 扩展Codable协议,提供更便捷的编码解码方法
public protocol RBCodable: Codable {
    
}

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}



public extension RBCodable {
    
    //1.遵守CodableHelper协议的对象转json字符串
    func toJSONString() -> String? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    //2.对象转换成jsonObject
    func toJSONObject() -> Any? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
    }

    //3.json字符串转对象
    static func decodeJSON(from string: String?, designatedPath: String? = nil) -> Self? {

        guard let data = string?.data(using: .utf8),
            let jsonData = getInnerObject(inside: data, by: designatedPath) else {
            return nil
        }
        return try? JSONDecoder().decode(Self.self, from: jsonData)
    }

    //4.data转对象
    static func decodeData(from data: Data?, designatedPath: String? = nil) -> Self? {

          guard let jsonData = getInnerObject(inside: data, by: designatedPath) else {
            return nil
        }
        return try? JSONDecoder().decode(Self.self, from: jsonData)
    }
    
    //5.jsonObject转换对象或者数组
    static func decodeJSON(from jsonObject: Any?, designatedPath: String? = nil) -> Self? {
        
        guard let jsonObject = jsonObject,
            JSONSerialization.isValidJSONObject(jsonObject),
            let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: []),
            let jsonData = getInnerObject(inside: data, by: designatedPath)  else {
            return nil
        }
        return try? JSONDecoder().decode(Self.self, from: jsonData)
    }
}


extension Array: RBCodable where Element: RBCodable {
    
    static func decodeJSON(from jsonString: String?, designatedPath: String? = nil) -> [Element?]? {
        guard let data = jsonString?.data(using: .utf8),
            let jsonData = getInnerObject(inside: data, by: designatedPath),
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [Any] else {
            return nil
        }
        return Array.decodeJSON(from: jsonObject)
    }
    
    static func decodeData(from data: Data?, designatedPath: String? = nil) -> [Element?]? {
        guard let jsonData = getInnerObject(inside: data, by: designatedPath),
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [Any] else {
            return nil
        }
        return Array.decodeJSON(from: jsonObject)
    }
    
    
    
    static func decodeJSON(from array: [Any]?) -> [Element?]? {

        return array?.map({ (item) -> Element? in
            return Element.decodeJSON(from: item)
        })
        
    }
    
    
    
}


/// 借鉴HandyJSON中方法，根据designatedPath获取object中数据
///
/// - Parameters:
///   - jsonData: json data
///   - designatedPath: 获取json object中指定路径
/// - Returns: 可能是json object
fileprivate func getInnerObject(inside jsonData: Data?, by designatedPath: String?) -> Data? {

    //保证jsonData不为空，designatedPath有效
    guard let _jsonData = jsonData,
        let paths = designatedPath?.components(separatedBy: "."),
        paths.count > 0 else {
        return jsonData
    }
    
    //从jsonObject中取出designatedPath指定的jsonObject
    let jsonObject = try? JSONSerialization.jsonObject(with: _jsonData, options: .allowFragments)
    var result: Any? = jsonObject
    var abort = false
    var next = jsonObject as? [String: Any]
    paths.forEach({ (seg) in
        if seg.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" || abort {
            return
        }
        if let _next = next?[seg] {
            result = _next
            next = _next as? [String: Any]
        } else {
            abort = true
        }
    })
    //判断条件保证返回正确结果,保证没有流产,保证jsonObject转换成了Data类型
    if let result = result as? String {
        return result.data(using: .utf8)
    }
    guard abort == false,
        let resultJsonObject = result,
        let data = try? JSONSerialization.data(withJSONObject: resultJsonObject, options: []) else {
        return nil
    }
    return data
}


extension String: RBCodable{
    //1.遵守CodableHelper协议的对象转json字符串
    func toJSONString() -> String? {
        return self
    }
    
    //2.对象转换成jsonObject
    func toJSONObject() -> Any? {
        return self
    }

    //3.json字符串转对象
    static func decodeJSON(from string: String?, designatedPath: String? = nil) -> Self? {
        guard let data = string?.data(using: .utf8),
            let jsonData = getInnerObject(inside: data, by: designatedPath) else {
            return ""
        }
        return String(data: jsonData, encoding: .utf8)
    }

    //4.data转对象
    static func decodeData(from data: Data?, designatedPath: String? = nil) -> Self? {
        guard let jsonData = getInnerObject(inside: data, by: designatedPath) else {
            return ""
        }
        return String(data: jsonData, encoding: .utf8)
    }
    
    //5.jsonObject转换对象或者数组
    static func decodeJSON(from jsonObject: Any?, designatedPath: String? = nil) -> Self? {
        guard let jsonObject = jsonObject,
            JSONSerialization.isValidJSONObject(jsonObject),
            let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: []),
            let jsonData = getInnerObject(inside: data, by: designatedPath)  else {
            return ""
        }
        return String(data: jsonData, encoding: .utf8)
    }
}
extension Int: RBCodable{
    //1.遵守CodableHelper协议的对象转json字符串
    func toJSONString() -> String? {
        return "\(self)"
    }
    
    //2.对象转换成jsonObject
    func toJSONObject() -> Any? {
        return self
    }

    //3.json字符串转对象
    static func decodeJSON(from string: String?, designatedPath: String? = nil) -> Self? {
        guard let data = string?.data(using: .utf8),
            let jsonData = getInnerObject(inside: data, by: designatedPath) else {
            return 0
        }
        return Int(String(data: jsonData, encoding: .utf8) ?? "0")
    }

    //4.data转对象
    static func decodeData(from data: Data?, designatedPath: String? = nil) -> Self? {
        guard let jsonData = getInnerObject(inside: data, by: designatedPath) else {
            return 0
        }
        return Int(String(data: jsonData, encoding: .utf8) ?? "0")
    }
    
    //5.jsonObject转换对象或者数组
    static func decodeJSON(from jsonObject: Any?, designatedPath: String? = nil) -> Self? {
        guard let jsonObject = jsonObject,
            JSONSerialization.isValidJSONObject(jsonObject),
            let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: []),
            let jsonData = getInnerObject(inside: data, by: designatedPath)  else {
            return 0
        }
        return Int(String(data: jsonData, encoding: .utf8) ?? "0")
    }
}

extension Bool: RBCodable{
    //1.遵守CodableHelper协议的对象转json字符串
    func toJSONString() -> String? {
        return "\(self)"
    }
    
    //2.对象转换成jsonObject
    func toJSONObject() -> Any? {
        return self
    }

    //3.json字符串转对象
    static func decodeJSON(from string: String?, designatedPath: String? = nil) -> Self? {
        guard let data = string?.data(using: .utf8),
            let jsonData = getInnerObject(inside: data, by: designatedPath) else {
            return false
        }
        return Int(String(data: jsonData, encoding: .utf8) ?? "0") == 1
    }

    //4.data转对象
    static func decodeData(from data: Data?, designatedPath: String? = nil) -> Self? {
        guard let jsonData = getInnerObject(inside: data, by: designatedPath) else {
            return false
        }
        return Int(String(data: jsonData, encoding: .utf8) ?? "0") == 1
    }
    
    //5.jsonObject转换对象或者数组
    static func decodeJSON(from jsonObject: Any?, designatedPath: String? = nil) -> Self? {
        guard let jsonObject = jsonObject,
            JSONSerialization.isValidJSONObject(jsonObject),
            let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: []),
            let jsonData = getInnerObject(inside: data, by: designatedPath)  else {
            return false
        }
        return Int(String(data: jsonData, encoding: .utf8) ?? "0") == 1
    }
}
