//
//  String+RBLanguage.swift
//  多语言
//
//  Created by 冉彬 on 2020/12/24.
//

import Foundation

extension String {

	static var loc_请输入提示信息: String { return "请输入提示信息".localizedString }
	static var loc_网络请求: String { return "网络请求".localizedString }
	static var loc_默认: String { return "默认".localizedString }
	static var loc_有数据: String { return "有数据".localizedString }
	static var loc_toast弹窗与加载弹窗: String { return "toast弹窗与加载弹窗".localizedString }
	static var loc_提示信息: String { return "提示信息".localizedString }
	static var loc_自定义: String { return "自定义".localizedString }
	static var loc_属性链式写法: String { return "属性链式写法".localizedString }
	static var loc_蓝牙: String { return "蓝牙".localizedString }
	static var loc_示例: String { return "示例".localizedString }
	static var loc_其他: String { return "其他".localizedString }
	static var loc_切换语言: String { return "切换语言".localizedString }
	static var loc_空数据示例: String { return "空数据示例".localizedString }


    var localizedString: String {
        let bundle = Bundle.getLanguageBundel()
        if bundle != nil {
            return NSLocalizedString(self, tableName: "RBLanguageString", bundle: bundle!, value: "", comment: "")
        }
        return NSLocalizedString(self, comment: "")
    }
}
