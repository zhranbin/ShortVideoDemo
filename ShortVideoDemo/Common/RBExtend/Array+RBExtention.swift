//
//  Array+RBExtention.swift
//  BangJiaJia
//
//  Created by 冉彬 on 2021/12/26.
//

import Foundation

extension Array where Element: Equatable {
    var removeRepetition: [Element] {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        return result
    }
    
    
}
