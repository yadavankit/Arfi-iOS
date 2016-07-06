//
//  ModelGarmentCollectionViewCell.swift
//  Udiva
//
//  Created by Aditya  Yadav on 30/06/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit

class ModelGarmentCollectionViewCell: UICollectionViewCell {

    @IBOutlet var garmentImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       self.layer.backgroundColor = UIColor.whiteColor().CGColor
       self.layer.cornerRadius = 4
       self.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        garmentImage.hnk_cancelSetImage()
        garmentImage.image = nil
    }

  

}
