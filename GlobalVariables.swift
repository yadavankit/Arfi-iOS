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
    static var globalStarterPack : [AnyObject] = []
    static var freshLogin : Bool?
    static var prepopulated : Int?
    static var seenComplexion : Bool? = false
    static var prepopulatedComplete : Bool = false
    static var startedUsingArfi : Bool = false
    static var twoShown : Bool = false
    static var threeShown : Bool = false
    
    ////// ------- NEW API --------
    
    static var nakedModelTop : String?
    static var nakedModelBottom : String?
    static var modelBody : String?
    static var numberOfGarments : String?
    static var complexion : String?
    static var userName : String?
    static var modelUrl : [String] = []
    static var wardrobeUrl : [String] = []
    static var garmentInfo : [String] = []
    static var garmentStyle : [String] = []
    static var topwear : [String] = []
    static var bottomwear : [String] = []
    static var prepopulatedCompleted : Bool?
    static var nakedModelTopImage : UIImage?
    static var nakedModelBottomImage : UIImage?
    static var ModelValuesAdded : Bool?
    
    
    
    
}
