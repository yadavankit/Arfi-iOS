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


class CategoryRow: UITableViewCell {
   
   var garments : [UIImage] = []
   var isDone = false
    
 
 

    override func awakeFromNib() {
        super.awakeFromNib()
        getDataForCollectionViewCell()
    }
    
    func getDataForCollectionViewCell(){
        
     
        print("test")



      
       
      
    }
    
    func wq(){
        Alamofire.request(.GET, "http://192.168.182.60:7000/Garments/\(mainInstance.name)/uploaded/.jpg")
            .responseImage { response in
                debugPrint(response)
                
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                    
                    self.garments.append(image)
                    
                    
                }
                
        }
        
    }
    
 
   
    
    
    @IBOutlet var garmentDisplayCollectionViewCell: UICollectionView!
    
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CategoryRow : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
      
        
       self.garmentDisplayCollectionViewCell.registerNib((UINib.init(nibName: "garmentCell", bundle: nil)), forCellWithReuseIdentifier: "garmentCell")
       
        

        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("garmentCell", forIndexPath: indexPath) as! garmentCell
       // cell.garmentImage.image = garments[indexPath.row]
      
        return cell
    }

    
}

extension CategoryRow : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
}
}
