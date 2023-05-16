//
//  RBTableViewRowModel.swift
//  BangJiaJia
//
//  Created by 冉彬 on 2021/11/26.
//

import Foundation
import UIKit
protocol RBTableViewRowModel {
    var cellName: String? {get set}
    func defauleCellName() -> String
}

extension RBTableViewRowModel {
    var cellName: String? {
        get{
            return defauleCellName()
        }
        set{}
    }
    func defauleCellName() -> String {
        return RBTableViewCell.className
    }
}

extension NSObject {
    public var className: String {
        return type(of: self).className
    }

    public static var className: String {
        return String(describing: self)
    }
}
