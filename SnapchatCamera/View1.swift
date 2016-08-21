//
//  View1.swift

//


import UIKit
import Alamofire
import AlamofireImage
import CircleSlider
import Kingfisher
import Haneke
import SwiftyJSON
import JKNotificationPanel
import Mixpanel
import SDWebImage




class View1: UIViewController  {
    
    
    var imageCache = [String : UIImage]()
    var imageCacheForModel = [String : UIImage] ()
    var modelCache = [String : UIImage] ()
    var modelCache2 = [String : UIImage] ()
    var safe = false
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


    @IBOutlet var clothesImage: UIImageView!
    @IBOutlet var botImageView: UIImageView!
    @IBOutlet var topImageView: UIImageView!



    @IBOutlet var label2: UILabel!
  
    @IBOutlet var whiteView: UIView!
    let panel : JKNotificationPanel = JKNotificationPanel()
    let newpanel : JKNotificationPanel = JKNotificationPanel()
    
    @IBOutlet var garmentTop: NSLayoutConstraint!
    var test = 6
    @IBOutlet var modelIndicator: UIActivityIndicatorView!

  
    @IBOutlet var tapToActivate: UIButton!
    @IBOutlet var doneOutlet: UIButton!

    @IBAction func reloadCellss(sender: AnyObject) {
        
        self.garmentCollectionView.reloadData()
        
    }
    @IBOutlet var background: QuestionsCollectionView!
    @IBOutlet var garmentCollectionView: UICollectionView!

    
//GAmify and Cupvoard
    
    @IBOutlet var GamifyView: UIView!
    @IBOutlet var CupboardView: UIView!
    @IBAction func GamifyNextButtonPressed(sender: AnyObject) {
        
        self.GamifyView.hidden = true
        self.GamifyView.removeFromSuperview()
        
        self.newpanel.timeUntilDismiss = 4
        self.newpanel.showNotify(withStatus: .SUCCESS, inView: self.view, message: "Swipe Left to know how to upload garments👈")
        
        GlobalVariables.seenGamify = true

        
    }
    
    @IBOutlet var CupboardNextButton: UIButton!
    @IBAction func CupboardNextButtonPressed(sender: AnyObject) {
        
        
        self.CupboardView.hidden = true
        self.CupboardView.removeFromSuperview()
        self.GamifyView.hidden = false
        self.view.bringSubviewToFront(self.GamifyView)
        

        
    }
    
    @IBOutlet var reloadCells: UIButton!

    @IBAction func refreshAction(sender: AnyObject) {
        
        self.whiteView.hidden = true
        self.tapToActivate.hidden = true
        self.label2.hidden = true
        self.view.addSubview(modelIndicator)
        self.modelIndicator.hidden = false
        self.modelIndicator.startAnimating()
        let triggerTime = (Int64(NSEC_PER_SEC) * 3)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            
            self.newpanel.timeUntilDismiss = 7
            self.newpanel.showNotify(withStatus: .SUCCESS, inView: self.view, message: "Swipe Left to know how to upload garments👈")
            self.panel.timeUntilDismiss = 3
            self.panel.showNotify(withStatus: .SUCCESS, inView: self.view, message: "Tap on the garments to see how they look on you 😊")
            print(GlobalVariables.globalTopAndBottom.count)
            

            self.garmentCollectionView.reloadData()
         
            
            
        })
        self.modelIndicator.stopAnimating()
        self.modelIndicator.hidden = true
        self.modelIndicator.removeFromSuperview()
 

    }

      var garments = [UIImage(named : "1Model"),UIImage(named : "2Model"),UIImage(named : "3Model"),UIImage(named : "4Model" ) , UIImage(named : "5Model" ) ]

    var garmentsOption = [UIImage(named : "1Garment"),UIImage(named : "2Garment"),UIImage(named : "3Garment"),UIImage(named : "4Garment") , UIImage(named : "5Garment" )]
    var condition = false
   
    @IBOutlet var bottomImageView: UIImageView!
    var topUploaded = false
   
    
    let kScreenSize = UIScreen.mainScreen().bounds.size
    
    override func viewDidAppear(animated: Bool) {
       
        
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 2)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            
                  self.startTimer()
   
        })
        
        
        
        //For Gamify View
        let newtriggerTime = (Int64(NSEC_PER_SEC) * 8)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, newtriggerTime), dispatch_get_main_queue(), { () -> Void in
            
            
            if(NSUserDefaults.standardUserDefaults().boolForKey("hasSeenGamify") == false)
            {
                
                self.CupboardView.hidden = false
                self.view.bringSubviewToFront(self.CupboardView)
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSeenGamify")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
            
            
        })
        
        
        
    }

    
    var timer: dispatch_source_t!
    
    func startTimer() {
        let queue = dispatch_queue_create("com.domain.app.timer", nil)
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC, 1 * NSEC_PER_SEC) // every 60 seconds, with leeway of 1 second
        dispatch_source_set_event_handler(timer) {
            
         
            
       
          
        }
        dispatch_resume(timer)
    }
    
    func stopTimer() {
        dispatch_source_cancel(timer)
        timer = nil
    }
    

    
  
    
   
    @IBOutlet var bg: UIImageView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
  
