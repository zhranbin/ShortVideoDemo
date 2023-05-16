//
//  RBWaterfallCollectionView.swift
//  ClientAPP
//
//  Created by 冉彬 on 2021/1/21.
//

import UIKit

class RBWaterfallFlowLayout: UICollectionViewFlowLayout {

    private var columnCount : Int = 2
    private var columnMargin : CGFloat = 10.0
    private var itemMargin : CGFloat = 10.0
    private var EdgeInsetsDefault : UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    weak open var dataSource: RBWaterfallFlowLayoutDataSource?
    
    //存放所有cell的布局属性
    lazy var attrsArray = [UICollectionViewLayoutAttributes]()
    //存放所有列的当前高度
    lazy var columnHeightsAry = [CGFloat]()
    
    
    override func prepare() {
        super.prepare()
        // 清除高度
        columnHeightsAry.removeAll()
        self.columnCount = self.dataSource?.columnNumber(self) ?? self.columnCount
        
        for _ in 0 ..< self.columnCount {
            columnHeightsAry.append(EdgeInsetsDefault.top)
        }
        
        // 清除所有的布局属性
        attrsArray.removeAll()
        

        let sections : Int = (self.collectionView?.numberOfSections)!
        for num in 0 ..< sections {
            let index : IndexPath = IndexPath.init(row: 0, section: num);
            if let setionAtt = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at:index) {
                attrsArray.append(setionAtt)
            }
            let count : Int = (self.collectionView?.numberOfItems(inSection: num))!//获取分区0有多少个item
            for i in 0 ..< count {
                
                let indexpath : NSIndexPath = NSIndexPath.init(item: i, section: num)
        
                let attrs = self.layoutAttributesForItem(at: indexpath as IndexPath)!
                
                attrsArray.append(attrs)
            }
        }
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        
        let attrs = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        let collectionWidth = self.collectionView?.frame.size.width
        //获得所有item的宽度
        let itemW = (collectionWidth! - EdgeInsetsDefault.left - EdgeInsetsDefault.right - CGFloat(columnCount-1) * columnMargin) / CGFloat(columnCount)
        
        let  itemH: CGFloat = self.dataSource?.waterfallFlowLayout(self, itemHeightAt: indexPath) ?? 60
        //找出高度最短那一列
        var dextColum : Int = 0
        var mainH = columnHeightsAry[0]
        
        for i in 1 ..< columnCount{
            //取出第i列的高度
            let columnH = columnHeightsAry[i]
            if mainH > columnH {
                mainH = columnH
                dextColum = i
            }
        }
        
        let x = EdgeInsetsDefault.left + CGFloat(dextColum) * (itemW + columnMargin)
        var y = mainH
        
        if y != EdgeInsetsDefault.top{
            y = y + itemMargin
        }
        if let setionAtt = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at:indexPath) {
            if indexPath.row == 0 || indexPath.row == 1 {
                y += setionAtt.frame.maxY;
            }
        }
        attrs.frame = CGRect(x: x, y: y, width: itemW, height: CGFloat(itemH))
        //更新最短那列高度
        columnHeightsAry[dextColum] = attrs.frame.maxY
        return attrs
    }
    
    
    override var collectionViewContentSize: CGSize {
        
        var maxHeight = columnHeightsAry[0]
        
        for i in 1 ..< columnCount {
            let columnHeight = columnHeightsAry[i]
            
            if maxHeight < columnHeight {
                maxHeight = columnHeight
            }
        }
        
        return CGSize.init(width: 0, height: maxHeight + EdgeInsetsDefault.bottom)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return attrsArray
    }
    
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        false
//    }
    

    
}
