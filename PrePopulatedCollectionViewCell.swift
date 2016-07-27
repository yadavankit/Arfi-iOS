//
//  PrePopulatedCollectionViewCell.swift
//  Udiva
//
//  Created by Aditya  Yadav on 24/07/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit

class PrePopulatedCollectionViewCell: UICollectionViewCell {
    
    var isSelected : Bool?

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    @IBOutlet var starterPackImage: UIImageView!
    @IBOutlet var tickmarkOutlet: UIButton!
  
    @IBOutlet var garmentDetailLabel: UILabel!

}
