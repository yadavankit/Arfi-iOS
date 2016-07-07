//
//  complexionCell.swift
//  Udiva
//
//  Created by Ankit Yadav on 03/07/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit

class complexionCell: UICollectionViewCell
{
    var complexion = "None"
    
    @IBOutlet var mediumButton: UIButton!
    @IBOutlet var darkButton: UIButton!
    @IBOutlet var fairButton: UIButton!
    
    let vc = View1()
    let tickImage = UIImage(named: "model_tick_mark.png")! as UIImage
    let fairImage = UIImage(named: "fair_skin.png")! as UIImage
    let darkImage = UIImage(named: "dark_skin.png")! as UIImage
    let mediumImage = UIImage(named: "medium_skin.png")! as UIImage
    
    @IBOutlet var fairTick: UIImageView!
    @IBOutlet var mediumTick: UIImageView!
    @IBOutlet var darkTick: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.darkTick.hidden = true
        self.fairTick.hidden = true
        self.mediumTick.hidden = true
    }
    
    @IBAction func darkClicked(sender: AnyObject)
    {
        modelObject.complexion = "Dark"
        darkTick.hidden = false
        fairTick.hidden = true
        mediumTick.hidden = true
     
        
    }
    @IBAction func mediumClicked(sender: AnyObject)
    {
        modelObject.complexion = "Medium"
        mediumTick.hidden = false
        darkTick.hidden = true
        fairTick.hidden = true
        
    }
    @IBAction func fairClicked(sender: AnyObject)
    {
        modelObject.complexion = "Fair"
        fairTick.hidden = false
        mediumTick.hidden = true
        darkTick.hidden = true
       
    }

}
