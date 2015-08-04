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
        
        prepareTableView()
        
        loadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 准备tableView的UI和属性
    private func prepareTableView() {
        
        refreshControl = StatusRefreshControl()
        
        refreshControl?.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        
        tableView.registerClass(StatusNormalCell.self, forCellReuseIdentifier: WeiboStatusCellID.StatusNormalCell.rawValue)
        tableView.registerClass(StatusRetweetedCell.self, forCellReuseIdentifier: WeiboStatusCellID.StatusRetweetedCell.rawValue)
        
        tableView.estimatedRowHeight = 300
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
    }
    
    /// 判断是否是上拉刷新
    private var pullupRefresh = false
    
    /// 刷新微博数据
    func loadData() {
        
        refreshControl?.beginRefreshing()
        
        var since_id = status?.first?.id ?? 0
        var max_id = 0
        
        if pullupRefresh == true {
            
            since_id = 0
            max_id = status?.last?.id ?? 0
        }

        WeiboStatus.getWeiboStatus(since_id, max_id: max_id) { (weiboStatus, error) -> () in
            
            if error != nil {
                print(error)
                return
            }
            
            self.refreshControl?.endRefreshing()
            
            if since_id > 0 {
                
                self.status = weiboStatus! + self.status!
                
            } else if max_id > 0 {
                
                self.status = self.status! + weiboStatus!
                
                self.pullupRefresh = false
                
            } else {
                
                self.status = weiboStatus
            }
        }

    }

    // MARK: - TableView 数据源方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return status?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let weiboStatus = status![indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(WeiboStatusCellID.cellID(weiboStatus), forIndexPath: indexPath) as! WeiboStatusCell
        
        if status!.count - 1 == indexPath.row {
            
            pullupRefresh = true
            
            loadData()
        }

        cell.weiboStatus = weiboStatus
  
        return cell
    }
    
    /// 计算cell的行高,并缓存
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