//         startTimer()
        let trigger = (Int64(NSEC_PER_SEC) * 4)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, trigger), dispatch_get_main_queue(), { () -> Void in
      
            if GlobalVariables.modelUrl.count > 0 {
               
                
               
            }
            
        })
        
       
       
         self.whiteView.hidden = true
        
        
         self.label2.hidden = true
         self.tapToActivate.hidden = true
        
        self.tapToActivate.layer.masksToBounds = true
        self.tapToActivate.layer.cornerRadius = 6

        let triggerTime = (Int64(NSEC_PER_SEC) * 4)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            
            if GlobalVariables.wardrobeUrl.count > 0 {
                
                self.whiteView.hidden = true
                self.label2.hidden = true
                self.tapToActivate.hidden = true
                
                
            } else {
                self.whiteView.hidden = false
                self.label2.hidden = false
                self.tapToActivate.hidden = false
                
            }
          
            
        })
        
        self.topImageView.image = UIImage(named: "fairtriangletop")
        self.bottomImageView.image = UIImage(named: "fairtrianglebottom")
        garmentCollectionView.delegate = self
        garmentCollectionView.dataSource = self
        
  
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
                    
                    
                    
                } else {
                    
                    
                    let starterPackScreen = Prepopulated.instanceFromNib()
                    starterPackScreen.frame = CGRectMake(0 ,0 , self.view.frame.width , self.view.frame.height)
                    self.view.addSubview(starterPackScreen)
                    
                    
                    
                    
                    
                    
                }
        }
        
        
        
        
    }


   
   
      
    
    
    
}

extension View1 : UICollectionViewDataSource {
    

    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
       
