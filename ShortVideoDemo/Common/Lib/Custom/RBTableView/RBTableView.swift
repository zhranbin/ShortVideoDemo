//
//  RBTableView.swift
//  BangJiaJia
//
//  Created by 冉彬 on 2021/11/26.
//

import UIKit

class RBTableView: UITableView {

    /// 在UITableViewDataSource加载cell（调用cell.loadUI()）前的回调
    var cellWillLoad: ((IndexPath, RBTableViewRowModel, UITableViewCell) -> Void)? = nil
    /// 在UITableViewDataSource加载cell（调用cell.loadUI()）后的回调
    var cellDidLoad: ((IndexPath, RBTableViewRowModel, UITableViewCell) -> Void)? = nil
    /// 返回cell（用于重写cell）返回为nil时，走默认逻辑
    var cellAction: ((UITableView, IndexPath, RBTableViewRowModel) -> UITableViewCell?)? = nil
    
    
    
    var data: [RBTableViewSectionModel] = [] {
        didSet {
            DispatchQueue.main.async {[weak self] in
                self?.reloadData()
            }
        }
    }
    
    private var registedCellNames: [String] = []
    
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.dataSource = self
        // 隐藏分割线
        self.separatorStyle = .none
        self.separatorColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        // 避免内容自动滚到状态栏/导航栏下面
        self.contentInsetAdjustmentBehavior = .never
    }
        
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.separatorStyle = .none
        self.separatorColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        // 避免内容自动滚到状态栏/导航栏下面
        self.contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.dataSource = self
        self.separatorStyle = .none
        self.separatorColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        // 避免内容自动滚到状态栏/导航栏下面
        self.contentInsetAdjustmentBehavior = .never
    }
    
    
    /// 加载数据
    /// - Parameter data: 数据
    public func loadData(_ data: [RBTableViewSectionModel]) {
        self.data = data
    }
    
    /// 注册cell
    /// - Parameter cellNames: cellname数组
    private func registerCellAction(_ cellNames: [String]) {
        for cellName in cellNames {
            let nib = UINib(nibName:cellName , bundle: nil)
            self.register(nib, forCellReuseIdentifier: cellName)
            
        }
        
    }

}

extension RBTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var cellNames = [String]()
        if !registedCellNames.contains(RBTableViewCell.className) {
            cellNames.append(RBTableViewCell.className)
        }
        self.data.forEach { sectionModel in
            for rowModel in sectionModel.rowModels where (!registedCellNames.contains(rowModel.cellName ?? rowModel.defauleCellName())) {
                cellNames.append(rowModel.cellName ?? rowModel.defauleCellName())
            }
            let newNames = Array(Set(cellNames))
            registedCellNames.append(contentsOf: newNames)
            registerCellAction(newNames)
        }
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = self.data[section]
        return sectionModel.rowModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = self.data[indexPath.section]
        let row = min(indexPath.row, sectionModel.rowModels.count - 1)
        let rowModel = sectionModel.rowModels[row]
        // 判断是否重写返回cell的方法
        if let newCell = cellAction?(tableView, indexPath, rowModel) {
            return newCell
        }
        var cellname = rowModel.cellName != nil ? rowModel.cellName! : rowModel.defauleCellName()
        if !registedCellNames.contains(cellname) {
            cellname = RBTableViewCell.className
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellname, for: indexPath) as? RBTableViewCell
        self.cellWillLoad?(indexPath, rowModel, cell ?? UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.className))
        cell?.loadUI(model: rowModel, indexPath: indexPath)
        self.cellDidLoad?(indexPath, rowModel, cell ?? UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.className))
        cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat(MAXFLOAT))
        return cell ?? UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.className)
        
    }
    
    
}


