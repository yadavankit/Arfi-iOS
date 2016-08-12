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
            returnUserData()
            
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

              
              
              
                
                print(GlobalVariables.globalFacebookId)
                print(userName)
                

                // TODO: Move this to where you establish a user session
                self.logUser(userId, userName: userName, email_id: email_id)

                
                Mixpanel.mainInstance().people.set(properties:
                    ["user_id": userId, "email": email_id,"name": userName, "$region" : "Australia"])

                
                Mixpanel.mainInstance().track(event: "User Logged In",
                    properties: ["Login" : "Done"])
                
                
                //Track Login of user
//                self.mixpanel.track("\(GlobalVariables.globalUserName!) has Logged In")
                self.getProperImages()
                self.checkForPreviousModel()
             
                
                
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
                                
                                print("Now TrUE")
                                
                                
                                
                                
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
                    NSUserDefaults.standardUserDefaults().setObject(arrayCount!, forKey: "section")
                    
                    
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["wardrobe_url"].string{
                            
                            
                            GlobalVariables.globalTopwearModelUrl.append(quote)
                            
                            
                            number += 1
                            print(number)
                        }
                        
                        
                        
                        if number == arrayCount! {
                            
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                            print("Now TrUE")
                            
                            
                            
                            
                        }
                        
                    }
                    
                    var number2 = 0
                    
                    while number2 < arrayCount! {
                        
                        if let quote2 = json["garments"][number2]["model_url"].string {
                            
                            GlobalVariables.globalModelUrl.append(quote2)
                            
                            number2 += 1
                        }
                        
                        
                        if number2 == arrayCount! {
                            
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                            print("Now Model TrUE")
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                }}
        
        
        getModelWardrobeImages()
        
        
        
        
        
        
    }
    
    func getModelWardrobeImages(){
        
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
                            
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                            print("Now TrUE")
                            
                            
                        }
                        
                    }
                    
                    
                    
                }}
        
        
        getWardrobeStyle()
        
        
        
        
        
        
        
        
        
    }
    
    func getWardrobeStyle(){
        
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
                    
                    arrayCount = (json["garments"].count)
                    
                    print("Style wardrobe")
                    
                    
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["garment_info"].string{
                            
                            
                            GlobalVariables.globalGarmentType.append(quote)
                            
                            print(GlobalVariables.globalGarmentType)
                            
                            
                            number += 1
                            print("garment Style Added \(number)")
                        }
                        
                        
                        
                        if number == arrayCount! {
                            
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                            print("Now TrUE")
                            
                            
                        }
                        
                    }
                    
                    
                    
                }}

    }
    

}
