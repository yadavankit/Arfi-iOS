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
    var safe = false

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
            
 

        })
    }
    @IBAction func showprepopulated(sender: AnyObject) {

        let test = Prepopulated.instanceFromNib()
        test.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.view.addSubview(test)

    }
    
    var timer: dispatch_source_t!
    
    func startTimer() {
        let queue = dispatch_queue_create("com.domain.app.timer", nil)
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC, 1 * NSEC_PER_SEC) // every 60 seconds, with leeway of 1 second
        dispatch_source_set_event_handler(timer) {
            
          self.garmentCollectionView.reloadData()
          
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
      
            if GlobalVariables.globalTopAndBottom.count > 0 {
                
               self.showTheModel()
               self.checkForPreviousModel()
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


    
    func checkForPreviousModel(){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            
            var arrayCount : Int?
            
            Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/model_status?user_id=\(GlobalVariables.globalFacebookId!)")
                .responseJSON { response in
                    if let jsonValue = response.result.value {
                        let json = JSON(jsonValue)
                        
                        print(jsonValue)
                        print("JSON VALUE")
                        
                        
                        
                        arrayCount = (json["model"].count)
                        // NSUserDefaults.standardUserDefaults().setObject(arrayCount!, forKey: "section")
                        
                        
                        var number = 0
                        
                        
                        while number  < arrayCount! {
                            if let quote = json["model"][number]["model_status"].string{
                                
                                print(quote)
                                GlobalVariables.modelStatus = quote
                                number += 1
                                print(number)
                            }
                            
                            
                            
                            if number == arrayCount! {
                                
                                
                                GlobalVariables.globalSafeToFetch = true
                                
                                
                                
                                
                                
                            }
                            
                        }
                        
                        
                        
                    }}
            
            
            
            
        })
        
        
        
        
    }
    
    func getProperImages(){
        
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_categorized_garments?user_id=\(GlobalVariables.globalFacebookId!)&category=TopWear")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
                    
                    arrayCount = (json["garments"].count)
                    print(arrayCount)
                    print("This is arrayCount")
                    NSUserDefaults.standardUserDefaults().setObject(arrayCount!, forKey: "section")
                    
                    
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["wardrobe_url"].string{
                            print(json["garments"][0]["wardrobe_url"].string)
                            
                            GlobalVariables.globalTopwearModelUrl.append(quote)
                            
                            
                            number += 1
                            print(number)
                        }
                        
                        
                        
                        if number == arrayCount! {
                            
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                            print("Now TrUE")
                            
                        }
                        
                    }
                    
                }}
        
        
   
        
        
        
        
    }

    
    
    
    func getModelUrlForView1(){
        
        
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
                    
                    arrayCount = (json["garments"].count)
                    GlobalVariables.finalGarmentCount = arrayCount!
                    
                    print(arrayCount!)
                    
                    
                    
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["model_url"].string{
                            
                            
                            GlobalVariables.globalModelUrl.append(quote)
                            
                            
                            
                            number += 1
                            print(number)
                        }
                        
                        
                        
                        if number == arrayCount! {
                            
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                          self.getGarmentInformation()
                            
                            
                        }
                        
                    }
                    
                    
                    
                }}
        
    }




    @IBAction func doThis (sender : AnyObject) {
        
        print("doin it")
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:8000/GarmentUpload/receive")
            .responseImage { response in
                debugPrint(response)
                
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                
                if let image = response.result.value {
                    print("image downloaded: \(image)")
               
                    if self.topUploaded == false {
                        
                        self.topImageView.image = image
                        self.topUploaded = true
                    } else {
                        
                        self.botImageView.image = image
                    }
  
          }
 
    }

        
    }
    
    
   
    @IBAction func doneAction(sender: AnyObject) {
        
        
        print("Seen Complexion")
        print(GlobalVariables.seenComplexion)
        
       
     
        safe = true
//     
    let current_user_id = GlobalVariables.globalFacebookId!
    let bust = modelObject.bust
    let hip = modelObject.hip
    let waist = modelObject.waist
    let height = modelObject.height
    let complexion = modelObject.complexion
    NSUserDefaults.standardUserDefaults().setObject(current_user_id, forKey: "usr_id")
    NSUserDefaults.standardUserDefaults().setObject(bust, forKey: "bust")
    NSUserDefaults.standardUserDefaults().setObject(hip, forKey: "hip")
    NSUserDefaults.standardUserDefaults().setObject(waist, forKey: "waist")
    NSUserDefaults.standardUserDefaults().setObject(height, forKey: "height")
    NSUserDefaults.standardUserDefaults().setObject(complexion, forKey: "complexion")
        
 
      
       var garmentSelectedString = "["
        for garment in GlobalVariables.globalStarterPack
        {
            print("selected garmenst")
            garmentSelectedString = garmentSelectedString + String(garment) + ","
        }
        garmentSelectedString = garmentSelectedString.substringToIndex(garmentSelectedString.endIndex.predecessor())
        garmentSelectedString = garmentSelectedString + "]"
        
      print(GlobalVariables.globalTopAndBottom.count)

       Alamofire.request(.POST, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/populate?user_id=\(GlobalVariables.globalFacebookId!)&garments_selected=\(garmentSelectedString)&user_name=\(GlobalVariables.globalUserName!.componentsSeparatedByString(" ")[0])&bust=\(bust)&hip=\(hip)&waist=\(waist)&height=\(height)&complexion=\(complexion)")
          .validate()
          .responseJSON { response in
                print(response)
            
                print("Model Garment in saved on Server")
                self.panel.timeUntilDismiss = 4
//                let mixpanel = Mixpanel.sharedInstance()
//                let properties = ["LoginCompleted": "Done"]
//                mixpanel.track("Completed Model", properties: properties)
            
            
            let triggerTime = (Int64(NSEC_PER_SEC) * 6)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
              
                
                
                
                self.panel.showNotify(withStatus: .SUCCESS, inView: self.view, message: "Tap on garments to see how they look on you 👍")
                
              
                
            })
            
//            self.panel.timeUntilDismiss = 6
            let taptriggerTime = (Int64(NSEC_PER_SEC) * 12)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, taptriggerTime), dispatch_get_main_queue(), { () -> Void in
                
                
                
                
                self.panel.showNotify(withStatus: .SUCCESS, inView: self.view, message: "Swipe Left 👈 and tap on Circle to know how you can upload more garments")
                
                
                
            })
    
        
        
         NSUserDefaults.standardUserDefaults().setObject("true", forKey: "freshLogin")
   
        
       self.getGarmentInformation()
       self.getWardrobeStyle()
        self.getModelUrlForView1()
       self.garmentCollectionView.reloadData()
        
        let set = settingWardrobe.instanceFromNib()
        set.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)

        self.view.addSubview(set)
        
        
    }

    }
    
    func getBottomWearImages(){
        
        
        
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_categorized_garments?user_id=\(GlobalVariables.globalFacebookId!)&category=BottomWear")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
                    
                    arrayCount = (json["garments"].count)
                    print(arrayCount)
                    print("This is arrayCount")
                    
                    
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["wardrobe_url"].string{
                            print(json["garments"][0]["wardrobe_url"].string)
                            
                            GlobalVariables.globalBottomWardrobe.append(quote)
                            
                            
                            number += 1
                            print("BottomWardrobe is here")
                        }
                        
                        
                        
                        if number == arrayCount! {
                            
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                            print("Now TrUE")
                            
                        }
                        
                    }
                    
                }}
        
        
        
        
        
    }
    

    
    var once : Bool = false
    
    func getGarmentInformation(){
        
        print("GETTING GARMENT INFORMATION")
        
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
                    arrayCount = (json["garments"].count)
                    
                    
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["garment_style"].string{
                            
                            
                            GlobalVariables.garmentInformation.append(quote)
                            print(GlobalVariables.garmentInformation[number])
                            
                            
                            
                            number += 1
                            print("garment info Added \(number)")
                        }
                        
                        
                        
                        if number == arrayCount! {
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                            
                   
                           self.getModelWardrobeImages()
                        }
                    }
                    
                    
                }}
    }
    
    func getModelWardrobeImages(){ //VIEW 1
        
        var arrayCount : Int?
        
        
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
                    
                    
                    arrayCount = (json["garments"].count)
                    GlobalVariables.finalGarmentCount = arrayCount!
                    
               
                    
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["wardrobe_url"].string{
                            
                            
                            GlobalVariables.globalTopAndBottom.append(quote)
                            print(GlobalVariables.globalTopAndBottom.count)

                            
                           
             
                            
                            number += 1
                            print(number)
                        }
                        
                        
                        
                        if number == arrayCount! {
                    
                        
             
                             self.showTheModel()
                  
                            
                            
                        }
                        
                    }
                    
                    
                }}
    
        
        
    }
    
    func getWardrobeStyle(){
        
        var arrayCount : Int?
        
        
    
        
            self.panel.showNotify(withStatus: .SUCCESS, inView: self.view , message: "Tap on garments to see how they look on you 👍")
        
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
           
                    arrayCount = (json["garments"].count)
                    
               
                    
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["garment_info"].string{
                            
                            
                            GlobalVariables.globalGarmentType.append(quote)
                            
                            print(GlobalVariables.globalGarmentType)
                            
                            
                            number += 1
                          
                        }
                        
                        
                        
                        if number == arrayCount! {
                            
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                      self.getModelUrlForView1()
                            
                            
                        }
                        
                    }
                    
                    
                    
                }}
        
    }
    
    




    
    func getProcessedImageData(){
        

        
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
                    
                    arrayCount = (json["garments"].count)
                    
                    
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        let quote = json["garments"][1]["processed"].stringValue
                        
                      
                        
                        GlobalVariables.processedImageStatus.append(quote)
                        
                        number += 1
          
                        
                        
                        
                        
                        if number == arrayCount! {
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                           
                        }
                    }
                }}
        
    }
    



    
    func showTheModel(){
        
 
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    print(json)
                    
                    arrayCount = (json["garments"].count)
                    GlobalVariables.finalGarmentCount = arrayCount!
                    
                    print(arrayCount!)
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["model_body_type"].string{
                            
                            GlobalVariables.modelBodyType = quote
                         
                    
                            
                            number += 1
                            print(number)
                        }
 
                        if number == arrayCount! {
                            
                            
      
                            self.getComplexion()
                        

                        }
                        
                    }
   
                }}
  
    }
    
    func getComplexion(){
        
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
                    
                    arrayCount = (json["garments"].count)
                    GlobalVariables.finalGarmentCount = arrayCount!
                    
                    
                    print(arrayCount!)
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["other_info"].string{
                            
                            GlobalVariables.complexionType = quote
                            
                            
                            
                            number += 1
             
                        }
                        
                        
                        
                        if number == arrayCount! {
                            
                            
                            self.showComplexion()
                            
                            
                        }
                        
                    }
 
                }}

    }
    
    
    func showComplexion(){
        
        
        if GlobalVariables.complexionType == "Medium" && GlobalVariables.modelBodyType == "Triangle" {
            
            self.topImageView.image = UIImage(named: "mediumtriangletop")
            self.bottomImageView.image = UIImage(named: "mediumtrianglebottom")
          
            
            
            print("triangle")
            
        }else if GlobalVariables.complexionType == "Fair" && GlobalVariables.modelBodyType == "Triangle" {
            
            self.topImageView.image = UIImage(named: "fairtriangletop")
            self.bottomImageView.image = UIImage(named: "fairtrianglebottom")
            
    
            
            
             print("triangle")
            
            
        } else if GlobalVariables.complexionType == "Dark" && GlobalVariables.modelBodyType == "Triangle" {
            
            self.topImageView.image = UIImage(named: "darktriangletop")
            self.bottomImageView.image = UIImage(named: "darktrianglebottom")
            

            
             print("triangle")
            
        }else if GlobalVariables.complexionType == "Medium" && GlobalVariables.modelBodyType == "Inverted Triangle" {
            
            self.topImageView.image = UIImage(named: "mediuminvertedtriangletop")
            self.bottomImageView.image = UIImage(named: "mediuminvertedtrianglebottom")
   
             print("invertriangle")
            
            
        } else if GlobalVariables.complexionType == "Fair" && GlobalVariables.modelBodyType == "Inverted Triangle" {
            self.topImageView.image = UIImage(named: "fairinvertedtriangletop")
            self.bottomImageView.image = UIImage(named: "fairinvertedtrianglebottom")
      

                print("invertriangle")
            
            
        }else if GlobalVariables.complexionType == "Dark"  && GlobalVariables.modelBodyType == "Inverted Triangle" {
            self.topImageView.image = UIImage(named: "darkinvertedtriangletop")
            self.bottomImageView.image = UIImage(named: "darkinvertedtrianglebottom")
            
      
            
                print("invertriangle")
            
        }else if GlobalVariables.complexionType == "Medium" && GlobalVariables.modelBodyType == "Hour Glass"{
            self.topImageView.image = UIImage(named: "mediumHourglasstop")
            self.bottomImageView.image = UIImage(named: "mediumHourglassbottom")
            
       
            
                print("hour")
            
            
        } else if GlobalVariables.complexionType == "Fair" && GlobalVariables.modelBodyType == "Hour Glass" {
            
            self.topImageView.image = UIImage(named: "fairHourglasstop")
            self.bottomImageView.image = UIImage(named: "fairHourglassbottom")
            

            
                print("hour")
            
        } else if GlobalVariables.complexionType == "Dark" && GlobalVariables.modelBodyType == "Hour Glass" {
            
            self.topImageView.image = UIImage(named: "darkHourglasstop")
            self.bottomImageView.image = UIImage(named: "darkHourglassbottom")
            
            
                print("hour")
            
        }else if GlobalVariables.complexionType == "Medium" && GlobalVariables.modelBodyType == "Rectangular" {
            self.topImageView.image = UIImage(named: "mediumrectangletop")
            self.bottomImageView.image = UIImage(named: "mediumrectanglebottom")
            
            
            
            
                print("rect")
            
        } else if GlobalVariables.complexionType == "Fair" && GlobalVariables.modelBodyType == "Rectangular" {
            
            self.topImageView.image = UIImage(named: "fairrectangletop")
            self.bottomImageView.image = UIImage(named: "fairrectanglebottom")
        
                print("rect")
            
            
        }else if GlobalVariables.complexionType == "Dark" && GlobalVariables.modelBodyType == "Rectangular" {
            
            self.topImageView.image = UIImage(named: "darkrectangletop")
            self.bottomImageView.image = UIImage(named: "darkrectanglebottom")
            
        
            
                print("rect")
            
            
        }else if GlobalVariables.complexionType == "Medium" && GlobalVariables.modelBodyType == "Oval" {
            self.topImageView.image = UIImage(named: "mediumOvaltop")
            self.bottomImageView.image = UIImage(named: "mediumOvalbottom")
            
           
                print("oval")
            
            
        }else if GlobalVariables.complexionType == "Fair" && GlobalVariables.modelBodyType == "Oval" {
            
            self.topImageView.image = UIImage(named: "fairOvaltop")
            self.bottomImageView.image = UIImage(named: "fairOvalbottom")
            
          
            
                print("oval")
            
            
        }else if GlobalVariables.complexionType == "Dark" && GlobalVariables.modelBodyType == "Oval" {
            
            self.topImageView.image = UIImage(named: "darkOvaltop")
            self.bottomImageView.image = UIImage(named: "darkOvalbottom")
          
            
                print("oval")
            
            
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






