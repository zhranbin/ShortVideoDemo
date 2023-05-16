//
//  WKWebView+JSHandler.swift
//  TestProject
//
//  Created by mac on 2022/2/9.
//

import Foundation
import WebKit


private var jsHandlerDicKey: Void?
private var WKWebViewNavigationDelegateKey: Void?
typealias WKWebViewJSResponseCallBack = (Any) -> Void
typealias WKWebViewJSResultHandler = (Any, WKWebViewJSResponseCallBack) -> Void


extension WKWebView {
    
    func regist(_ jsAction: String, handler: @escaping WKWebViewJSResultHandler) {
        if self.jsHandlerDic == nil {
            self.jsHandlerDic = [:]
        }
        self.jsHandlerDic?.updateValue(handler, forKey: jsAction)
    }
    
    func call<T: Codable>(_ jsAction: String, data: T, completionHandler: ((Any?, Error?) -> Void)? = nil) {
        var action: String = "\(jsAction)()"
        if let jsonData = try? JSONEncoder().encode(data) {
            if let jsonString = String.init(data: jsonData, encoding: .utf8) {
                print("web.call - \(jsAction) - \(jsonString)")
                action = "\(jsAction)(\(jsonString))"
            }
        }
        self.evaluateJavaScript(action, completionHandler: completionHandler)
    }
    
    
    private var jsHandlerDic: [String: WKWebViewJSResultHandler]? {
        get {
            return objc_getAssociatedObject(self, &jsHandlerDicKey) as? [String: WKWebViewJSResultHandler]
        }
        set {
            /// 判断是否已经设置了监听代理
            if self.wkWebViewNavigationDelegate == nil {
                self.wkWebViewNavigationDelegate = WKWebViewNavigationDelegate()
                self.wkWebViewNavigationDelegate?.navigationDelegate = self.navigationDelegate
                self.navigationDelegate = self.wkWebViewNavigationDelegate
                // 利用kvo监听导航设置代理
                self.addObserver(self, forKeyPath: "navigationDelegate", options: [.new, .old], context: nil)
            }
            guard let dic = newValue else { return }
            dic.forEach { (key, _) in
                self.configuration.userContentController.removeScriptMessageHandler(forName: key)
                self.configuration.userContentController.add(self, name: key)
            }
            objc_setAssociatedObject(self, &jsHandlerDicKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private var wkWebViewNavigationDelegate: WKWebViewNavigationDelegate? {
        get {
            return objc_getAssociatedObject(self, &WKWebViewNavigationDelegateKey) as? WKWebViewNavigationDelegate
        }
        set {
            objc_setAssociatedObject(self, &WKWebViewNavigationDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    // kvo响应方法
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //拦截 WKNavigationDelegate
        if let new = change?[NSKeyValueChangeKey.newKey], keyPath == "navigationDelegate" {
            if !(new is WKWebViewNavigationDelegate)  {
                self.navigationDelegate = self.wkWebViewNavigationDelegate
                self.wkWebViewNavigationDelegate?.navigationDelegate = new as? WKNavigationDelegate
            }
        }
    }
    
}

extension WKWebView: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let handler = self.jsHandlerDic?[message.name] {
            let callBack: WKWebViewJSResponseCallBack = { data in
                //
            }
            handler(message.body, callBack)
        }
        
    }
}

/// 拦截 WKNavigationDelegate 类
class WKWebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    
    weak open var navigationDelegate: WKNavigationDelegate?
    
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let navDelegate = self.navigationDelegate, navDelegate.webView?(webView, decidePolicyFor: navigationAction, decisionHandler: decisionHandler) != nil {
            return
        }
        decisionHandler(.allow)
    }
    


    
    
    @available(iOS 13.0, *)
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        if let navDelegate = self.navigationDelegate, navDelegate.webView?(webView, decidePolicyFor: navigationAction, preferences: preferences, decisionHandler: decisionHandler) != nil {
            return
        }
        decisionHandler(.allow, WKWebpagePreferences())
    }

    

    
    /** @abstract Decides whether to allow or cancel a navigation after its
     response is known.
     @param webView The web view invoking the delegate method.
     @param navigationResponse Descriptive information about the navigation
     response.
     @param decisionHandler The decision handler to call to allow or cancel the
     navigation. The argument is one of the constants of the enumerated type WKNavigationResponsePolicy.
     @discussion If you do not implement this method, the web view will allow the response, if the web view can show it.
     */
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let navDelegate = self.navigationDelegate, navDelegate.webView?(webView, decidePolicyFor: navigationResponse, decisionHandler: decisionHandler) != nil {
            
        }
        decisionHandler(.allow)
    }
    

    
    
    
    
    
    
    
    
    
    @available(iOS 8.0, *)
    /// 当WebView开始加载Web内容时触发；
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if let navDelegate = self.navigationDelegate {
            navDelegate.webView?(webView, didStartProvisionalNavigation: navigation)
        } else {
        }
    }
    
    @available(iOS 8.0, *)
    /// 当Web视图收到服务器重定向时调用；
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if let navDelegate = self.navigationDelegate {
            navDelegate.webView?(webView, didReceiveServerRedirectForProvisionalNavigation: navigation)
        } else {
        }
    }

    @available(iOS 8.0, *)
    /// 当Web视图正在加载内容时发生错误时调用;
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        if let navDelegate = self.navigationDelegate {
            navDelegate.webView?(webView, didFailProvisionalNavigation: navigation, withError: error)
        } else {
        }
    }

    @available(iOS 8.0, *)
    /// 当WebView开始接受web内容时触发；
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if let navDelegate = self.navigationDelegate {
            navDelegate.webView?(webView, didCommit: navigation)
        }
    }

    @available(iOS 8.0, *)
    /// 导航完成时调用；
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("加载完成")
        self.navigationDelegate?.webView?(webView, didFinish: navigation)
        RBLoading.hiddenLoding()
    }

    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if let navDelegate = self.navigationDelegate {
            navDelegate.webView?(webView, didFail: navigation, withError: error)
        } else {
        }
    }

    @available(iOS 9.0, *)
    /// WebView的Web内容处理终止时调用；
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        if let navDelegate = self.navigationDelegate {
            navDelegate.webViewWebContentProcessDidTerminate?(webView)
        } else {
        }
    }

//    @available(iOS 15.0, *)
//    func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
//        if let navDelegate = self.navigationDelegate {
//            navDelegate.webView?(webView, navigationAction: navigationAction, didBecome: download)
//        } else {
//        }
//    }
//
//    @available(iOS 15.0, *)
//    func webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, didBecome download: WKDownload) {
//        if let navDelegate = self.navigationDelegate {
//            navDelegate.webView?(webView, navigationResponse: navigationResponse, didBecome: download)
//        } else {
//        }
//    }
}


struct WKWebViewJSHandlerModel {
    var name: String = ""
    var handler: WKWebViewJSResultHandler? = nil
}
