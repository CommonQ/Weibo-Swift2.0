//
//  OAuthViewController.swift
//  菜菜微博
//
//  Created by 张鹏 on 15/7/30.
//  Copyright © 2015年 张鹏. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController,UIWebViewDelegate {
    
    private lazy var loginView = UIWebView()
    
    override func loadView() {
        
        view = loginView
        loginView.delegate = self
        title = "登录微博"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.loadRequest(NSURLRequest(URL: NetworkTools.sharedNetworkToos.getAuthorizeURL()))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 关闭登录界面
    func close() {
        
//        let when = dispatch_time(DISPATCH_TIME_NOW, Int64(1*NSEC_PER_SEC))
//        
//        dispatch_after(when, dispatch_get_main_queue()) { () -> Void in
        
            SVProgressHUD.dismiss()
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
//        }
    }
    
    
    // MARK: - webView的代理方法实现
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlString = request.URL?.absoluteString
        
        if !urlString!.hasPrefix(NetworkTools.sharedNetworkToos.redirectUri) {
            return true
        }
        
        if let query = request.URL?.query where query.hasPrefix("code="){
            
            let code = query.substringFromIndex(advance(query.startIndex, "code=".characters.count))
            
            NetworkTools.sharedNetworkToos.getAccessToken(code, completion: { (json, error) -> () in
                
                userAccount(dict: json!).loadUserInfo({ (error) -> () in
                    
                    if error != nil {
                        print(error)
                    }
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(rootViewControllerDisplay, object: false)
                    
                    self.close()
                    
                })
      
            })
            
        } else {
            
            close()
        }
        
        return true
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
}
