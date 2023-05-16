//
//  RBWaterfallFlowLayoutDelegate.swift
//  ClientAPP
//
//  Created by 冉彬 on 2021/1/21.
//

import Foundation
import UIKit

protocol RBWaterfallFlowLayoutDataSource: NSObjectProtocol {
    
    /// 瀑布流列数
    /// - Parameter weaterfallLayout: weaterfallLayout
    func columnNumber(_ weaterfallLayout: RBWaterfallFlowLayout) -> Int
    
    
    /// 每列之间的间距
    /// - Parameters:
    ///   - weaterfallLayout: weaterfallLayout
    func columnMarginOfWaterfallFlowLayout(_ weaterfallLayout: RBWaterfallFlowLayout) -> CGFloat
    
    
    /// item之间的间距(行间距)
    /// - Parameters:
    ///   - weaterfallLayout: weaterfallLayout
    ///   - indexPath: indexPath
    func waterfallFlowLayout(_ weaterfallLayout: RBWaterfallFlowLayout, itemMarginAt indexPath: IndexPath) -> CGFloat
    
    
    /// 边缘间距
    /// - Parameters:
    ///   - weaterfallLayout: weaterfallLayout
    ///   - indexPath: indexPath
    func waterfallFlowLayout(_ weaterfallLayout: RBWaterfallFlowLayout, edgeInsetsAt indexPath: IndexPath) -> UIEdgeInsets
    
    
    /// item的高度
    /// - Parameters:
    ///   - weaterfallLayout: weaterfallLayout
    ///   - indexPath: indexPath
    func waterfallFlowLayout(_ weaterfallLayout: RBWaterfallFlowLayout, itemHeightAt indexPath: IndexPath) -> CGFloat
}

