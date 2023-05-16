//
//  RBTableViewCell.swift
//  BangJiaJia
//
//  Created by 冉彬 on 2022/1/28.
//

import UIKit

class RBTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
    override func addSubview(_ view: UIView) {
        /// 判断系统的cell分割线
        if let cla = NSClassFromString("_UITableViewCellSeparatorView"), view.isKind(of: cla.class()) {
            return
        }
        super.addSubview(view)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadUI(model: RBTableViewRowModel, indexPath: IndexPath) {
        //
    }
    

}
