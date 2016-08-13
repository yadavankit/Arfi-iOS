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
        startTimer()
        
    }
    @IBOutlet var myCollectionView: UICollectionView!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
    
    var timer: dispatch_source_t!
    
    func startTimer() {
        let queue = dispatch_queue_create("com.domain.app.timer", nil)
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC, 1 * NSEC_PER_SEC) // every 60 seconds, with leeway of 1 second
        dispatch_source_set_event_handler(timer) {
            self.doThis()
        }
        dispatch_resume(timer)
    }
    
    func stopTimer() {
        dispatch_source_cancel(timer)
        timer = nil
    }
    
    
    func doThis(){
        
        self.myCollectionView.reloadData()
    }

    
}

extension TableViewCell2 : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
     return GlobalVariables.bottomwear.count
    
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        self.myCollectionView.registerNib((UINib.init(nibName: "CollectionViewCell2", bundle: nil)), forCellWithReuseIdentifier: "CollectionViewCell2")
    
        
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
        
       
        
        if GlobalVariables.bottomwear .count > 0 {
            
            let URLString = GlobalVariables.bottomwear [indexPath.row]
            let URL = NSURL(string:URLString)!
            cell.garmentImage.hnk_setImageFromURL(URL)
            
        }
        
        
    

        
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

