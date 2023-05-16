//
//  UITableView+RBEmptyData.swift
//  BangJiaJia
//
//  Created by 冉彬 on 2021/12/25.
//

import Foundation
import UIKit


var isLoadEmptyData: Bool = false

extension UITableView {
    private struct AssociatedKeys {
        static var emptyDataViewKey = "emptyDataViewKey"
        static var emptyDataViewWillDisplayKey = "emptyDataViewWillDisplayKey"
        static var emptyDataViewDidDisplayKey = "emptyDataViewDidDisplayKey"
    }
    
    /// 加载空数据
    fileprivate class func loadEmptyData() {
        if isLoadEmptyData {
            return
        }
        isLoadEmptyData = true
        /// 替换reloadData()方法
        self.swizzleInitializeMethod(#selector(UITableView.reloadData), to: #selector(UITableView.rbReloadData))
    }
    
    /// 空数据展示View
    var emptyDataView: RBEmptyDataView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.emptyDataViewKey) as? RBEmptyDataView
        }
        
        set {
            UITableView.loadEmptyData()
            if emptyDataView != nil {
                emptyDataView?.removeFromSuperview()
            }
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.emptyDataViewKey,
                    newValue as RBEmptyDataView?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    /// 空数据界面将要显示时的回调
    var emptyDataViewWillDisPlayAction: ((UITableView, RBEmptyDataView) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.emptyDataViewWillDisplayKey) as? ((UITableView, RBEmptyDataView) -> Void)
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.emptyDataViewWillDisplayKey,
                    newValue as ((UITableView, RBEmptyDataView) -> Void)?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    /// 空数据界面显示时的回调
    var emptyDataViewDidDisPlayAction: ((UITableView, RBEmptyDataView) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.emptyDataViewDidDisplayKey) as? ((UITableView, RBEmptyDataView) -> Void)
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.emptyDataViewDidDisplayKey,
                    newValue as ((UITableView, RBEmptyDataView) -> Void)?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    
    
    @objc func rbReloadData() {
        DispatchQueue.main.async {[weak self] in
            self?.rbReloadData()
        }
        
        
        if checkEmptyData() && self.emptyDataView != nil {
            self.emptyDataView!.removeFromSuperview()
            self.emptyDataView?.frame = self.bounds
            self.emptyDataViewWillDisPlayAction?(self, self.emptyDataView!)
            // 刷新空数据界面UI
            self.emptyDataView?.refreshUI()
            self.insertSubview(self.emptyDataView!, at: 0)
            self.emptyDataViewDidDisPlayAction?(self, self.emptyDataView!)
        } else {
            self.emptyDataView?.removeFromSuperview()
        }
        
        
    }
    
    
    /// 检查是否没有数据显示
    /// - Returns: 是否是空数据
    func checkEmptyData() -> Bool {
        guard let tableDataSource: UITableViewDataSource = self.dataSource else {return true}
        var sectionNum: Int = 1
        if let number = tableDataSource.numberOfSections?(in: self) {
            sectionNum = number
        }
        for section in 0 ..< sectionNum {
            let rowNum: Int = tableDataSource.tableView(self, numberOfRowsInSection: section)
            if rowNum > 0 {
                return false
            }
        }
        return true
        
    }
    
}


extension NSObject {
    
    public class func swizzleInitializeMethod(_ original: Selector, to swizzled: Selector){
        let originalSelector = original
        let swizzledSelector = swizzled
        let originalMethod = class_getInstanceMethod(self, original)
        let swizzledMethod = class_getInstanceMethod(self, swizzled)
        //在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
        let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}
