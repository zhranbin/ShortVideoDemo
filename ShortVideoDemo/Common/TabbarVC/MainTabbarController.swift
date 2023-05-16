//
//  VMainTabbarController.swift
//  VTime
//
//  Created by 冉彬 on 2019/10/24.
//  Copyright © 2019 Bingle. All rights reserved.
//

import UIKit
class MainTabbarController: UITabBarController {
    private var messageVC: RBBaseViewController?;

    lazy var exampleVC: RBBaseViewController = {
        var vc = RBBaseViewController()
        vc.isHiddenBackBtn = true
        vc.title = .loc_示例
        vc.tabBarItem.image = UIImage(named: "tab_home")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "tab_home_sel")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.title = .loc_示例
        return vc
        
    }()
    
    lazy var otherVC: RBBaseViewController = {
        var vc = RBBaseViewController()
        vc.isHiddenBackBtn = true
        vc.title = .loc_其他
        vc.tabBarItem.image = UIImage(named: "tab_home")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "tab_home_sel")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.title = .loc_其他
        return vc
        
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = hexColor(0x333333)
        self.tabBar.unselectedItemTintColor = .lightGray
        
        var vcs = [UIViewController]()
        vcs.append(getCustomNavigationController(UINavigationController(rootViewController: self.exampleVC)))
        vcs.append(getCustomNavigationController(UINavigationController(rootViewController: self.otherVC)))
        self.viewControllers = vcs
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    
    /// 设置自定义导航控制器（导航栏颜色，标题等设置）
    /// - Parameter nav: 需要设置的导航控制器
    func getCustomNavigationController(_ nav: UINavigationController) -> UINavigationController {
        
        let barApp = UINavigationBarAppearance()
        barApp.backgroundColor = .white
        barApp.shadowColor = .white
        nav.navigationBar.scrollEdgeAppearance = barApp//UINavigationBarAppearance()
        nav.navigationBar.standardAppearance = barApp
        nav.navigationBar.tintColor = .white
        nav.navigationBar.isTranslucent = true
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: self.tabBar.height + bottomSafeAreaHeight + 10))
        view.backgroundColor = .clear
        let v = UIView(frame: CGRect(x: 0, y: 3, width: screenWidth, height: view.height))
        v.backgroundColor = .white
        v.cornerAndShadow(color: .hexColor(0xefefef), offset: CGSize(width: 0, height: 0), opacity: 1, shadowRadius: 1.5, radius: 10)
        view.addSubview(v)
        let image = view.toImage()
        if #available(iOS 15.0, *){
            let barApp = UITabBarAppearance()
            barApp.backgroundColor = .white
            barApp.shadowColor = .white
            barApp.backgroundImage = image
            barApp.backgroundImageContentMode = .top
            self.tabBar.scrollEdgeAppearance = barApp
            self.tabBar.standardAppearance = barApp
        }
        self.tabBar.clipsToBounds = true
        
        
        return nav;
    }

}


