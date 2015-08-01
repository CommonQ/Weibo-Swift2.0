//
//  HomeTableViewController.swift
//  菜菜微博
//
//  Created by 张鹏 on 15/7/27.
//  Copyright © 2015年 张鹏. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseViewController {
    
    var status:[WeiboStatus]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView?.setupInfo(true, imageName: "visitordiscover_feed_image_smallicon", desString: "关注一些人，回这里看看有什么惊喜")
        
        tableView.registerClass(WeiboStatusCell.self, forCellReuseIdentifier: "status")
        
        WeiboStatus.getWeiboStatus { [weak self] (weiboStatus, error) -> () in
            
            self?.status = weiboStatus
            
            self?.tableView.reloadData()
        }
        
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("status", forIndexPath: indexPath) as! WeiboStatusCell

        cell.weiboStatus = status![indexPath.row]
  
        return cell
    }




}
