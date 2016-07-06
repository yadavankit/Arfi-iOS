
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

func getDocumentsURL() -> NSURL {
    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    return documentsURL
}

func fileInDocumentsDirectory(filename: String) -> String {
    
    let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
    return fileURL.path!
    
}


class mainViewController: UIViewController , BWWalkthroughViewControllerDelegate {
    
    var FacebookUserId : String = "58382010"
    var needWalkthrough:Bool = true
    var walkthrough:BWWalkthroughViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
     
        
        if FBSDKAccessToken.currentAccessToken() == nil {
            print("not logged in yet")
            
           self.presentWalkthrough()
            
        } else {
            
            print("logged in")

          returnUserData()
            
            self.performSegueWithIdentifier("loginDone", sender: self)
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
    
    
}


func getNumberOfGarments () { //calculate the current number of garments on the server
    
    
    Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_garments?user_id=\(GlobalVariables.globalFacebookId!)")
        .responseJSON { response in
            
            
            if let JSON = response.result.value {
                
                
                print (Int(JSON as! NSNumber))
                
               
                GlobalVariables.globalNumberOfGarments = String((Int(JSON as! NSNumber)))
                
                if GlobalVariables.globalNumberOfGarments?.isEmpty != nil {
                    
            
            getGarments()
                    
                    
                }
                
            }
    }
    
    
}


func getGarments(){
    
    var number = 1
    
    while number < Int(GlobalVariables.globalNumberOfGarments!)! + 1 {
        
        
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/Garments/\(GlobalVariables.globalFacebookId!)/uploaded/\(number).png")
            .responseImage { response in
                
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                    
                  //  GlobalVariables.globalGarments.append(image)
                    print(number)
                    
                
          
                }
        }
        
        number = number + 1
    }
    
   
}

let imageCache = NSCache()

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

var testa : [AnyObject]?




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
            
           getProperImages()
       
            
        }
    })
    
    
    
  
    

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
