//
//  GamifyScore.swift
//  arfi
//
//  Created by Ankit Yadav on 21/08/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit

class GamifyScore : UIView {
    
    
    @IBOutlet var FirstLevelView: UIView!
    @IBOutlet var SecondLevelView: UIView!
    @IBOutlet var ThirdLevelView: UIView!
    @IBOutlet var LevelLabel: UILabel!
    @IBOutlet var ScoreLabel: UILabel!
    @IBOutlet var ProgressView: UIProgressView!
    
    
    
    override func awakeFromNib() {
        
        //Setup level score whatever
        LevelLabel.text = "Level : " + String(GlobalVariables.is_on_level!)
        let camera_uploads = String(GlobalVariables.camera_uploads!)
        let first_level_status = String(GlobalVariables.first_level_status!)
        let second_level_status = String(GlobalVariables.second_level_status!)
        let third_level_status = String(GlobalVariables.third_level_status!)
        var out_of = ""
        var uploads_for_level = ""
        var progress : Float = 0.0
        
        let is_on_level = String(GlobalVariables.is_on_level!)
        if is_on_level == "1"
        {
            out_of = "10"
            uploads_for_level = camera_uploads
            progress = Float(uploads_for_level)! / 10
            self.SecondLevelView.alpha = 0.3
            self.ThirdLevelView.alpha = 0.3
            
            
        }
        else if is_on_level == "2"
        {
            out_of = "15"
            uploads_for_level = String(Int(camera_uploads)! - 10)
            progress = Float(uploads_for_level)! / 15
            self.FirstLevelView.alpha = 0.3
            self.ThirdLevelView.alpha = 0.3
            
            
        }
        else if is_on_level == "3"
        {
            self.FirstLevelView.alpha = 0.3
            self.SecondLevelView.alpha = 0.3
            
            out_of = "15"
            uploads_for_level = String(Int(camera_uploads)! - 25)
            progress = Float(uploads_for_level)! / 15
            
    
            
        }
        ScoreLabel.text = uploads_for_level + "/" + out_of
        ProgressView.progress = progress
        print("progresssssss")
        print(progress)
        
        
        
        self.ThirdLevelView.alpha = 0.5
        

        
    }
    
    
    class func instanceFromNib() -> UIView {
        
        
        
        
        
        
        
        return UINib(nibName: "GamifyScore", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    
    
    
    
    
    
}
