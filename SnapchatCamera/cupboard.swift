//
//  GamifyScore.swift
//  arfi
//
//  Created by Ankit Yadav on 21/08/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit

class cupboard : UIView {
    
    @IBAction func cupboardNextButtonClicked(sender: AnyObject) {
        
        self.hidden = true
        
        
    }
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "cupboard", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    

    
    
    
    
    
    
    
    
}
