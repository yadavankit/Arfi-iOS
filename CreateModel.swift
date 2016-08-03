//
//  CreateModel.swift
//  Udiva
//
//  Created by Aditya  Yadav on 02/08/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import JKNotificationPanel

class CreateModel: UIView {
    
    class func instanceFromNib() -> UIView {
        
        
        return UINib(nibName: "CreateModel", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        
    }
    
     let panel : JKNotificationPanel = JKNotificationPanel()

    @IBAction func done(sender: AnyObject) {
        
        print("Seen Complexion")
        print(GlobalVariables.seenComplexion)

   
        //
        let current_user_id = GlobalVariables.globalFacebookId!
        let bust = modelObject.bust
        let hip = modelObject.hip
        let waist = modelObject.waist
        let height = modelObject.height
        let complexion = modelObject.complexion
        NSUserDefaults.standardUserDefaults().setObject(current_user_id, forKey: "usr_id")
        NSUserDefaults.standardUserDefaults().setObject(bust, forKey: "bust")
        NSUserDefaults.standardUserDefaults().setObject(hip, forKey: "hip")
        NSUserDefaults.standardUserDefaults().setObject(waist, forKey: "waist")
        NSUserDefaults.standardUserDefaults().setObject(height, forKey: "height")
        NSUserDefaults.standardUserDefaults().setObject(complexion, forKey: "complexion")
        
        
        
        var garmentSelectedString = "["
        for garment in GlobalVariables.globalStarterPack
        {
            print("selected garmenst")
            garmentSelectedString = garmentSelectedString + String(garment) + ","
        }
        garmentSelectedString = garmentSelectedString.substringToIndex(garmentSelectedString.endIndex.predecessor())
        garmentSelectedString = garmentSelectedString + "]"
        
        print(GlobalVariables.globalTopAndBottom.count)
        
        Alamofire.request(.POST, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/populate?user_id=\(GlobalVariables.globalFacebookId!)&garments_selected=\(garmentSelectedString)&user_name=\(GlobalVariables.globalUserName!.componentsSeparatedByString(" ")[0])&bust=\(bust)&hip=\(hip)&waist=\(waist)&height=\(height)&complexion=\(complexion)")
            .validate()
            .responseJSON { response in
                print(response)
                
                print("Model Garment in saved on Server")
            
           
                    
                    self.panel.showNotify(withStatus: .SUCCESS, inView: self, message: "Swipe Left 👈 and tap on Circle to know how you can upload more garments")
                    
                    
        
                
                
                NSUserDefaults.standardUserDefaults().setObject("true", forKey: "freshLogin")
             
//                
//                self.getGarmentInformation()
//                self.getWardrobeStyle()
//                self.getModelUrlForView1()
//                self.garmentCollectionView.reloadData()
          
            
            self.removeFromSuperview()
                
                
             
                
        }

    }

}
