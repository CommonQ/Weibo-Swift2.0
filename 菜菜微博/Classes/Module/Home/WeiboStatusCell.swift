//
//  weiboStatusCell.swift
//  菜菜微博
//
//  Created by 张鹏 on 15/8/1.
//  Copyright © 2015年 张鹏. All rights reserved.
//

import UIKit

class WeiboStatusCell: UITableViewCell {
    
    var weiboStatus:WeiboStatus? {
        didSet {
            
            spaceView.backgroundColor = UIColor(white: 0.90, alpha: 1.0)
            
            statusTopView.weiboStatus = weiboStatus
            
            mainTextLabel.text = weiboStatus?.text
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// cell准备UI里面的子控件
    private func prepareUI() {
        
        contentView.addSubview(statusTopView)
        contentView.addSubview(mainTextLabel)
        contentView.addSubview(statusBottomView)
        contentView.addSubview(spaceView)


        layout()
        
        
    }
    
    /// 添加自动布局约束
    private func layout() {
        
        statusTopView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: statusTopView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: statusTopView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: statusTopView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 70))
        
        mainTextLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: mainTextLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: statusTopView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: mainTextLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: mainTextLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: -8))
        
        statusBottomView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: statusBottomView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: mainTextLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: statusBottomView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: statusBottomView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 44))
        
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: spaceView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: statusBottomView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: spaceView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: spaceView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: spaceView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
        
    }
    
    // MARK: - 懒加载顶部视图,底部视图以及正文
    private lazy var spaceView:UIView = UIView()
    
    private lazy var statusTopView:StatusTopView = StatusTopView()
    
    private lazy var mainTextLabel:UILabel = {
        let mainTextLabel = UILabel(fontSize: 15, fontColor: UIColor.darkGrayColor())
        mainTextLabel.numberOfLines = 0
        
        return mainTextLabel
    }()
    
    private lazy var statusBottomView:StatusBottomView = StatusBottomView()
    

}
