//
//  Prepopulated.swift
//  Udiva
//
//  Created by Aditya  Yadav on 24/07/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import JKNotificationPanel

class Prepopulated: UIView {
    
    let panel : JKNotificationPanel = JKNotificationPanel()

    class func instanceFromNib() -> UIView {
 
        
        return UINib(nibName: "Prepopulated", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    @IBAction func releaseMe(sender: AnyObject) {
        GlobalVariables.startedUsingArfi = true
        
        
        print("Starteffdhhdsfhdfvhfdhjdjhd")
        
        
       self.getUserDetails()
        
      
        
    
        self.removeFromSuperview()
       
        
    }
    
    @IBOutlet var finalScreen: UIView!
    
    func removeMe(){
        self.removeFromSuperview()
        
    }
    
    func setup () {
        
        
        var number = 0
        
        while number < GlobalVariables.wardrobeUrl.count {
            
            if GlobalVariables.garmentInfo[number].containsString("BottomWear"){
                
                GlobalVariables.bottomwear.append(GlobalVariables.wardrobeUrl[number])
                
                
            } else {
                
                GlobalVariables.topwear.append(GlobalVariables.wardrobeUrl[number])
                
            }
            
            number += 1
            
            
        }
        
        
        
        
    }
    
    
    
    func getUserDetails(){
        
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://backend.arfi.in:4000/processing_panel/user_api?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    let nakedModelTop = json["naked_model_top"].string
                    let nakedModelBottom = json["naked_model_bottom"].string
                    let modelBody = json["model_body"].string
                    let numberOfGarments = json["number_of_garments"].string
                    let complexion = json["complexion"].string
                    let userName = json["user_name"].string
                    
                    GlobalVariables.nakedModelTop = nakedModelTop
                    GlobalVariables.nakedModelBottom = nakedModelBottom
                    GlobalVariables.modelBody = modelBody
                    GlobalVariables.numberOfGarments = numberOfGarments
                    GlobalVariables.complexion = complexion
                    GlobalVariables.userName = userName
                    
                    
                    
                    arrayCount = (json["user_garments"].count)
                    
                    var modelUrlCount = 0
                    var wardrobeUrlCount = 0
                    var garmentInfoCount = 0
                    var garmentStyleCount = 0
                    
                    
                    
                    while modelUrlCount  < arrayCount! {
                        if let model_url = json["user_garments"][modelUrlCount]["model_url"].string{
                            
                            GlobalVariables.modelUrl.append(model_url)
                            
                            modelUrlCount += 1
                            
                        }
                        
                    }
                    
                    while wardrobeUrlCount  < arrayCount! {
                        if let wardrobe_Url = json["user_garments"][wardrobeUrlCount]["wardrobe_url"].string{
                            
                            GlobalVariables.wardrobeUrl.append(wardrobe_Url)
                            
                            wardrobeUrlCount += 1
                            
                        }
                        
                    }
                    
                    
                    while garmentInfoCount  < arrayCount! {
                        if let garment_info = json["user_garments"][garmentInfoCount]["garment_info"].string{
                            
                            GlobalVariables.garmentInfo.append(garment_info)
                            
                            garmentInfoCount += 1
                            
                        }
                        
                    }
                    
                    
                    while garmentStyleCount  < arrayCount! {
                        if let garment_style = json["user_garments"][garmentStyleCount]["garment_style"].string{
                            
                            GlobalVariables.garmentStyle.append(garment_style)
                            
                            garmentStyleCount += 1
                            
                        }
                        
                    }
                    
                    
                    self.setup()
                    
                }
                
                }
        }
        
    
    @IBOutlet var prepopulatedBottom: NSLayoutConstraint!
    
    @IBOutlet var topTop: NSLayoutConstraint!
    @IBOutlet var prepopulatedTopSpace: NSLayoutConstraint!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    struct Model {
        var imageName : String
        var selectedState : Bool
        var isTapped : Bool
        var isSelected :Bool
        var cellLock : Bool
        
        init(imageName : String, selectedState : Bool = true , isTapped : Bool = false , isSelected : Bool = false , cellLock : Bool = false){
            self.imageName = imageName
            self.selectedState = selectedState
            self.isTapped = isTapped
            self.isSelected = isSelected
            self.cellLock = cellLock
        }
    }
    
    var model = [Model]()
    
