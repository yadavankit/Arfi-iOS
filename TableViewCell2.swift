//
//  TableViewCell2.swift
//  Udiva
//
//  Created by Aditya  Yadav on 01/07/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit

class TableViewCell2: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBOutlet var myCollectionView: UICollectionView!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
}

extension TableViewCell2 : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if GlobalVariables.globalTopwearModelUrl.count > 0 {
            
            return GlobalVariables.globalTopwearModelUrl.count
            
        } else {
            
            return 1
        }
    
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        self.myCollectionView.registerNib((UINib.init(nibName: "CollectionViewCell2", bundle: nil)), forCellWithReuseIdentifier: "CollectionViewCell2")
    
        
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
        

        
        if GlobalVariables.globalTopwearModelUrl.count > 0 {
            print(GlobalVariables.globalTopwearModelUrl.count)
            print(GlobalVariables.globalTopwearModelUrl[indexPath.row] + "This is it")
            
            let URLString = GlobalVariables.globalTopwearModelUrl[indexPath.row]
           let URL = NSURL(string:URLString)!
          cell.garmentImage.hnk_setImageFromURL(URL)
            
        } else {
            
            cell.garmentImage.image = UIImage(named: "Placeholder")
            
        }
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 3)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
           
            self.myCollectionView.reloadData()
            
        })
        

        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath.row)
        
        
    }
    
    
}



extension TableViewCell2 : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding + 70
        let itemHeight = CGFloat(185.5)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

