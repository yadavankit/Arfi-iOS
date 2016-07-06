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

class loginPageViewController: UIViewController , FBSDKLoginButtonDelegate{
    
    let kScreenSize = UIScreen.mainScreen().bounds.size

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
            returnUserData()
            
            } else {
            
            print(error.localizedDescription)
        }
    }

   
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("user logged out")
    }
    
    func returnUserData()  { //get user id and username
        
        
        
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
                
                print(GlobalVariables.globalFacebookId)
                print(userName)
                
                self.getProperImages()
                
                
            }
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
                    
                    
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["garment_style"].string{
                            
                            
                            GlobalVariables.globalGarmentType.append(quote)
                            
                            
                            
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
