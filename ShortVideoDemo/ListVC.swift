//
//  ListVC.swift
//  RBPlayerDemo
//
//  Created by 冉彬 on 2023/4/22.
//

import UIKit

class ListVC: RBBaseViewController {
    
    var currentIndex:Int = 0 {
        didSet {
            print(currentIndex)
            RBPlayerManager.shared.play(urlStr: dataAry[currentIndex])
        }
    }
    
    @IBOutlet weak var tableView: RBTableView! {
        didSet {
            tableView.delegate = self
            tableView.isPagingEnabled = true
            let head = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            })
            head.lastUpdatedTimeLabel?.isHidden = true
            tableView.mj_header = head
            
            self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {[weak self] in
                guard let self = self else {return}
                self.dataAry.append(contentsOf: self.dataAry)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.tableView.mj_footer?.endRefreshing()
                }
            })
//            self.tableView.mj_footer?.isHidden = true
            
        }
    }
    
    var dataAry: [String] = [] {
        didSet {
            tableView.loadData([RBTableViewSectionModel(rowModels: dataAry.map({ urlStr in
                return ListCellModel(videoUrl: urlStr)
            }))])
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.isHiddenNav = true
        dataAry = [
            "https://video-js.51miz.com/preview/video/00/00/13/49/V-134965-7DD8DDFB.mp4",
            "https://video-js.51miz.com/preview/video/00/00/11/87/V-118704-9DCF1D74.mp4",
            "https://video-js.51miz.com/preview/element/00/01/25/83/E-1258394-B7411486.mp4",
            "https://video-js.51miz.com/preview/video/00/00/16/05/V-160535-AAB9F2D2.mp4",
            "https://video-js.51miz.com/preview/video/00/00/15/91/V-159150-F02CFE3E.mp4",
            "https://video-js.51miz.com/preview/video/00/00/12/67/V-126722-CF5A009C.mp4",
            "https://video-js.51miz.com/preview/element/00/01/25/86/E-1258600-76413DDF.mp4",
            "https://video-js.51miz.com/preview/video/00/00/14/28/V-142881-FF479F28.mp4",
            "https://video-js.51miz.com/preview/video/00/00/11/74/V-117479-9DE7CACC.mp4",
            "https://video-js.51miz.com/preview/video/00/00/11/56/V-115624-C8648D16.mp4",
            "https://img.tukuppt.com/video_show/30540847/03/94/18/6462f0d9da015.mp4",
            "https://img.tukuppt.com/video_show/2629112/00/01/92/5b4d9113bffd1_10s_big.mp4",
            "https://img.tukuppt.com/video_show/7165162/00/19/39/5f06cfe424c38_10s_big.mp4",
            "https://img.tukuppt.com/video_show/09/06/80/613871f3cb2d8_10s_big.mp4",
            "https://img.tukuppt.com/video_show/15653652/01/00/67/6117b79d71fa8_10s_big.mp4",
            "https://img.tukuppt.com/video_show/15653652/00/30/01/5fa0fc15a3470_10s_big.mp4",
            "https://img.tukuppt.com/video_show/15653652/01/22/71/620f42b183ae0_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2405811/00/25/91/5f7181591abbb_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2405811/00/34/41/5fcb54f5aa800_10s_big.mp4",
            "https://img.tukuppt.com/video_show/3664703/00/02/03/5b4f3c440b285_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2418175/00/02/22/5b52e01dad564_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2421007/00/01/99/5b4ec6e9b2913_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2629112/00/03/29/5bc1fe8d802b6_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2269348/00/01/95/5b4de7fb616b0_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2405811/00/26/16/5f7418e33dbb7_10s_big.mp4",
            "https://img.tukuppt.com/video_show/10/10/92/9/632fe21d61b57_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2269348/00/01/95/5b4de62445335_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2418175/00/02/49/5b713b83edadd_10s_big.mp4",
            "https://img.tukuppt.com/video_show/3664703/00/02/02/5b4f07452a155_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2629112/00/01/93/5b4e8b08c6531_10s_big.mp4",
            "https://img.tukuppt.com/video_show/8321488/00/14/04/5e144eab15a9c_10s_big.mp4",
            "https://img.tukuppt.com/video_show/3664703/00/02/06/5b4ffca12d70b_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2418175/00/02/04/5b5085d637d83_10s_big.mp4",
            "https://img.tukuppt.com/video_show/15653652/01/23/56/6219f6b95c8fb_10s_big.mp4",
            "https://img.tukuppt.com/video_show/1863507/00/25/22/5f6c2c5b1c44e_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2418175/00/01/59/5b46cd09f3f1e_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2629112/00/08/27/5d1c46da8a9e4_10s_big.mp4",
            "https://img.tukuppt.com/video_show/2475824/00/08/27/5d1c226cd2de7_10s_big.mp4",
            "https://img.tukuppt.com/video_show/09/03/38/632fe23343873_10s_big.mp4",
            
        ]
        dataAry.append(contentsOf: dataAry)
        
        
        
        // Do any additional setup after loading the view.
    }


}

extension ListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        screenHeight
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print("didEndDisplaying - \(indexPath.row)")
        let row = Int(tableView.contentOffset.y/screenHeight)
        currentIndex = row
//        print(row)
        
    }
    
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        DispatchQueue.main.async {
//            let translatedPoint = scrollView.panGestureRecognizer.translation(in: scrollView)
//            print("结束滑动,禁止手势")
            scrollView.panGestureRecognizer.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
//                print("允许手势")
                scrollView.panGestureRecognizer.isEnabled = true
            }
        }
    }
    
    
    
}
