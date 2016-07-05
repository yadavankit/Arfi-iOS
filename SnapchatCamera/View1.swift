//
//  View1.swift

//

import UIKit
import Alamofire
import AlamofireImage
import CircleSlider
import Kingfisher




class View1: UIViewController  {
    @IBOutlet var botImageView: UIImageView!
    @IBOutlet var topImageView: UIImageView!
    
    @IBOutlet var garmentTop: NSLayoutConstraint!
    var test = 6
    

   
    @IBOutlet var garmentCollectionView: UICollectionView!

    
      var garments = [UIImage(named : "1Model"),UIImage(named : "2Model"),UIImage(named : "3Model"),UIImage(named : "4Model" ) , UIImage(named : "5Model" ) ]
    
    var garmentsOption = [UIImage(named : "1Garment"),UIImage(named : "2Garment"),UIImage(named : "3Garment"),UIImage(named : "4Garment") , UIImage(named : "5Garment" )]
    var condition = false
   
    @IBOutlet var bottomImageView: UIImageView!
    var topUploaded = false
   
    
    let kScreenSize = UIScreen.mainScreen().bounds.size
    override func viewDidLoad() {
        
        super.viewDidLoad()

     
        
        garmentCollectionView.delegate = self
        garmentCollectionView.dataSource = self
        
  
    }


    @IBAction func doThis (sender : AnyObject) {
        
        print("doin it")
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:8000/GarmentUpload/receive")
            .responseImage { response in
                debugPrint(response)
                
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                
                if let image = response.result.value {
                    print("image downloaded: \(image)")
               
                    if self.topUploaded == false {
                        
                        self.topImageView.image = image
                        self.topUploaded = true
                    } else {
                        
                        self.botImageView.image = image
                    }
  
          }
 
    }

        
    }

    @IBOutlet var garmentCollectionViewTop: NSLayoutConstraint!
    
    
    func doIt () {
        
        
        if condition == false {
            UIView.animateWithDuration(0.5) {
                self.garmentTop.constant = 300
                self.view.layoutIfNeeded()
                self.condition = true
            }
        } else {
            
            UIView.animateWithDuration(0.5) {
                self.garmentTop.constant = 532
                self.view.layoutIfNeeded()
                self.condition = false
            }
            
            
        }
        
    }

    @IBOutlet var CollectionViewMover: UIButton!
    
    @IBAction func getUserID(){
    
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:8000/GarmentUpload/receive", parameters: ["user_id": "1069249093136307"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
}

    var tesst = 6
}


extension View1 : UICollectionViewDataSource {
    

    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return tesst
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        self.garmentCollectionView.registerNib((UINib.init(nibName: "ModelGarmentCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "modelCell")
        
        
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("modelCell", forIndexPath: indexPath) as! ModelGarmentCollectionViewCell
        
    
        
        
        
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 8)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            if GlobalVariables.wardrobeImages.count > 0 {
                
          self.tesst =      GlobalVariables.wardrobeImages.count
              
                
                
               cell.garmentImage.image = GlobalVariables.wardrobeImages[indexPath.row]
                print("Garment index \(GlobalVariables.wardrobeImages[indexPath.row])")
               
                
           
                self.garmentCollectionView.reloadData()
                
            }
        })

     

        
        
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        
        case 0 :
            
          topImageView.image = garments[0]
            
        case 1 :
            
            topImageView.image = garments[1]
            
        case 2 :
            
           bottomImageView.image = garments[2]
            
        case 3 :
            
            bottomImageView.image = garments[3]
            
        case 4:
            
            topImageView.image = garments[4]
            
        
        
        
        default :
        
        print("No image found")
    
        }
    }
    
    
   

}

extension View1 : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       
        return CGSize(width: 60, height: 60)
    }
}


extension UIImageView {
    
    func loadImageUsingUrlString(urlString : String) {
        
        let url = NSURL(string: urlString)
        print("teset")
     
        NSURLSession.sharedSession().dataTaskWithURL(url! , completionHandler: { (data, response, error) in
            
            
            if error != nil {
                print(error)
                
                return
                
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.image = UIImage(data: data!)
             
                
            })
            
            
        }).resume()
        
        
    }
    
    
    
}








