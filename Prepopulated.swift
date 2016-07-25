//
//  Prepopulated.swift
//  Udiva
//
//  Created by Aditya  Yadav on 24/07/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit

class Prepopulated: UIView {

    class func instanceFromNib() -> UIView {
        
        
        
        
        return UINib(nibName: "Prepopulated", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        
    }

    @IBOutlet var prepopulatedCollectionView: UICollectionView!
    
    @IBOutlet var collectionViewBottomPoint: NSLayoutConstraint!
  
    
    var selectedIndexPath: NSIndexPath?
    
 
    var starterPack = [UIImage(named:"1"),UIImage(named:"2"),UIImage(named:"3"),UIImage(named:"4"),UIImage(named:"5"),UIImage(named:"6"),UIImage(named:"7"),UIImage(named:"8"),UIImage(named:"9"),UIImage(named:"10"),UIImage(named:"11"),UIImage(named:"12"),UIImage(named:"13"),UIImage(named:"14"),UIImage(named:"15"),UIImage(named:"16"),UIImage(named:"17"),UIImage(named:"18"),UIImage(named:"19")]
    
    @IBOutlet var doneOutlet: UIButton!
    @IBOutlet var numberOfGarmentsLabel: UILabel!
    @IBAction func DoneAction(sender: AnyObject) {
    }
    
}

extension Prepopulated : UICollectionViewDelegate{
    
   
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      
        return starterPack.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        self.prepopulatedCollectionView.registerNib((UINib.init(nibName: "PrePopulatedCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "PrePopulatedCollectionViewCell")
        
        
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PrePopulatedCollectionViewCell", forIndexPath: indexPath) as! PrePopulatedCollectionViewCell
  
        
    cell.starterPackImage.image = self.starterPack[indexPath.row]
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
      
        GlobalVariables.globalStarterPack.append(String(indexPath.row))
        self.numberOfGarmentsLabel.text = "\(GlobalVariables.globalStarterPack.count) outfits selected"
        self.starterPack.removeAtIndex(indexPath.item)
        self.prepopulatedCollectionView.deleteItemsAtIndexPaths([indexPath])
        
        switch GlobalVariables.globalStarterPack.count {
        case 0:
             self.numberOfGarmentsLabel.text = "Tap on garment to add"
        case 1:
            
            self.numberOfGarmentsLabel.text = "\(GlobalVariables.globalStarterPack.count) outfit selected"
            
        case 5:
            
        self.doneOutlet.hidden = false
            
            
        default:
            self.numberOfGarmentsLabel.text = "\(GlobalVariables.globalStarterPack.count) outfits selected"
        }
        

        
        
        
 
    }
  
   
   
}


extension Prepopulated : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
     
        
        return CGSize(width: 150  , height: 150)
    }
}

