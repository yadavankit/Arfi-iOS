//
//  LaunchScreen.swift
//  Udiva
//
//  Created by Aditya  Yadav on 22/07/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit

class LaunchScreen: UIView {

    class func instanceFromNib() -> UIView {
        
        
        return UINib(nibName: "LaunchScreen", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        
    }

}
