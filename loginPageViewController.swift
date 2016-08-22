//
//  loginPageViewController.swift
//  Udiva
//
//  Created by Aditya  Yadav on 24/06/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Mixpanel
import Crashlytics


class loginPageViewController: UIViewController , FBSDKLoginButtonDelegate{
    
    let kScreenSize = UIScreen.mainScreen().bounds.size
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


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile" , "email" , "user_friends"]
        loginButton.center = self.view.center
        loginButton.frame = CGRect(x: kScreenSize.width/2 - 125, y: kScreenSize.height - 150, width: 260, height: 50)
        loginButton.layer.cornerRadius = 25
        loginButton.clipsToBounds = true
        loginButton.delegate = self
        self.view.addSubview(loginButton)
 
    }
    
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error == nil {
            dispatch_async(dispatch_get_main_queue()){
                
                self.performSegueWithIdentifier("loginComplete", sender: self)
                
            }
            
            print("Login complete")
            GlobalVariables.freshLogin = true
            print(GlobalVariables.globalUserName)
            
//            let mixpanel = Mixpanel.sharedInstance()
            let properties = ["LoginCompleted": "Done"]
//            mixpanel.track("Login Complete", properties: properties)
          
            
            } else {
            
            print(error.localizedDescription)
        }
    }
    

   
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("user logged out")
    }
    
    func returnUserData()  { //get user id and username
        
        
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,name,picture.width(480).height(480)"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                
            }
            else
            {
                
                let userId : String = result.valueForKey("id") as! String
                
                let userName : String = result.valueForKey("name") as! String
                
                let email_id : String = result.valueForKey("email") as! String
                
                
                
                GlobalVariables.globalFacebookId = userId
                GlobalVariables.globalUserName = userName
                
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(userName, forKey: "fb_user_name")

              
              
              self.getUserDetails()
                
                print(GlobalVariables.globalFacebookId)
                print(userName)
                

                // TODO: Move this to where you establish a user session
                self.logUser(userId, userName: userName, email_id: email_id)

                
                Mixpanel.mainInstance().people.set(properties:
                    ["user_id": userId, "email": email_id,"name": userName, "$region" : "Australia"])

                
                Mixpanel.mainInstance().track(event: "User Logged In",
                    properties: ["Login" : "Done"])

             
                
                
            }
        })
        
    }
    
    func logUser(userId: String, userName: String, email_id: String)
    {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        Crashlytics.sharedInstance().setUserEmail(email_id)
        Crashlytics.sharedInstance().setUserIdentifier(userId)
        Crashlytics.sharedInstance().setUserName(userName)
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
                
            } else if GlobalVariables.garmentStyle[number2].containsString("Dress") {
                
                
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
                
                
            } else if GlobalVariables.garmentStyle[number3].containsString("Dress") {
                
                GlobalVariables.dressArray.append(GlobalVariables.wardrobeUrl[number3])
                
            }
            
            
            
            number3 += 1
            
        }
        

        
        
        
        
    }
    
    func getUserDetails(){
        
        GlobalVariables.numberOfGarments = String(GlobalVariables.wardrobeUrl.count)
        
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
                    
                    
                    GlobalVariables.nakedModelTop = nakedModelTop
                    print(GlobalVariables.nakedModelTop)
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
