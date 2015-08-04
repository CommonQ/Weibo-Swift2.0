//
//  HomeTableViewController.swift
//  菜菜微博
//
//  Created by 张鹏 on 15/7/27.
//  Copyright © 2015年 张鹏. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseViewController {
    
    var status:[WeiboStatus]? {
        didSet {
            
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !userAccount.isLogin {
        
            visitorView?.setupInfo(true, imageName: "visitordiscover_feed_image_smallicon", desString: "关注一些人，回这里看看有什么惊喜")
            
            return
        }
        
        tableView.registerClass(StatusNormalCell.self, forCellReuseIdentifier: WeiboStatusCellID.StatusNormalCell.rawValue)
        tableView.registerClass(StatusRetweetedCell.self, forCellReuseIdentifier: WeiboStatusCellID.StatusRetweetedCell.rawValue)
        
        WeiboStatus.getWeiboStatus { [weak self] (weiboStatus, error) -> () in
            
            self?.status = weiboStatus
            
        }
        
        
        tableView.estimatedRowHeight = 300
//        tableView.rowHeight = UITableViewAutomaticDimension
        
//        tableView.rowHeight = 500
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view 数据源方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return status?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let weiboStatus = status![indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(WeiboStatusCellID.cellID(weiboStatus), forIndexPath: indexPath) as! WeiboStatusCell

        cell.weiboStatus = weiboStatus
  
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let weiboStatus = status![indexPath.row]
        
        if let rowHeight = weiboStatus.rowHeight {
            return rowHeight
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(WeiboStatusCellID.cellID(weiboStatus)) as! WeiboStatusCell
        
        weiboStatus.rowHeight = cell.rowHeight(weiboStatus)

        return weiboStatus.rowHeight!
     
    }


}
