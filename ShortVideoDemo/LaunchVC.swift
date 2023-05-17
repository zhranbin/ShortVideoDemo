//
//  LaunchVC.swift
//  ShortVideoDemo
//
//  Created by 冉彬 on 2023/5/16.
//

import UIKit

class LaunchVC: RBBaseViewController {
    
    var netWorkingUsefulAction: (() -> Void)?
    
    @IBOutlet weak var notNetWorkingView: UIView!
    
    @IBOutlet weak var refreshBtn: UIButton!
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    
    var isRequesting: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        checkNetWorking()
        activityView.startAnimating()

        // Do any additional setup after loading the view.
    }

    func checkNetWorking() {
        isRequesting = true
        self.notNetWorkingView.isHidden = true
        RBNetWorking.otherRequest(host: "https://www.baidu.com", path: "", method: .get, parameter: nil, encodeType: .form, head: nil, isShowTip: false) { model, error in
            self.isRequesting = false
            if error == nil {
                DispatchQueue.main.async {
                    self.netWorkingUsefulAction?()
                }
            } else {
                self.notNetWorkingView.isHidden = false
            }
            
        }
    }
    
    
    
    @IBAction func refreshBtnAction(_ sender: Any) {
        if !isRequesting {
            checkNetWorking()
        }
    }
    

}
