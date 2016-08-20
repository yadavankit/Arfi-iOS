
//
//  mainViewController.swift
//  Udiva
//
//  Created by Aditya  Yadav on 24/06/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Kingfisher
import Mixpanel
import ReachabilitySwift
import CoreTelephony


class mainViewController: UIViewController , BWWalkthroughViewControllerDelegate {
    
    var FacebookUserId : String = "58382010"
    var needWalkthrough:Bool = true
    var walkthrough:BWWalkthroughViewController!
    var isSignedUp = false
    var isLaunched : Bool = false
    var gotTheData : Bool = false
    var timer: dispatch_source_t!
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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let launchView = LaunchScreen.instanceFromNib()
        launchView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.view.addSubview(launchView)
        startTimer()
        

        
        if FBSDKAccessToken.currentAccessToken() == nil {
            print("not logged in yet")

            
           self.presentWalkthrough()
            
        } else {
            
            print("logged in")
                isSignedUp = true

          returnUserData()

        }
    }

 
    
    func checkConnectivity(){
        
        var networkConnectivity = "Offline"
        

        
        //Check the internet connectivity of User
        do
        {
            let reachability:Reachability = try Reachability.reachabilityForInternetConnection()
            do
            {
                try reachability.startNotifier()
                let status = reachability.currentReachabilityStatus
                if(status == .NotReachable)
                {
                    networkConnectivity = "Offline"
                }
                else if (status == .ReachableViaWiFi)
                {
                    networkConnectivity = "WiFi"
                }
                else if (status == .ReachableViaWWAN)
                {
                    let networkInfo = CTTelephonyNetworkInfo()
                    let carrierType = networkInfo.currentRadioAccessTechnology
                    switch carrierType
                    {
                    case CTRadioAccessTechnologyGPRS?,CTRadioAccessTechnologyEdge?,CTRadioAccessTechnologyCDMA1x?:
                        networkConnectivity = "Edge"
                    case CTRadioAccessTechnologyWCDMA?,CTRadioAccessTechnologyHSDPA?,CTRadioAccessTechnologyHSUPA?,CTRadioAccessTechnologyCDMAEVDORev0?,CTRadioAccessTechnologyCDMAEVDORevA?,CTRadioAccessTechnologyCDMAEVDORevB?,CTRadioAccessTechnologyeHRPD?:
                        networkConnectivity = "3G"
                    case CTRadioAccessTechnologyLTE?:
                        networkConnectivity = "4G"
                    default:
                        networkConnectivity = "Offline"
                    }
                }
                else
                {
                    print("Error")
                }
            }
            catch
            {
                print("Error")
            }
        }
        catch
        {
            print("Error")
        }
        
        if networkConnectivity == "Offline"
        {
            let alert = UIAlertView(title: "No Internet Connection", message: "Seems like you are Offline. Please Connect to WiFi or 3G.", delegate: nil, cancelButtonTitle: "OK" )
            
           
            alert.show()
        }
        else if networkConnectivity == "Edge"
        {
            let alert = UIAlertView(title: "Slow Internet Connection", message: "Seems you are on Edge connection. Please switch to WiFi or 3G.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        

        
    }
    
  
   
    @IBAction func presentWalkthrough(){
        
        
        let stb = UIStoryboard(name: "Main", bundle: nil)
        walkthrough = stb.instantiateViewControllerWithIdentifier("container") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewControllerWithIdentifier("page_1")
        let page_two = stb.instantiateViewControllerWithIdentifier("page_2")
        let page_three = stb.instantiateViewControllerWithIdentifier("page_3")
        
        
        
        // Attach the pages to the master
        walkthrough.delegate = self
        walkthrough.addViewController(page_one)
        walkthrough.addViewController(page_two)
        walkthrough.addViewController(page_three)
    
        
        
        self.presentViewController(walkthrough, animated: true) {
            ()->() in
            self.needWalkthrough = false
        }
    }
    
    




func returnUserData()  { //get user id and username
    

    print("RETURNING USER DATA")

    let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
    graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
        
        if ((error) != nil)
        {
         
        }
        else
        {
            
            let userId : String = result.valueForKey("id") as! String
            
            let userName : String = result.valueForKey("name") as! String
            
           
            GlobalVariables.globalFacebookId = userId
            GlobalVariables.globalUserName = userName
            print(GlobalVariables.globalUserName!)
            self.getUserDetails()
        
            
            
            
        }
    })
   

}

func setup () {

    GlobalVariables.numberOfGarments = String(GlobalVariables.wardrobeUrl.count)
    
    var number = 0
    
    while number < GlobalVariables.wardrobeUrl.count {
    
        if GlobalVariables.garmentInfo[number].containsString("BottomWear"){
            
            GlobalVariables.bottomwear.append(GlobalVariables.wardrobeUrl[number])
            print(GlobalVariables.bottomwear[0])
            print("")
            
            
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
    

    
    self.performSegueWithIdentifier("loginDone", sender: self)

    
    
}
    
    func startTimer() {
        
        let queue = dispatch_queue_create("com.domain.app.timer", nil)
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC) // every 60 seconds, with leeway of 1 second
        dispatch_source_set_event_handler(timer) {
            
            if GlobalVariables.prepopulatedComplete == true {
                
                let triggerTime = (Int64(NSEC_PER_SEC) * 3)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                    
                self.performSegueWithIdentifier("loginDone", sender: self)
                })
                
                
                
                
                
            }
            
        }
        dispatch_resume(timer)
    }
    func stopTimer() {
        dispatch_source_cancel(timer)
        timer = nil
    }




func getUserDetails(){
    
    var arrayCount : Int?
    
    Alamofire.request(.GET, "http://backend.arfi.in:4000/processing_panel/user_api?user_id=\(GlobalVariables.globalFacebookId!)")
        .responseJSON { response in
            if let jsonValue = response.result.value {
              
                let json = JSON(jsonValue)
                print(json)
                
                let nakedModelTop = json["naked_model_top"].string
                let nakedModelBottom = json["naked_model_bottom"].string
                let modelBody = json["model_body"].string
                let complexion = json["complexion"].string
                let userName = json["user_name"].string
                
                GlobalVariables.nakedModelTop = nakedModelTop
                GlobalVariables.nakedModelBottom = nakedModelBottom
                GlobalVariables.modelBody = modelBody
                
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
                        print(GlobalVariables.wardrobeUrl[0])
                        
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


//extenstion

extension mainViewController{
    
    func walkthroughCloseButtonPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func walkthroughPageDidChange(pageNumber: Int) {
        if (self.walkthrough.numberOfPages - 1) == pageNumber{
            self.walkthrough.closeButton?.hidden = false
        }else{
            self.walkthrough.closeButton?.hidden = true
        }
    }
    
   
 
}