    override func awakeFromNib() {
    
        
        super.awakeFromNib()
        for i in 0..<25 {
          
        model.append(Model(imageName: starterPack[i]))
            
        }
        
      
        
        self.prepopulatedCollectionView.allowsMultipleSelection = true
        
    }
    @IBOutlet var prepopulatedCollectionView: UICollectionView!
    
    @IBOutlet var collectionViewBottomPoint: NSLayoutConstraint!
  
    
    var selectedIndexPath: NSIndexPath?
    var testArray : [Int] = []
    
 
    var starterPack = ["1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9" , "10" , "11" , "12" , "13" ,"14" ,"15" , "16" ,"17" , "18" , "19" , "20", "21" ,"22" , "23" , "24" , "25"]
    
    var startePackNames = ["Beige Trouser" , "Black Crop Top" , "Black Jeggings" , "Aline Mini Skirt" , "Black Palazzo" , "Midi Pencil Skirt" , "Black Peplum Top" , "Black Shirt" , "Black Trouser" , "Black Tshirt" , "Blue Loose jeans" , "Blue denim Shirt" , "Blue Shirt" , "Blue Shorts" , "Brown  Trousers" , "Blue Jeans" , "Grey Trouser" , "Black Skinny Jeans" , "Blue Skinny Jeans" , "Black Tank Top" , "Loose Crop Top" , "White Peplum Top" , "White Shirt" , "White Tank Top" , "White Tshirt"]
    
    @IBOutlet var doneOutlet: UIButton!
    @IBOutlet var numberOfGarmentsLabel: UILabel!
    @IBAction func DoneAction(sender: AnyObject) {
     
         self.doneOutlet.hidden = true
        GlobalVariables.prepopulatedComplete = true
        
        let starterPackScreen = CreateModel.instanceFromNib()
        starterPackScreen.frame = CGRectMake(0 ,0 , self.frame.width , self.frame.height)
        self.addSubview(starterPackScreen)
     
        let triggerTime = (Int64(NSEC_PER_SEC) * 2)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
          
            self.finalScreen.hidden = false
        })
    }
    
}

extension Prepopulated : UICollectionViewDelegate{
    
   
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      
        return starterPack.count
        
    }
    
  
  
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        self.prepopulatedCollectionView.registerNib((UINib.init(nibName: "PrePopulatedCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "PrePopulatedCollectionViewCell")
     
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PrePopulatedCollectionViewCell", forIndexPath: indexPath) as! PrePopulatedCollectionViewCell
        
        let model = self.model[indexPath.item]
        cell.starterPackImage.image = UIImage(named:model.imageName)
        cell.tickmarkOutlet.hidden = model.selectedState
        cell.garmentDetailLabel.text = self.startePackNames[indexPath.row]
        
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

   
        if model[indexPath.item].cellLock == false{
            
              GlobalVariables.globalStarterPack.append(String(indexPath.row + 1) )
            
            model[indexPath.item].cellLock = true
        }
        
        print(GlobalVariables.globalStarterPack.count)
        print(GlobalVariables.globalStarterPack)
      
        self.numberOfGarmentsLabel.text = "\(GlobalVariables.globalStarterPack.count) outfits selected"
        
        
        if   model[indexPath.item].isSelected == true {
            
            model[indexPath.item].isTapped = false
        }
        
        
        model[indexPath.item].isTapped = true
      
        
        for i in 0..<25 {
          
            if model[indexPath.item].isTapped == false {

              model[i].selectedState = true

            }
        
        }
        model[indexPath.item].selectedState = false
        model[indexPath.item].isSelected = true
        self.prepopulatedCollectionView.reloadData()
        
     
        
        switch GlobalVariables.globalStarterPack.count {
        case 0:
             self.numberOfGarmentsLabel.text = "Tap on garment to add"
        case 1:
            
            self.numberOfGarmentsLabel.text = "\(GlobalVariables.globalStarterPack.count) outfit selected"
              self.doneOutlet.hidden = false
            numberOfGarmentsLabel.hidden = false

        default:
            self.numberOfGarmentsLabel.text = "\(GlobalVariables.globalStarterPack.count) outfits selected"
        }

    }

}


extension Prepopulated : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //device screen size
        let width = UIScreen.mainScreen().bounds.size.width
        //calculation of cell size
        return CGSize(width: ((width / 2) - 15)   , height: 190)
    }

    
}

