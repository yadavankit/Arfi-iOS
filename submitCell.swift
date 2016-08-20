//
//  submitCell.swift
//  Udiva
//
//  Created by Ankit Yadav on 02/07/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit
import Alamofire

class submitCell: UICollectionViewCell {

    @IBAction func submitClicked(sender: AnyObject)
    {

        let current_user_id = GlobalVariables.globalFacebookId
        let bust = modelObject.bust
        let hip = modelObject.hip
        let waist = modelObject.waist
        let height = modelObject.height
        let complexion = modelObject.complexion

        Alamofire.request(.POST, "http://192.168.182.90:8000/processing_panel/set_model_size", parameters: ["user_id": GlobalVariables.globalFacebookId!,"bust_size": bust,"height_size": height,"complexion": complexion,"waist_size": waist, "hip_size": hip])
            .validate()
            .responseJSON { response in
                print(current_user_id)
                print("Model Garment in saved on Server")
        }
        
        
    }
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

}
