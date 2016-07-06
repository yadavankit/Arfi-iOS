//
//  Model.swift
//  Udiva
//
//  Created by Ankit Yadav on 05/07/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

class Model {
    var bust:String
    var waist:String
    var hip:String
    var height:String
    var complexion:String
    init(bust:String, waist:String, hip:String,height:String, complexion:String)
    {
        self.bust = bust
        self.waist = waist
        self.hip = hip
        self.height = height
        self.complexion = complexion
    }
}
var modelObject = Model(bust:"None",waist:"None",hip:"None",height:"None",complexion:"None")