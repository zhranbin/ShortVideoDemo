//
//  RBChaining.swift
//  ChainingTest
//
//  Created by mac on 2022/2/28.
//

import Foundation

@dynamicMemberLookup
struct RBChaining<T> {
    var subject: T
    subscript<Value>(dynamicMember keyPath: WritableKeyPath<T, Value>) -> ((Value) -> RBChaining<T>) {
        // 获取到真正的对象
        var subject = self.subject
        
        return { value in
            // 把 value 指派给 subject
            subject[keyPath: keyPath] = value
            return RBChaining(subject: subject)
        }
        
    }
    
    public func end(){}
}


protocol RBChainingProtocol {
    associatedtype T
    static var ch: RBChaining<T>.Type { get set }
    var ch: RBChaining<T> {get set}
}

extension RBChainingProtocol {
    
    static var ch: RBChaining<Self>.Type {
        get{
            RBChaining<Self>.self
        }
        set {
            
        }
    }
    
    var ch: RBChaining<Self> {
        get{
            RBChaining(subject: self)
        }
        set {
            
        }
    }
}



extension NSObject: RBChainingProtocol{}
