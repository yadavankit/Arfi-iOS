//
//  CategoryRow.swift
//  Udiva
//
//  Created by Aditya  Yadav on 27/06/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import FBSDKCoreKit
import Kingfisher


class CategoryRow: UITableViewCell  {
   
   var garments : [UIImage] = []
   var isDone = false
    var garmentSection : Int?
     var garmentss = [UIImage(named : "1"),UIImage(named : "2"),UIImage(named : "3"),UIImage(named : "4"),UIImage(named : "5")]
    
   var test = 5
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
 
 
    @IBOutlet var garmentDisplayCollectionViewCell: UICollectionView!
    
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func doThis(){
        
        self.garmentDisplayCollectionViewCell.reloadData()
    }

}

extension CategoryRow : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if GlobalVariables.globalTopwearModelUrl.count > 0 {
            
          return GlobalVariables.globalTopwearModelUrl.count
            
            
        } else {
            
            return 1
        }

    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
      
        
       self.garmentDisplayCollectionViewCell.registerNib((UINib.init(nibName: "garmentCell", bundle: nil)), forCellWithReuseIdentifier: "garmentCell")
        
 

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("garmentCell", forIndexPath: indexPath) as! garmentCell
        
        
        if GlobalVariables.globalTopwearModelUrl.count > 0 {
            print("This is the topwearUrl")
           
        
            let URLString = GlobalVariables.globalTopwearModelUrl[indexPath.row]
             print(URLString)
            let URL = NSURL(string:URLString)!
            cell.garmentImage.kf_setImageWithURL(URL)
        }
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 3)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            self.garmentDisplayCollectionViewCell.reloadData()
            
        })
      
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        

        dispatch_async(dispatch_get_main_queue(), {
            
            
            self.garmentDisplayCollectionViewCell.reloadData()
            
            
        })
        
    }

    
}





extension CategoryRow : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding + 70
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding) + 10
       
        return CGSize(width: itemWidth, height: itemHeight)
}
}
