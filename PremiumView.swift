//
//  PremiumView.swift
//  Udiva
//
//  Created by Aditya  Yadav on 04/07/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit
import Mixpanel

class PremiumView: UIView {
    
//     let mixpanel : Mixpanel = Mixpanel.sharedInstance()

    class func instanceFromNib() -> UIView {
        
        
        return UINib(nibName: "PremiumView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        
    }
    @IBAction func goPremium(sender: AnyObject) {
        
        
       
//        mixpanel.track("\(GlobalVariables.globalUserName) has selected the premium option")
        self.removeFromSuperview()
        
        let alert = UIAlertView(title: "Thanks", message: "Someone from Udiva will contact you soon.", delegate: self, cancelButtonTitle: "Okay")
        
        alert.show()
    
        
    }
    @IBAction func skip(sender: AnyObject) {
        
        

        
        self.removeFromSuperview()
        
    }

}
