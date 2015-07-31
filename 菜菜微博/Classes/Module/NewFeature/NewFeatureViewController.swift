//
//  NewFeatureViewController.swift
//  菜菜微博
//
//  Created by 张鹏 on 15/7/31.
//  Copyright © 2015年 张鹏. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class NewFeatureViewController: UICollectionViewController {
    
    private var imageCount = 4
    
    let layout = NewFeatureLayout()
    
    init() {
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return imageCount
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewFeatureCell
        
        cell.imageCount = imageCount
    
        return cell
    }
    
    
    

}

class NewFeatureCell:UICollectionViewCell {
    
    private var image:UIImageView?
    private var imageCount: Int?  {
        didSet {
            
            image?.image = UIImage(named: "")
 
        }
    }
    
    
    
}


class NewFeatureLayout:UICollectionViewLayout {
    
    
}


