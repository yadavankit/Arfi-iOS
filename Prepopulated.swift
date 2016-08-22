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
    var addedALready = false
    var topAdded = false
    var tshirtAdded = false
    var palazzoAdded = false
    var trouserAdded = false
    var shortsAdded = false
    var jeansAdded = false
    var capriAdded = false
    var leggingsAdded = false
    var cargoAdded = false
    var culottesAdded = false
    var skirtAdded = false
        var dressAdded = false

    class func instanceFromNib() -> UIView {
 
        
        return UINib(nibName: "Prepopulated", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    @IBAction func releaseMe(sender: AnyObject) {
        GlobalVariables.startedUsingArfi = true
          GlobalVariables.prepopulatedComplete = true
        
     
       self.getUserDetails()
        

        self.removeFromSuperview()
       
        
    }
    
    @IBOutlet var finalScreen: UIView!
    
    func removeMe(){
        self.removeFromSuperview()
        
    }
    
    func setup () {
        
        GlobalVariables.numberOfGarments = String(GlobalVariables.wardrobeUrl.count)
        
        
        var number = 0
        
        while number < GlobalVariables.wardrobeUrl.count {
            
            if GlobalVariables.garmentInfo[number].containsString("BottomWear"){
                
                GlobalVariables.bottomwear.append(GlobalVariables.wardrobeUrl[number])
                
                
            } else {
                
                GlobalVariables.topwear.append(GlobalVariables.wardrobeUrl[number])
                
            }
            
            number += 1
            
            
        }
        
        
        Alamofire.request(.GET, GlobalVariables.nakedModelTop!)
            .responseImage { response in
                debugPrint(response)
                
                
                if let image = response.result.value {
                    
                    GlobalVariables.nakedModelTopImage = image
                    GlobalVariables.ModelValuesAdded  = true
                    
                    
                }
        }
        
        
        Alamofire.request(.GET, GlobalVariables.nakedModelBottom!)
            .responseImage { response in
                debugPrint(response)
                
                
                if let image = response.result.value {
                    
                    GlobalVariables.nakedModelTopImage = image
                    GlobalVariables.ModelValuesAdded  = true
                    
                    
                }
        }

        
        
        var number2 = 0
        
        while number2 < GlobalVariables.wardrobeUrl.count {
            
            if GlobalVariables.garmentStyle[number2].containsString("Shirt") {
                
                
                
                if addedALready == false {
                    
                    GlobalVariables.CategorySection.append("Shirts")
                    
                    addedALready = true
                    
                }
                
            } else if GlobalVariables.garmentStyle[number2].containsString("Top") {
                
                
                
                if topAdded == false {
                    
                    GlobalVariables.CategorySection.append("Top")
                    topAdded = true
                    
                }
                
            } else if GlobalVariables.garmentStyle[number2].containsString("TShirt") {
                
                
                
                if tshirtAdded == false {
                    
                    GlobalVariables.CategorySection.append("TShirt")
                    tshirtAdded = true
                    
                }
                
            }else if GlobalVariables.garmentStyle[number2].containsString("Palazzo") {
                
                
                
                if palazzoAdded == false {
                    
                    GlobalVariables.CategorySection.append("Palazzo")
                    palazzoAdded = true
                    
                }
                
            }else if GlobalVariables.garmentStyle[number2].containsString("Trouser") {
                
                
                
                if trouserAdded == false {
                    
                    GlobalVariables.CategorySection.append("Trouser")
                    trouserAdded = true
                    
                }
                
            }else if GlobalVariables.garmentStyle[number2].containsString("Shorts") {
                
                
                
                if shortsAdded == false {
                    
                    GlobalVariables.CategorySection.append("Shorts")
                    shortsAdded = true
                    
                }
                
            }else if GlobalVariables.garmentStyle[number2].containsString("Jeans") {
                
                
                
                if jeansAdded == false {
                    
                    GlobalVariables.CategorySection.append("Jeans")
                    jeansAdded = true
                    
                }
                
            }else if GlobalVariables.garmentStyle[number2].containsString("Capri") {
                
                
                
                if capriAdded == false {
                    
                    GlobalVariables.CategorySection.append("Capri")
                    capriAdded = true
                    
                }
                
            }else if GlobalVariables.garmentStyle[number2].containsString("Leggings") {
                
                
                
                if leggingsAdded == false {
                    
                    GlobalVariables.CategorySection.append("Leggings")
                    leggingsAdded = true
                    
                }
                
            }else if GlobalVariables.garmentStyle[number2].containsString("Cargos") {
                
                
                
                if cargoAdded == false {
                    
                    GlobalVariables.CategorySection.append("Cargos")
                    cargoAdded = true
                    
                }
                
            }else if GlobalVariables.garmentStyle[number2].containsString("Culottes") {
                
                
                
                if culottesAdded == false {
                    
                    GlobalVariables.CategorySection.append("Culottes")
                    culottesAdded = true
                    
                }
                
            }else if GlobalVariables.garmentStyle[number2].containsString("Skirt") {
                
                
                
                if skirtAdded == false {
                    
                    GlobalVariables.CategorySection.append("Skirt")
                    skirtAdded = true
                    
                }
                
            }else if GlobalVariables.garmentStyle[number2].containsString("Dress") {
                
                
                if dressAdded == false {
                    
                    GlobalVariables.CategorySection.append("Dress")
                    dressAdded = true
                }
            }
            
            
            
            number2 += 1
            
        }
        
        var number3 = 0
        
        while number3 < GlobalVariables.wardrobeUrl.count {
            
            if GlobalVariables.garmentStyle[number3].containsString("Shirt") {
                
                
                GlobalVariables.shirtArray.append(GlobalVariables.wardrobeUrl[number3])
                
                
            } else if GlobalVariables.garmentStyle[number3].containsString("Top") {
                
                
                GlobalVariables.topArray.append(GlobalVariables.wardrobeUrl[number3])
                
                
            } else if GlobalVariables.garmentStyle[number3].containsString("TShirt") {
                
                
                GlobalVariables.tshirtArray.append(GlobalVariables.wardrobeUrl[number3])
                
                
                
            }else if GlobalVariables.garmentStyle[number3].containsString("Palazzo") {
                
                
                GlobalVariables.palazzoArray.append(GlobalVariables.wardrobeUrl[number3])
                
                
                
            }else if GlobalVariables.garmentStyle[number3].containsString("Trouser") {
                
                
                GlobalVariables.trouserArray.append(GlobalVariables.wardrobeUrl[number3])
                
                
            }else if GlobalVariables.garmentStyle[number3].containsString("Shorts") {
                
                GlobalVariables.shortsArray.append(GlobalVariables.wardrobeUrl[number3])
                
                
                
            }else if GlobalVariables.garmentStyle[number3].containsString("Jeans") {
                
                
                GlobalVariables.jeansArray.append(GlobalVariables.wardrobeUrl[number3])
                
                
                
                
            }else if GlobalVariables.garmentStyle[number3].containsString("Capri") {
                
                
                
                GlobalVariables.capriArray.append(GlobalVariables.wardrobeUrl[number3])
                
                
            }else if GlobalVariables.garmentStyle[number3].containsString("Leggings") {
                
                
                
                GlobalVariables.leggingArray.append(GlobalVariables.wardrobeUrl[number3])
                
                
            }else if GlobalVariables.garmentStyle[number3].containsString("Cargos") {
                
                
                GlobalVariables.cargoArray.append(GlobalVariables.wardrobeUrl[number3])
                
                
                
            }else if GlobalVariables.garmentStyle[number3].containsString("Culottes") {
                
                
                GlobalVariables.culotteArray.append(GlobalVariables.wardrobeUrl[number3])
                
                
                
                
            }else if GlobalVariables.garmentStyle[number3].containsString("Skirt") {
                
                
                
                GlobalVariables.skirtArray.append(GlobalVariables.wardrobeUrl[number3])
                
                
            }else if GlobalVariables.garmentStyle[number3].containsString("Dress") {
                
                GlobalVariables.dressArray.append(GlobalVariables.wardrobeUrl[number3])
                
            }
            
            
            
            
            number3 += 1
            
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
                    
                    
                    
                    
                    let is_on_level = json["is_on_level"].string
                    let first_level_status = json["first_level_status"].string
                    let second_level_status = json["second_level_status"].string
                    let third_level_status = json["third_level_status"].string
                    let camera_uploads = json["camera_uploads"].string
                    
                    GlobalVariables.is_on_level = is_on_level
                    GlobalVariables.camera_uploads = camera_uploads
                    GlobalVariables.first_level_status = first_level_status
                    GlobalVariables.second_level_status = second_level_status
                    GlobalVariables.third_level_status = third_level_status

                    
                    
                    
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

