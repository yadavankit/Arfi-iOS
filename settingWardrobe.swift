//
//  settingWardrobe.swift
//  Udiva
//
//  Created by Aditya  Yadav on 27/07/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit

class settingWardrobe: UIView {

    class func instanceFromNib() -> UIView {
        
        
        return UINib(nibName: "settingWardrobe", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        
    }
    
 
    override func awakeFromNib() {
        self.removeFromSuperview()
        
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 6)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            
          self.removeFromSuperview()
            
        })
    }

}
