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
        self.layer.backgroundColor = UIColor.grayColor().CGColor
        // Initialization code
    }
   
    @IBOutlet var garmentImage: UIImageView!

}
