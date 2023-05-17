//
//  AppDelegate.swift
//  ShortVideoDemo
//
//  Created by 冉彬 on 2023/5/16.
//

import UIKit
import AVFAudio

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
        
        do {
            if #available(iOS 10.0, *) {
                try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
            } else {
                AVAudioSession.sharedInstance().perform(NSSelectorFromString("setCategory:error:"), with: AVAudioSession.Category.playback)
            }
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("setAudioMode error:" + error.localizedDescription)
        }
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.bounds = UIScreen.main.bounds
//        window?.rootViewController = ListVC()
        window?.makeKeyAndVisible()
        gotoLaunchVC()
        
        return true
    }


    
    /// 跳转到主界面
    func gotoMainVC() {
        window?.rootViewController = ListVC()
    }
    
    /// 跳转到启动界面
    func gotoLaunchVC() {
        let vc = LaunchVC()
        vc.netWorkingUsefulAction = {[weak self] in
            self?.gotoMainVC()
        }
        window?.rootViewController = vc
    }
    
    

}

