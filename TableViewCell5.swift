//
//  TableViewCell5.swift
//  Udiva
//
//  Created by Aditya  Yadav on 03/07/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit

class TableViewCell5: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var myCollectionView: UICollectionView!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TableViewCell5 : UICollectionViewDataSource {
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        self.myCollectionView.registerNib((UINib.init(nibName: "CollectionViewCell5", bundle: nil)), forCellWithReuseIdentifier: "CollectionViewCell5")
        
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell5", forIndexPath: indexPath)
        
        
        cell.backgroundColor = UIColor.redColor()
        
        return cell
        
    }
    
    
    
    
}


extension TableViewCell5 : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding + 70
        let itemHeight = CGFloat(200)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
