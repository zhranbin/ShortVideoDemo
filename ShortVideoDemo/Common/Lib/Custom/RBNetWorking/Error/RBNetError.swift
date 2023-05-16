//
//  RBNetError.swift
//  BangJiaJia
//
//  Created by 冉彬 on 2022/4/15.
//

import Foundation

enum RBNetError: Error {
    case parameterEncodeError(parameter: [String: Any])
    case urlError(urlStr: String)
    case requestError(request: Request, description: String)
    case parseJSONError(request: Request, data: Data?)
    case resuleError(request: Request, description: String, code: Int)
}
extension RBNetError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .parameterEncodeError:
            return "参数编码错误"
        case .urlError:
            return "url错误"
        case .requestError(request: _, description: let description):
            return description
        case .parseJSONError:
            return "数据解析错误"
        case .resuleError(request: _, description: let description, code: _):
            return description
        }
    }
}
