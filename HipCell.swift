//
//  BustCell.swift
//  Udiva
//
//  Created by Ankit Yadav on 02/07/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit
import CircleSlider

class HipCell: UICollectionViewCell {
    
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var sliderArea: UIView!
    @IBOutlet var fieldLabel: UILabel!
    
    private var circleSlider: CircleSlider!
        {
        didSet
        {
            self.circleSlider.tag = 0
        }
    }
    
    private var sliderOptions: [CircleSliderOption] {
        return [
            .BarColor(UIColor(red: 247/255, green: 97/255, blue: 117/255, alpha: 0.5)),
            .ThumbColor(UIColor(red: 141/255, green: 185/255, blue: 204/255, alpha: 1)),
            .TrackingColor(UIColor(red: 245/255, green: 35/255, blue: 65/255, alpha: 1)),
            .BarWidth(30),
            .StartAngle(-45),
            .MaxValue(40),
            .MinValue(20)
        ]
    }
    
    func valueChange(sender: CircleSlider)
    {
        self.valueLabel.text = "\(Int(sender.value))"
        modelObject.hip = self.valueLabel.text!
    }
    
    private func buildCircleSlider() {
        self.circleSlider = CircleSlider(frame: self.sliderArea.bounds, options: self.sliderOptions)
        self.circleSlider?.addTarget(self, action: #selector(self.valueChange(_:)), forControlEvents: .ValueChanged)
        self.sliderArea.addSubview(self.circleSlider!)
    }
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.buildCircleSlider()
    }
    
}
