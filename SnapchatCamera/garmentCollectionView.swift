//
//  garmentCollectionView.swift
//  Udiva
//
//  Created by Aditya  Yadav on 23/06/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import Foundation
import UIKit

class garmentCollectionView : UIView , UICollectionViewDataSource , UICollectionViewDelegate{
    
    
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "garmentCollectionView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    let reuseIdentifier = "cell"
    
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! garmentCollectionViewCell
        

        cell.garmentLabel.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor.yellowColor()
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        print("You selected cell #\(indexPath.item)!")
    }
    
    
    
}