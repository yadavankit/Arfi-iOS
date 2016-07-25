//
//  GlobalVariables.swift
//  Udiva
//
//  Created by Aditya  Yadav on 29/06/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit
import Haneke
import Track
struct GlobalVariables {
    static var globalGarments : [UIImageView] = []
    static var globalFacebookId : String?
    static var globalNumberOfGarments : String?
    static var globalUserName : String?
    static var globalGarmentSelected : String?
    static var globalTopwearModelUrl : [String] = []
    static var globalSafeToFetch : Bool = false
    static var globalModelUrl : [String] = []
    static var wardrobeImages : [UIImage] = []
    static var cache = Shared.dataCache
    static var track = Cache.shareInstance
    static var globalTopwearRealModelUrl : [String] = []
    static var globalTopAndBottom : [String] = []
    static var globalGarmentType : [String] = []
    static var finalGarmentCount : Int?
    static var detail1 : String = "detail1"
    static var detail2 : String = "detail2"
    static var detail3 : String = "detail3"
    static var mainDetail : String = "mainDetail"
    static var globalBottomWardrobe : [String] = []
    static var garmentInformation : [String] = []
    static var modelBodyType : String?
    static var isBodyTypeSelected : Bool?
    static var complexionType : String?
    static var processedImageStatus : [String] = []
    static var modelStatus : String?
    static var globalStarterPack : [String] = []
}
