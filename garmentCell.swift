//
//  garmentCell.swift
//  Udiva
//
//  Created by Aditya  Yadav on 28/06/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit

class garmentCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        print(self.garmentImage.frame.size.height)
        print(self.garmentImage.frame.size.width)
 
       
        // Initialization code
    }
   
    @IBOutlet var garmentImage: UIImageView!
    
    override func prepareForReuse() {
        garmentImage.hnk_cancelSetImage()
        garmentImage.image = nil
    }
    

}
