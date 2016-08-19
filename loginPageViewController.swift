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
//     let mixpanel : Mixpanel = Mixpanel.sharedInstance()

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
