//
//  View1.swift

//

import UIKit
import Alamofire
import AlamofireImage
import CircleSlider
import Kingfisher
import Haneke
import SwiftyJSON




class View1: UIViewController  {
    @IBOutlet var botImageView: UIImageView!
    @IBOutlet var topImageView: UIImageView!
    
    @IBOutlet var garmentTop: NSLayoutConstraint!
    var test = 6
    

    @IBOutlet var doneOutlet: UIButton!
   
    @IBOutlet var garmentCollectionView: UICollectionView!

    
      var garments = [UIImage(named : "1Model"),UIImage(named : "2Model"),UIImage(named : "3Model"),UIImage(named : "4Model" ) , UIImage(named : "5Model" ) ]
    
    var garmentsOption = [UIImage(named : "1Garment"),UIImage(named : "2Garment"),UIImage(named : "3Garment"),UIImage(named : "4Garment") , UIImage(named : "5Garment" )]
    var condition = false
   
    @IBOutlet var bottomImageView: UIImageView!
    var topUploaded = false
   
    
    let kScreenSize = UIScreen.mainScreen().bounds.size
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        if(NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce"))
        {
            // app already launched
            
            print("The bool")
            print(GlobalVariables.isBodyTypeSelected)
            
            
            let mainString = NSUserDefaults.standardUserDefaults().objectForKey("garmentSelected")
            
            
            
            let mtString = mainString as? String
            let topImageString = NSUserDefaults.standardUserDefaults().objectForKey("topImage")
            let topImage = topImageString as? String
            let botImageString = NSUserDefaults.standardUserDefaults().objectForKey("botImage")
            let botImage = botImageString as? String
            
            if mainString != nil {
                
                
                if mtString!.containsString("true"){
                    
                    self.topImageView.image = UIImage(named: topImage!)
                    self.bottomImageView.image = UIImage(named: botImage!)
                    self.mainQuestionview.hidden = true
                    
                } else {
                    
                    self.mainQuestionview.hidden = false
                }
            }
            else
            {
                
                self.mainQuestionview.hidden = false
                
            }

                
        } else {
            
            self.topImageView.image = UIImage(named: "fairtriangletop")
            self.bottomImageView.image = UIImage(named: "fairtrianglebottom")
            
            self.mainQuestionview.hidden = false
            
            
        }
       
        
        
 
        
        self.questionCollectionViewCell.hidden = true
        
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
    
    
   
    @IBAction func doneAction(sender: AnyObject) {
        self.mainQuestionview.hidden = true
        let current_user_id = GlobalVariables.globalFacebookId!
        let bust = modelObject.bust
        let hip = modelObject.hip
        let waist = modelObject.waist
        let height = modelObject.height
        let complexion = modelObject.complexion
        NSUserDefaults.standardUserDefaults().setObject(current_user_id, forKey: "usr_id")
        NSUserDefaults.standardUserDefaults().setObject(bust, forKey: "bust")
        NSUserDefaults.standardUserDefaults().setObject(hip, forKey: "hip")
        NSUserDefaults.standardUserDefaults().setObject(waist, forKey: "waist")
        NSUserDefaults.standardUserDefaults().setObject(height, forKey: "height")
        NSUserDefaults.standardUserDefaults().setObject(complexion, forKey: "complexion")
        
        Alamofire.request(.POST, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/set_model_size", parameters: ["user_id": GlobalVariables.globalFacebookId!,"bust_size": bust,"height_size": height,"complexion": complexion,"waist_size": waist, "hip_size": hip])
            .validate()
            .responseJSON { response in
                print(current_user_id)
                print("Model Garment in saved on Server")
                self.showTheModel()
        }

    }
    @IBOutlet var mainQuestionview: UIView!
    @IBOutlet var garmentCollectionViewTop: NSLayoutConstraint!
    
    func showTheModel(){
        
        
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
                    
                    arrayCount = (json["garments"].count)
                    GlobalVariables.finalGarmentCount = arrayCount!
                    
                    print(arrayCount!)
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["model_body_type"].string{
                            
                            GlobalVariables.modelBodyType = quote
                         
                    
                            
                            number += 1
                            print(number)
                        }
                        
                        
                        
                        if number == arrayCount! {
                            
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                            self.getComplexion()
                            
                            
                        }
                        
                    }
                    
                    
                    
                }}

        
        
    }
    
    func getComplexion(){
        
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
                    
                    arrayCount = (json["garments"].count)
                    GlobalVariables.finalGarmentCount = arrayCount!
                    
                    print(arrayCount!)
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["other_info"].string{
                            
                            GlobalVariables.complexionType = quote
                            
                            
                            
                            number += 1
                            print(number)
                        }
                        
                        
                        
                        if number == arrayCount! {
                            
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                            self.showComplexion()
                            
                            
                        }
                        
                    }
                    
                    
                    
                }}
        
        
        
    }
    
    func showComplexion(){
        
        print("complexion running")
        
        print(GlobalVariables.complexionType! + GlobalVariables.modelBodyType!)
        
        if GlobalVariables.complexionType == "Medium" && GlobalVariables.modelBodyType == "Triangle" {
            
            self.topImageView.image = UIImage(named: "mediumtriangletop")
            self.bottomImageView.image = UIImage(named: "mediumtrianglebottom")
            
            NSUserDefaults.standardUserDefaults().setObject("mediumtriangletop", forKey: "topImage")
             NSUserDefaults.standardUserDefaults().setObject("mediumtrianglebottom", forKey: "botImage")
            
            
            print("triangle")
            
        }else if GlobalVariables.complexionType == "Fair" && GlobalVariables.modelBodyType == "Triangle" {
            
            self.topImageView.image = UIImage(named: "fairtriangletop")
            self.bottomImageView.image = UIImage(named: "fairtrianglebottom")
            
            NSUserDefaults.standardUserDefaults().setObject("fairtriangletop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("fairtrianglebottom", forKey: "botImage")
            
            
             print("triangle")
            
            
        } else if GlobalVariables.complexionType == "Dark" && GlobalVariables.modelBodyType == "Triangle" {
            
            self.topImageView.image = UIImage(named: "darktriangletop")
            self.bottomImageView.image = UIImage(named: "darktrianglebottom")
            
            NSUserDefaults.standardUserDefaults().setObject("darktriangletop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("darktrianglebottom", forKey: "botImage")
            
             print("triangle")
            
        }else if GlobalVariables.complexionType == "Medium" && GlobalVariables.modelBodyType == "Inverted Triangle" {
            
            self.topImageView.image = UIImage(named: "mediuminvertedtriangletop")
            self.bottomImageView.image = UIImage(named: "mediuminvertedtrianglebottom")
            
            NSUserDefaults.standardUserDefaults().setObject("mediuminvertedtriangletop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("mediuminvertedtrianglebottom", forKey: "botImage")
             print("invertriangle")
            
            
        } else if GlobalVariables.complexionType == "Fair" && GlobalVariables.modelBodyType == "Inverted Triangle" {
            self.topImageView.image = UIImage(named: "fairinvertedtriangletop")
            self.bottomImageView.image = UIImage(named: "fairinvertedtrianglebottom")
            
            NSUserDefaults.standardUserDefaults().setObject("fairinvertedtriangletop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("fairinvertedtrianglebottom", forKey: "botImage")

                print("invertriangle")
            
            
        }else if GlobalVariables.complexionType == "Dark"  && GlobalVariables.modelBodyType == "Inverted Triangle" {
            self.topImageView.image = UIImage(named: "fairinvertedtriangletop")
            self.bottomImageView.image = UIImage(named: "fairinvertedtrianglebottom")
            
            NSUserDefaults.standardUserDefaults().setObject("fairinvertedtriangletop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("fairinvertedtrianglebottom", forKey: "botImage")
            
                print("invertriangle")
            
        }else if GlobalVariables.complexionType == "Medium" && GlobalVariables.modelBodyType == "Hour Glass"{
            self.topImageView.image = UIImage(named: "mediumHourglasstop")
            self.bottomImageView.image = UIImage(named: "mediumHourglassbottom")
            
            NSUserDefaults.standardUserDefaults().setObject("mediumHourglasstop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("mediumHourglassbottom", forKey: "botImage")
            
                print("hour")
            
            
        } else if GlobalVariables.complexionType == "Fair" && GlobalVariables.modelBodyType == "Hour Glass" {
            
            self.topImageView.image = UIImage(named: "fairHourglasstop")
            self.bottomImageView.image = UIImage(named: "fairHourglassbottom")
            
            NSUserDefaults.standardUserDefaults().setObject("fairHourglasstop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("fairHourglassbottom", forKey: "botImage")
            
                print("hour")
            
        } else if GlobalVariables.complexionType == "Dark" && GlobalVariables.modelBodyType == "Hour Glass" {
            
            self.topImageView.image = UIImage(named: "darkHourglasstop")
            self.bottomImageView.image = UIImage(named: "darkHourglassbottom")
            NSUserDefaults.standardUserDefaults().setObject("darkHourglasstop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("darkHourglassbottom", forKey: "botImage")
            
                print("hour")
            
        }else if GlobalVariables.complexionType == "Medium" && GlobalVariables.modelBodyType == "Rectangular" {
            self.topImageView.image = UIImage(named: "mediumrectangletop")
            self.bottomImageView.image = UIImage(named: "mediumrectanglebottom")
            
            NSUserDefaults.standardUserDefaults().setObject("mediumrectangletop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("mediumrectanglebottom", forKey: "botImage")
            
            
                print("rect")
            
        } else if GlobalVariables.complexionType == "Fair" && GlobalVariables.modelBodyType == "Rectangular" {
            
            self.topImageView.image = UIImage(named: "fairrectangletop")
            self.bottomImageView.image = UIImage(named: "fairrectanglebottom")
            NSUserDefaults.standardUserDefaults().setObject("fairrectangletop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("fairrectanglebottom", forKey: "botImage")
                print("rect")
            
            
        }else if GlobalVariables.complexionType == "Dark" && GlobalVariables.modelBodyType == "Rectangular" {
            
            self.topImageView.image = UIImage(named: "fairrectangletop")
            self.bottomImageView.image = UIImage(named: "fairrectanglebottom")
            
            NSUserDefaults.standardUserDefaults().setObject("fairrectangletop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("fairrectanglebottom", forKey: "botImage")
            
                print("rect")
            
            
        }else if GlobalVariables.complexionType == "Medium" && GlobalVariables.modelBodyType == "Oval" {
            self.topImageView.image = UIImage(named: "mediumOvaltop")
            self.bottomImageView.image = UIImage(named: "mediumOvalbottom")
            
            NSUserDefaults.standardUserDefaults().setObject("mediumOvaltop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("mediumOvalbottom", forKey: "botImage")
                print("oval")
            
            
        }else if GlobalVariables.complexionType == "Fair" && GlobalVariables.modelBodyType == "Oval" {
            
            self.topImageView.image = UIImage(named: "fairOvaltop")
            self.bottomImageView.image = UIImage(named: "fairOvalbottom")
            
            NSUserDefaults.standardUserDefaults().setObject("fairOvaltop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("fairOvalbottom", forKey: "botImage")
            
                print("oval")
            
            
        }else if GlobalVariables.complexionType == "Dark" && GlobalVariables.modelBodyType == "Oval" {
            
            self.topImageView.image = UIImage(named: "darkOvaltop")
            self.bottomImageView.image = UIImage(named: "darkOvalbottom")
            
            NSUserDefaults.standardUserDefaults().setObject("darkOvaltop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("darkOvalbottom", forKey: "botImage")
            
                print("oval")
            
            
        }

      GlobalVariables.isBodyTypeSelected = true
    
        
        
        
    }
    
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
     var items : [String] = []
    
    @IBOutlet var modelButton: UIButton!
   
    @IBOutlet var questionCollectionViewCell: QuestionsCollectionView!
    
    @IBAction func getModelDetails(sender: AnyObject) {
        
        print(GlobalVariables.finalGarmentCount!)
        
        
        if GlobalVariables.finalGarmentCount == 0 {
            
            let alert = UIAlertView(title: "Cannot create model", message: "To create model you need to upload a garment", delegate: self, cancelButtonTitle: "Ok")
            alert.show()
            
            
            
        } else {
        
        self.modelButton.hidden = true
        self.doneOutlet.hidden = false
       
        self.questionCollectionViewCell.hidden = false
       
        NSUserDefaults.standardUserDefaults().setObject("true", forKey: "garmentSelected")
        
        GlobalVariables.isBodyTypeSelected = true
        
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
  
          let sectionKey = NSUserDefaults.standardUserDefaults()
         _ = (sectionKey.objectForKey("section"))
        // let mytest = test!.integerValue
       
       
        if GlobalVariables.globalTopAndBottom.count > 0 {
            
            return GlobalVariables.globalTopAndBottom.count
            
        } else {
            
            return 1
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        self.garmentCollectionView.registerNib((UINib.init(nibName: "ModelGarmentCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "modelCell")
        
        
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("modelCell", forIndexPath: indexPath) as! ModelGarmentCollectionViewCell
        
        if  GlobalVariables.globalTopAndBottom.count > 0 {
            
            let URLString =  GlobalVariables.globalTopAndBottom[indexPath.row]
            let URL = NSURL(string:URLString)!
            cell.garmentImage.hnk_setImageFromURL(URL)
           
        }
  
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 5)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
           self.garmentCollectionView.reloadData()
            
        })
        
    
        
    return cell
    
    }
    
    func arrangeGarment(selectedTop : String){
        
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
        
        
        switch GlobalVariables.globalGarmentType[indexPath.row] {
            
        case "TopWear":

            if GlobalVariables.garmentInformation[indexPath.row].containsString("Long") {
                
               topImageView.superview?.bringSubviewToFront(topImageView)
                 self.topImageView.hnk_setImageFromURL(NSURL(string: GlobalVariables.globalModelUrl[indexPath.row])!)
                
                print("IndexPath : \(indexPath.row) + The top is long")
                
            } else if GlobalVariables.garmentInformation[indexPath.row].containsString("Waist") {
                
                topImageView.superview?.bringSubviewToFront(topImageView)
                self.topImageView.hnk_setImageFromURL(NSURL(string: GlobalVariables.globalModelUrl[indexPath.row])!)
                
                print("IndexPath : \(indexPath.row) + The top is waist")
                
                
            } else if GlobalVariables.garmentInformation[indexPath.row].containsString("Short"){
                
                bottomImageView.superview?.bringSubviewToFront(bottomImageView)
                self.topImageView.hnk_setImageFromURL(NSURL(string: GlobalVariables.globalModelUrl[indexPath.row])!)
                
                print("IndexPath : \(indexPath.row) + The top is Short")
                
                
                
                
            }else if GlobalVariables.garmentInformation[indexPath.row].containsString("Crop"){
                
                bottomImageView.superview?.bringSubviewToFront(bottomImageView)
                self.topImageView.hnk_setImageFromURL(NSURL(string: GlobalVariables.globalModelUrl[indexPath.row])!)
                
                print("IndexPath : \(indexPath.row) + The top is Crop")
                

            }
     
            
        case "BottomWear" :
            
    
        self.bottomImageView.hnk_setImageFromURL(NSURL(string: GlobalVariables.globalModelUrl[indexPath.row])!)
       
    
            
        default:
            print("Not founf")
        }
        
  
    }
    
    
   

}

extension View1 : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       
        return CGSize(width: 65, height: 65)
    }
}






