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
      self.layer.cornerRadius = 75
      self.layer.masksToBounds = true
      self.layer.borderColor = UIColor.blackColor().CGColor
      self.layer.borderWidth = 4

    }
    @IBOutlet var starterPackImage: UIImageView!
    @IBOutlet var tickmarkOutlet: UIButton!
  

}
