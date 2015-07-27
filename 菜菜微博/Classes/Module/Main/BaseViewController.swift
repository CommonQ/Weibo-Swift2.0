//
//  BaseViewController.swift
//  菜菜微博
//
//  Created by 张鹏 on 15/7/27.
//  Copyright © 2015年 张鹏. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {
    
    var isLogin = false
    

    override func loadView() {
        
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    private func setupVisitorView() {
        
        view = VisitorLoginView()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
    }

}
