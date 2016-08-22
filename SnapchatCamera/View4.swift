//
//  View4.swift
//  arfi
//
//  Created by Aditya  Yadav on 19/08/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class View4: UIViewController {
    
    @IBOutlet var topSpace: NSLayoutConstraint!
    
    var garmentType : String?
    var imageCache : [String : UIImage] = [String : UIImage] ()
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var HelloUser: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      spinner.hidden = true
        
        if let userName = GlobalVariables.globalUserName {
            
            self.HelloUser.text = "Hello \(GlobalVariables.globalUserName!.componentsSeparatedByString(" ")[0])!"
        }
   
        self.topCollectionView.delegate = self
        self.topCollectionView.dataSource = self
        self.midCollectionView.delegate = self
        self.midCollectionView.dataSource = self

 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var midCollectionView: UICollectionView!
    @IBOutlet var topCollectionView: UICollectionView!

    @IBOutlet var middleLabel: UILabel!
   
}

extension View4 : UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == topCollectionView {
            
            if garmentType == "Shirts" {
                
                return GlobalVariables.shirtArray.count
            } else if garmentType == "TShirt" {
                
                return GlobalVariables.tshirtArray.count
                
                    
            }else if garmentType == "Palazzo" {
                
                return GlobalVariables.palazzoArray.count
                
                
            } else if garmentType == "Trouser" {
                
                return GlobalVariables.trouserArray.count
                
                
            } else if garmentType == "Shorts" {
                
                return GlobalVariables.shortsArray.count
                
                
            } else if garmentType == "Jeans" {
                
                return GlobalVariables.jeansArray.count
                
                
            } else if garmentType == "Capri" {
                
                return GlobalVariables.capriArray.count
                
                
            } else if garmentType == "Leggings" {
                
                return GlobalVariables.leggingArray.count
                
                
            } else if garmentType == "Cargos" {
                
                return GlobalVariables.cargoArray.count
                
                
            } else if garmentType == "Culottes" {
                
                return GlobalVariables.culotteArray.count
                
                
            } else if garmentType == "Skirt" {
                
                return GlobalVariables.skirtArray.count
                
                
            } else if garmentType == "Top" {
                
                return GlobalVariables.topArray.count
                
                
            } else if garmentType == "Dress" {
                
                return GlobalVariables.dressArray.count
                
            }else {
                
                return 5
            }
        } else {
            
            
           return GlobalVariables.CategorySection.count
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        
        self.topCollectionView.registerNib((UINib.init(nibName: "TopCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "TopCollectionViewCell")
        
        self.topCollectionView.registerNib((UINib.init(nibName: "CollectionViewCell2", bundle: nil)), forCellWithReuseIdentifier: "CollectionViewCell2")
        
        self.midCollectionView.registerNib((UINib.init(nibName: "MidCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "MidCollectionViewCell")
    
        if collectionView == topCollectionView {
            
            
            if garmentType == "Shirts" {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
            
                
                let URLString = GlobalVariables.shirtArray[indexPath.row]
                
                if let image = imageCache[URLString] {
                    
                    cell.garmentImage.image = image
                    
                    
                } else {
                    
                    Alamofire.request(.GET, URLString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                cell.garmentImage.image = image
                                self.imageCache[URLString] = image
                                
                            }
                    }
                    
                }
            
            return cell
                
            } else  if garmentType == "Top" {
                
                
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
                
                
                let URLString = GlobalVariables.topArray[indexPath.row]
                
                if let image = imageCache[URLString] {
                    
                    cell.garmentImage.image = image
                    
                    
                } else {
                    
                    Alamofire.request(.GET, URLString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                cell.garmentImage.image = image
                                self.imageCache[URLString] = image
                                
                            }
                    }
                    
                }
                
                return cell
                
                    
                    
                    
                    
            } else if garmentType == "TShirt" {
                
                
                
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
                
                
                let URLString = GlobalVariables.tshirtArray[indexPath.row]
                
                if let image = imageCache[URLString] {
                    
                    cell.garmentImage.image = image
                    
                    
                } else {
                    
                    Alamofire.request(.GET, URLString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                cell.garmentImage.image = image
                                self.imageCache[URLString] = image
                                
                            }
                    }
                    
                }
                
                return cell
                

            }else  if garmentType == "Palazzo" {
                
                
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
                
                
                let URLString = GlobalVariables.palazzoArray[indexPath.row]
                
                if let image = imageCache[URLString] {
                    
                    cell.garmentImage.image = image
                    
                    
                } else {
                    
                    Alamofire.request(.GET, URLString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                cell.garmentImage.image = image
                                self.imageCache[URLString] = image
                                
                            }
                    }
                    
                }
                
                return cell
                
                
                
                
                
            } else  if garmentType == "Trouser" {
                
                
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
                
                
                let URLString = GlobalVariables.trouserArray[indexPath.row]
                
                if let image = imageCache[URLString] {
                    
                    cell.garmentImage.image = image
                    
                    
                } else {
                    
                    Alamofire.request(.GET, URLString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                cell.garmentImage.image = image
                                self.imageCache[URLString] = image
                                
                            }
                    }
                    
                }
                
                return cell
                
                
                
                
                
            } else  if garmentType == "Capri" {
                
                
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
                
                
                let URLString = GlobalVariables.capriArray[indexPath.row]
                
                if let image = imageCache[URLString] {
                    
                    cell.garmentImage.image = image
                    
                    
                } else {
                    
                    Alamofire.request(.GET, URLString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                cell.garmentImage.image = image
                                self.imageCache[URLString] = image
                                
                            }
                    }
                    
                }
                
                return cell
                
                
                
                
                
            } else  if garmentType == "Leggings" {
                
                
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
                
                
                let URLString = GlobalVariables.leggingArray[indexPath.row]
                
                if let image = imageCache[URLString] {
                    
                    cell.garmentImage.image = image
                    
                    
                } else {
                    
                    Alamofire.request(.GET, URLString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                cell.garmentImage.image = image
                                self.imageCache[URLString] = image
                                
                            }
                    }
                    
                }
                
                return cell
                
                
                
                
                
            } else  if garmentType == "Cargos" {
                
                
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
                
                
                let URLString = GlobalVariables.cargoArray[indexPath.row]
                
                if let image = imageCache[URLString] {
                    
                    cell.garmentImage.image = image
                    
                    
                } else {
                    
                    Alamofire.request(.GET, URLString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                cell.garmentImage.image = image
                                self.imageCache[URLString] = image
                                
                            }
                    }
                    
                }
                
                return cell
                
                
                
                
                
            } else  if garmentType == "Culottes" {
                
                
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
                
                
                let URLString = GlobalVariables.culotteArray[indexPath.row]
                
                if let image = imageCache[URLString] {
                    
                    cell.garmentImage.image = image
                    
                    
                } else {
                    
                    Alamofire.request(.GET, URLString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                cell.garmentImage.image = image
                                self.imageCache[URLString] = image
                                
                            }
                    }
                    
                }
                
                return cell
                
                
                
                
                
            } else  if garmentType == "Jeans" {
                
                
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
                
                
                let URLString = GlobalVariables.jeansArray[indexPath.row]
                
                if let image = imageCache[URLString] {
                    
                    cell.garmentImage.image = image
                    
                    
                } else {
                    
                    Alamofire.request(.GET, URLString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                cell.garmentImage.image = image
                                self.imageCache[URLString] = image
                                
                            }
                    }
                    
                }
                
                return cell
                
                
                
                
                
            } else  if garmentType == "Shorts" {
                
                
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
                
                
                let URLString = GlobalVariables.shortsArray[indexPath.row]
                
                if let image = imageCache[URLString] {
                    
                    cell.garmentImage.image = image
                    
                    
                } else {
                    
                    Alamofire.request(.GET, URLString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                cell.garmentImage.image = image
                                self.imageCache[URLString] = image
                                
                            }
                    }
                    
                }
                
                return cell
                
                
                
                
                
            } else  if garmentType == "Skirt" {
                
                
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
                
                
                let URLString = GlobalVariables.skirtArray[indexPath.row]
                
                if let image = imageCache[URLString] {
                    
                    cell.garmentImage.image = image
                    
                    
                } else {
                    
                    Alamofire.request(.GET, URLString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                cell.garmentImage.image = image
                                self.imageCache[URLString] = image
                                
                            }
                    }
                    
                }
                
                return cell
                
                
                
                
                
            }  else  if garmentType == "Dress" {
                
                
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2
                
                
                let URLString = GlobalVariables.dressArray[indexPath.row]
                
                if let image = imageCache[URLString] {
                    
                    cell.garmentImage.image = image
                    
                    
                } else {
                    
                    Alamofire.request(.GET, URLString)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                cell.garmentImage.image = image
                                self.imageCache[URLString] = image
                                
                            }
                    }
                    
                }
                
                return cell
                
                
                
                
                
            }else {
                
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell2", forIndexPath: indexPath) as! CollectionViewCell2 
                
                
                
                
                return cell
                
                
            }
        } else if collectionView == midCollectionView {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MidCollectionViewCell", forIndexPath: indexPath) as! MidCollectionViewCell

            
            if GlobalVariables.CategorySection[indexPath.row] == "Shirts"{
                
                
                cell.PhotoView.image = UIImage(named: "Shirt")
                
                
            } else if GlobalVariables.CategorySection[indexPath.row] == "Top" {
                
               cell.PhotoView.image = UIImage(named: "Top")
               
            } else if GlobalVariables.CategorySection[indexPath.row] == "TShirt" {
                
                cell.PhotoView.image = UIImage(named: "TShirt")
                
                
          
            } else if GlobalVariables.CategorySection[indexPath.row] == "Palazzo" {
                
                cell.PhotoView.image = UIImage(named: "Palazzo")
                

                
            } else if GlobalVariables.CategorySection[indexPath.row] == "Trouser" {
                
              cell.PhotoView.image = UIImage(named: "Trouser")
              
            } else if GlobalVariables.CategorySection[indexPath.row] == "Jeans" {
                
               cell.PhotoView.image = UIImage(named: "Jeans")
               
            } else if GlobalVariables.CategorySection[indexPath.row] == "Cargos" {
                
              cell.PhotoView.image = UIImage(named: "Cargos")
              
            } else if GlobalVariables.CategorySection[indexPath.row] == "Capri" {
                
                cell.PhotoView.image = UIImage(named: "Capri")
                
            } else if GlobalVariables.CategorySection[indexPath.row] == "Leggings" {
                
               cell.PhotoView.image = UIImage(named: "Leggings")
               
            } else if GlobalVariables.CategorySection[indexPath.row] == "Culottes" {
      
                cell.PhotoView.image = UIImage(named: "Culottes")
                
            } else if GlobalVariables.CategorySection[indexPath.row] == "Skirt" {
                
                cell.PhotoView.image = UIImage(named: "Skirt")
     
            } else if GlobalVariables.CategorySection[indexPath.row] == "Shorts" {
                
                
                 cell.PhotoView.image = UIImage(named: "Shorts")
            } else if GlobalVariables.CategorySection[indexPath.row] == "Dress" {
                
                
                cell.PhotoView.image = UIImage(named: "Dress")
            }

            
            
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MidCollectionViewCell", forIndexPath: indexPath) as! MidCollectionViewCell
            
            
            
            
            return cell
            
        }
        
       
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.middleLabel.hidden = false
        
        if collectionView == midCollectionView {
                        spinner.hidden = false
            
            let triggerTime = (Int64(NSEC_PER_SEC) * 1/3)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                
                self.spinner.hidden = true
                
            })
            

            spinner.startAnimating()
            if GlobalVariables.CategorySection[indexPath.row] == "Shirts"{
                
              garmentType = "Shirts"
                
                
            } else if GlobalVariables.CategorySection[indexPath.row] == "Top" {
                
                
                garmentType = "Top"
            } else if GlobalVariables.CategorySection[indexPath.row] == "TShirt" {
                
                
                garmentType = "TShirt"
            } else if GlobalVariables.CategorySection[indexPath.row] == "Palazzo" {
                
                
                garmentType = "Palazzo"
            } else if GlobalVariables.CategorySection[indexPath.row] == "Trouser" {
                
                
                garmentType = "Trouser"
            } else if GlobalVariables.CategorySection[indexPath.row] == "Jeans" {
                
                
                garmentType = "Jeans"
            } else if GlobalVariables.CategorySection[indexPath.row] == "Cargos" {
                
                
                garmentType = "Cargos"
            } else if GlobalVariables.CategorySection[indexPath.row] == "Capri" {
                
                
                garmentType = "Capri"
            } else if GlobalVariables.CategorySection[indexPath.row] == "Leggings" {
                
                
                garmentType = "Leggings"
            } else if GlobalVariables.CategorySection[indexPath.row] == "Culottes" {
                
                
                garmentType = "Culottes"
            } else if GlobalVariables.CategorySection[indexPath.row] == "Skirt" {
                
                
                garmentType = "Skirt"
            } else if GlobalVariables.CategorySection[indexPath.row] == "Shorts" {
                
                
                garmentType = "Shorts"
            }
            
          topCollectionView.reloadData()
          spinner.stopAnimating()
//          spinner.hidden = true
            
            UIView.animateWithDuration(1.2, animations: {
                
                self.topSpace.constant = CGFloat(51)
            })
            
            
            
        }
        
    }
    
    
}



extension View4 : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        if collectionView == topCollectionView {
            
            let itemsPerRow:CGFloat = 4
            let hardCodedPadding:CGFloat = 5
            let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding + 70
            let itemHeight = CGFloat(185.5)
            return CGSize(width: itemWidth, height: itemHeight)
            
        } else {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding + 200
        let itemHeight = CGFloat(210.5)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    }
}