       return GlobalVariables.modelUrl.count
        
    }
    
   
    

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        self.garmentCollectionView.registerNib((UINib.init(nibName: "ModelGarmentCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "modelCell")
        
        
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("modelCell", forIndexPath: indexPath) as! ModelGarmentCollectionViewCell
        
        
        let urlString = GlobalVariables.wardrobeUrl[indexPath.row]
 
        
        if let image = imageCache[urlString]{
            
            cell.garmentImage.image = image
        } else {

            Alamofire.request(.GET, urlString)
                .responseImage { response in
                    
                    if let image = response.result.value {
                        

                        cell.garmentImage.image = image
                        self.imageCache[urlString] = image
                        print(urlString)
                        print("")
                    }
            }
            
        }
     
     
    return cell
    
    }
    

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
        KingfisherManager.sharedManager.cache.clearMemoryCache()
        KingfisherManager.sharedManager.cache.clearDiskCache()


        let urlString = GlobalVariables.modelUrl[indexPath.row]
        switch GlobalVariables.garmentInfo[indexPath.row] {
            
        case "TopWear":
            
            Mixpanel.mainInstance().track(event: "User Tapped on TopWear",
                                          properties: ["Cloth" : "TopWear"])
            Mixpanel.mainInstance().people.increment(property: "Tap Count",
                                                     by: 1)


            if GlobalVariables.garmentStyle[indexPath.row].containsString("Long") {
                
        
               topImageView.superview?.bringSubviewToFront(topImageView)
        
                
                if let image = imageCacheForModel[urlString]{
                    
                    
                    self.topImageView.image = image
                    self.modelIndicator.hidden = true
                    
                } else {
                     self.modelIndicator.hidden = false
                    
                    if let image = imageCacheForModel[urlString]{
                        
                        self.topImageView.image = image
                        
                    } else {
                        
                        print(urlString)
                        Alamofire.request(.GET, urlString)
                            .responseImage { response in
                                
                                if let image = response.result.value {
                                    
                                    self.topImageView.image = image
                                    self.imageCacheForModel[urlString] = image
                                     self.modelIndicator.hidden = true
                                    
                                }
                        }
                        
                    }
                    
                }
                
                print("IndexPath : \(indexPath.row) + The top is long")
                
            } else if GlobalVariables.garmentStyle[indexPath.row].containsString("Waist") {
               
                topImageView.superview?.bringSubviewToFront(topImageView)
                if let image = imageCacheForModel[urlString]{
                    
                    self.topImageView.image = image
                     self.modelIndicator.hidden = false
                    
                    self.modelIndicator.hidden = true
                    
                } else {
                    self.modelIndicator.hidden = false
                    
                    print(urlString)
                    Alamofire.request(.GET, urlString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                self.topImageView.image = image
                                self.imageCacheForModel[urlString] = image
                                 self.modelIndicator.hidden = true
                                
                            }
                    }
                    
                    
                }
                

                
                print("IndexPath : \(indexPath.row) + The top is waist")
                
                
            } else if GlobalVariables.garmentStyle[indexPath.row].containsString("Short"){
                
                bottomImageView.superview?.bringSubviewToFront(bottomImageView)
                if let image = imageCacheForModel[urlString]{
                    
                    self.topImageView.image = image
                    
                    self.modelIndicator.hidden = true
                    
                } else {
                    self.modelIndicator.hidden = false
                    
                    
                    print(urlString)
                    Alamofire.request(.GET, urlString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                self.topImageView.image = image
                                self.imageCacheForModel[urlString] = image
                                 self.modelIndicator.hidden = true
                                
                            }
                    }
                    
                    
                }
                

                print("IndexPath : \(indexPath.row) + The top is Short")
                
                
                
                
            }else if GlobalVariables.garmentStyle[indexPath.row].containsString("Crop"){
                
                bottomImageView.superview?.bringSubviewToFront(bottomImageView)
                if let image = imageCacheForModel[urlString]{
                    
                    self.topImageView.image = image
                    
                    self.modelIndicator.hidden = true
                    
                } else {
                    self.modelIndicator.hidden = false
                    
                    print(urlString)
                    Alamofire.request(.GET, urlString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                self.topImageView.image = image
                                self.imageCacheForModel[urlString] = image
                                 self.modelIndicator.hidden = true
                                
                            }
                    }
                    
                    
                }
                

                print("IndexPath : \(indexPath.row) + The top is Crop")
                

            }
            else
            {
              

                if let image = imageCacheForModel[urlString]{
                    
                    self.topImageView.image = image
                    
                    self.modelIndicator.hidden = true
                    
                } else {
                    self.modelIndicator.hidden = false
                    self.view.bringSubviewToFront(modelIndicator)
                    
                    print(urlString)
                    Alamofire.request(.GET, urlString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                self.topImageView.image = image
                                self.imageCacheForModel[urlString] = image
                                 self.modelIndicator.hidden = true
                                
                            }
                    }
                    
                    
                }

                self.view.bringSubviewToFront(self.topImageView)
                
            }
     
            
        case "BottomWear" :
            
            
            if let image = imageCacheForModel[urlString]{
                
                self.bottomImageView.image = image
                
                self.modelIndicator.hidden = true
                
            } else {
                
                self.modelIndicator.hidden = false
       
                self.modelIndicator.startAnimating()
                Alamofire.request(.GET, urlString)
                    .responseImage { response in
        
                        if let image = response.result.value {
                            
                            self.bottomImageView.image = image
                           self.imageCacheForModel[urlString] = image
                            
                            self.modelIndicator.stopAnimating()
                            self.modelIndicator.hidden = true
                        }
                }
             
                
            }

            
            Mixpanel.mainInstance().track(event: "User Tapped on BottomWear",
                                          properties: ["Cloth" : "BottomWear"])
            Mixpanel.mainInstance().people.increment(property: "Tap Count",
                                                     by: 1)


            
            
            
        default:
            print("Not found")
            print(GlobalVariables.globalGarmentType[indexPath.row])
        }
        

        
  
    }
    
    
   

}

extension View1 : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       
        return CGSize(width: 75, height: 75)
    }
}






