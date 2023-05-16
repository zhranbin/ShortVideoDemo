//
//  Downloader.swift
//  RBNetWorkingDemo
//
//  Created by RanBin on 2021/9/16.
//

import Foundation
import UIKit


enum DownloaderStatus: String {
    case none = "初始状态"           // 未开始，初始状态
    case downLoading = "下载中"     // 下载中
    case pause = "下载暂停"         // 下载暂停
    case cancel = "取消下载"        // 取消下载
    case success = "下载完成"       // 下载完成
    case failed = "下载失败"        // 下载失败
}

typealias DownloaderProgressAction = (_ totalSize: Int64, _ currentSize: Int64, _ progress: Double)->()
typealias DownloaderSuccessAction = (_ path: String)->()
typealias DownloaderFailedAction = (_ error: DownLoadError)->()
typealias DownloaderStatusChangedAction = (_ status: DownloaderStatus)->()


class Downloader: NSObject {
    
    /// 下载状态
    fileprivate var __status: DownloaderStatus = .none
    fileprivate var _status: DownloaderStatus {
        get {
            __status
        }
        set {
            __status = newValue
            _statusChangedAction?(__status)
        }
    }
    
    /// 下载url
    fileprivate var url: URL?
    
    /// 当前下载任务
    fileprivate var downloadTask: URLSessionDownloadTask?
    
    /// 下载数据结构体
    fileprivate var downloadData: DownloadData = DownloadData()
    
    fileprivate var progressAction: DownloaderProgressAction?
    fileprivate var successAction: DownloaderSuccessAction?
    fileprivate var failedAction: DownloaderFailedAction?
    fileprivate var _statusChangedAction: DownloaderStatusChangedAction?
    
    /// 下载会话
    fileprivate lazy var session: URLSession = {
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: .main)
        return session
    }()
    
    
    
    /// 下载逻辑
    /// - Parameters:
    ///   - url: url
    private func downLoad(url: URL){
        _status = .downLoading
        if self.downloadTask != nil {
            if url.absoluteString == self.url?.absoluteString {
                self.downloadTask!.resume()
                return
            }else {
                self.downloadTask?.cancel()
                self.downloadTask = nil
            }
        }
        self.url = url
        //请求
        let request = URLRequest(url: url)
        //下载任务
        self.downloadTask = self.session.downloadTask(with: request)
        //使用resume方法启动任务
        self.downloadTask!.resume()
    }
    
    /// 暂停
    private func pause() {
        if _status == .downLoading {
            self.downloadTask?.cancel(byProducingResumeData: { (data) in
                self.downloadTask = self.session.downloadTask(withResumeData: data!)
            })
        }
        _status = .pause
    }
    
    
    /// 取消
    private func cancel() {
        if self.downloadTask != nil {
            self.downloadTask?.cancel()
            self.downloadTask = nil
        }
        _status = .cancel
    }
    
    /// 处理特殊字符
    /// - Parameter string: 待处理的字符串
    /// - Returns: String
    private func escape(_ string: String) -> String {
        let batchSize = 1
        var index = string.startIndex
        var escaped = ""
        while index != string.endIndex {
            let startIndex = index
            let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
            let range = startIndex..<endIndex
            let substring = String(string[range])
            escaped += substring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? substring
            index = endIndex
        }
        return escaped
    }
    
}




// MARK: - 对外暴露接口
extension Downloader {
    
    /// 下载状态
    var status: DownloaderStatus {
        return _status
    }
    
    /// 下载状态改变后的回调
    var statusChangedAction: DownloaderStatusChangedAction? {
        get {
            return _statusChangedAction
        }
        set {
            _statusChangedAction = newValue
        }
    }
    
    
    /// 开始下载
    /// - Parameters:
    ///   - urlStr: 下载url
    ///   - progerss: 下载进度回调闭包
    ///   - complete: 下载完成
    ///   - failure: 下载失败
    public func startDownLoad(urlStr: String, progerss: @escaping DownloaderProgressAction, complete: @escaping DownloaderSuccessAction, failure: @escaping DownloaderFailedAction) {
        self.progressAction = progerss
        self.successAction = complete
        self.failedAction = failure
        let url = URL(string: escape(urlStr))
        if url == nil {
            _status = .failed
            failure(DownLoadError(code: .urlError, message: "url转换失败"))
            return
        }
        self.downLoad(url: url!)
    }
    
    
    /// 暂停下载
    public func pauseDownLoad() {
        self.pause()
    }
    
    /// 取消下载
    public func cancelDownload() {
        self.cancel()
    }
    
    /// 继续下载
    public func resumeDownload() {
        if self.downloadTask != nil {
            _status = .downLoading
            self.downloadTask!.resume()
        }
        else {
            _status = .failed
            failedAction?(DownLoadError(code: .noTask, message: "未找到继续下载的的任务"))
        }
    }
    
    
}


// MARK:URLSessionDownloadDelegate
extension Downloader: URLSessionDownloadDelegate, URLSessionDataDelegate {
    
    // 下载结束
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        _status = .success
        self.successAction?(location.path)
        self.url = nil
    }

    // 监听下载进度
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //获取进度
        self.downloadData.totalSize = totalBytesExpectedToWrite
        self.downloadData.currentSize = totalBytesWritten
        self.progressAction?(self.downloadData.totalSize, self.downloadData.currentSize, self.downloadData.progress)
        
        
    }

    // 下载偏移
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print("\(expectedTotalBytes) - \(fileOffset)")
        print("下载偏移")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            if _status == .pause || _status == .cancel {
                return
            }
            let e = error as! URLError
            print(e.code)
            print(error?.localizedDescription ?? "")
            let er = DownLoadError(code: .other, message: error!.localizedDescription)
            _status = .failed
            self.failedAction?(er)
        }
    }
    
    
}

struct DownloadData {
    var totalSize: Int64 = 0
    var currentSize: Int64 = 0
    var progress: Double {
        if currentSize == 0 || totalSize == 0 {
            return 0
        }
        var pro = Double(currentSize)/Double(totalSize)
        if pro > 1.0 {
            pro = 1.0
        }
        return pro
    }
    var path: String = ""
    
}

struct DownLoadError: Error {
    
    enum DownLoadErrorCode: Int {
        case nomal = 0     // 默认值
        case urlError      // url错误
        case noTask        // 未找到任务
        case other         // 其他错误
    }
    
    var code: DownLoadErrorCode = .nomal
    var message = ""
    
    
}
