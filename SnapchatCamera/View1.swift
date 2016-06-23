//
//  View1.swift
//  SnapchatCamera
//
//  Created by Jared Davidson on 8/26/15.
//  Copyright (c) 2015 Archetapp. All rights reserved.
//

import UIKit
import Kingfisher

class View1: UIViewController {

    @IBOutlet weak var second: UIImageView!
    
    @IBOutlet weak var third: UIImageView!
    @IBOutlet weak var userUploadedImage: UIImageView!
    
    let cache = KingfisherManager.sharedManager.cache
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cache.clearMemoryCache()
        cache.clearDiskCache()
        cache.cleanExpiredDiskCache()
        
        
        userUploadedImage.kf_setImageWithURL(NSURL(string: "http://cdn.macrumors.com/article-new/2016/02/iphonesearray-800x620.jpg")!)
        
         second.kf_setImageWithURL(NSURL(string: "http://cdn.macrumors.com/article-new/2016/02/iphonesearray-800x620.jpg")!)
        
         third.kf_setImageWithURL(NSURL(string: "http://cdn.macrumors.com/article-new/2016/02/iphonesearray-800x620.jpg")!)
        
        
    
    }

    


   

}
