//
//  View3.swift
//
// 
//  Copyright (c) 2015 Archetapp. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class View3: UIViewController {
    
    @IBOutlet var activity: activityIndicator!
    
    
    
    
    
    override func viewDidLoad() {
        activity.hidden = true
    }
    
    
    
    
    
    
    
    @IBAction func getAction(sender: AnyObject) {
        
        
        
        activity.strokeColor = UIColor(red:0.98, green:0.13, blue:0.25, alpha:1.0)
        activity.hidden = false
        activity.startLoading()
        
            
        
        Alamofire.request(.GET, "http://ec2-52-40-182-97.us-west-2.compute.amazonaws.com:8081/GarmentUpload/receive")
            .responseImage { response in
                debugPrint(response)
                
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                    
                    self.activity.completeLoading(true)
                    self.activity.hidden = true
                    self.userImage.image = image
                }
        }

    }
    
    @IBOutlet var userImage: UIImageView!
    
    
    

    
    
    
    

   
}
