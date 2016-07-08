
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
    let mixpanel : Mixpanel = Mixpanel.sharedInstance()
    
    var isLaunched : Bool = false
    
    func showQuestions(){
        
        
       self.navigationController?.pushViewController(QuestionViewController(), animated: true)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
     
     
        
        
        if FBSDKAccessToken.currentAccessToken() == nil {
            print("not logged in yet")
            
          mixpanel.track("someone (maybe ram) has started the walkthrough, really!")
            
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
    
    
    getModelWardrobeImages()
    getBottomWearImages()
    

    
    
    
}

var testa : [AnyObject]?




func getModelWardrobeImages(){ //VIEW 1
    
    var arrayCount : Int?
    
    print("WARDROBEIMAGES RAN")
    
    Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
        .responseJSON { response in
            if let jsonValue = response.result.value {
                let json = JSON(jsonValue)
            
                
                
                
                arrayCount = (json["garments"].count)
                GlobalVariables.finalGarmentCount = arrayCount!
                
                print(arrayCount!)
                print("final garment is")
            
                
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
                        
                        print("Now TrUE")
                        
                        
                    }
                    
                }
                
                
                
            }}
    
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
                    if let quote = json["garments"][number]["garment_info"].string{
                        
                        
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
    
    
    
    getModelUrlForView1()

    
    
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
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(userName, forKey: "fb_user_name")
            
            print(GlobalVariables.globalFacebookId)
            print(userName)
            
           getProperImages()
           getGarmentInformation()
       
            
        }
    })
   

}


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
                        
                        print("Now TrUE")
                        
                        
                    }
                    
                }
                
                
                
            }}
    

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