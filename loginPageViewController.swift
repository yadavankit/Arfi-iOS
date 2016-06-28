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
            
            } else {
            
            print(error.localizedDescription)
        }
    }

   
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("user logged out")
    }

   

}
