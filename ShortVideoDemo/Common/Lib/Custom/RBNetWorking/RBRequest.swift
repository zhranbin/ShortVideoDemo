//
//  RBRequest.swift
//  RBNetWorkingDemo
//
//  Created by RanBin on 2021/9/15.
//

import Foundation


struct RBRequest: Request {
    var host: String
    var path: String
    var method: HTTPMethod
    var parameter: [String : Any]?
    var head: [AnyHashable : Any]?
    var encodeType: ParameterEncodeType = .form
    
}
