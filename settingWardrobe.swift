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
    }

}
