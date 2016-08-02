//
//  ViewController.swift
//  SnapchatCamera
//
//  Created by Jared Davidson on 8/26/15.
//  Copyright (c) 2015 Archetapp. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.z
        
        let v1 : View1 = View1(nibName: "View1", bundle: nil)
        let v2 : View2 = View2(nibName: "View2", bundle: nil)
        let v3 : View3 = View3(nibName: "View3", bundle: nil)
        
        self.addChildViewController(v1)
        self.scrollView.addSubview(v1.view)
        v1.didMoveToParentViewController(self)
        
        self.addChildViewController(v2)
        self.scrollView.addSubview(v2.view)
        v2.didMoveToParentViewController(self)
        
        self.addChildViewController(v3)
        self.scrollView.addSubview(v3.view)
        v3.didMoveToParentViewController(self)
        
        var v2Frame : CGRect = v2.view.frame
        v2Frame.origin.x = self.view.frame.width
        v2.view.frame = v2Frame
        
        var v3Frame : CGRect = v3.view.frame
        v3Frame.origin.x = self.view.frame.width * 2
        v3.view.frame = v3Frame
      

        
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 1/3)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
               self.checkForPreviousModel()
        })
     


}
    func checkForPreviousModel(){
        
        if GlobalVariables.globalFacebookId != nil {
        
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
                                
                                self.checkForPrepopulation()
                                
                                
                                
                                
                            }
                            
                        }
                        
                        
                        
                    }}
            

        })
        
        
        }
        
    }
    



    func checkForPrepopulation(){
        
        print(GlobalVariables.modelStatus)
        if GlobalVariables.modelStatus! == "No User Found"{
            
            
            let starterPackScreen = Prepopulated.instanceFromNib()
            starterPackScreen.frame = CGRectMake(0 ,0 , self.view.frame.width , self.view.frame.height)
            self.view.addSubview(starterPackScreen)
            
            //self.scrollView.contentOffset.x = self.view.frame.size.width
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
            
            
        } else {
            
            self.scrollView.contentOffset.x = self.view.frame.size.width
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
        }


    }
    
    
    
}

