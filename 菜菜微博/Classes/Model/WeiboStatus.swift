//
//  weiboStatus.swift
//  菜菜微博
//
//  Created by 张鹏 on 15/8/1.
//  Copyright © 2015年 张鹏. All rights reserved.
//

import UIKit

class WeiboStatus: NSObject {
    
     /// 微博创建时间
    var created_at:String?
     /// 微博ID
    var id:Int = 0
     /// 微博信息内容
    var text:String?
     /// 微博来源
    var source:String?
     /// 配图数组
    var pic_urls:[[String:AnyObject]]?
    /// 用户信息模型
    var user:User?
    
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if key == "user" {
            
            if let userDic = value as? [String:AnyObject] {
                
                user = User(dict: userDic)
            }
            return
        }
        
        super.setValue(value, forKey: key)
        
    }
    
    class func getWeiboStatus(completion:(weiboStatus:[WeiboStatus]?,error:NSError?) -> ()) {
        
        NetworkTools.sharedNetworkToos.getWeiboStatus { (json, error) -> () in
            
            if error != nil {
                
                completion(weiboStatus: nil, error: error)
                return
            }
            
            if let array = json?["statuses"] as? [[String:AnyObject]] {
                
                var list = [WeiboStatus]()
                
                for dic in array {
                    
                    list.append(WeiboStatus(dict: dic))
                }
                
                completion(weiboStatus: list, error: nil)
                
            }
        }
    }
    
    
}
