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
import JKNotificationPanel
import Mixpanel
import SDWebImage




class View1: UIViewController  {
    
    
    struct Model {
        var imageName : String
        
        init(imageName : String){
            self.imageName = imageName
    
        }
    }
    
    var model = [Model]()
    
    
    
    
 var mitems = ["http://imgs.xkcd.com/comics/election.png",
    "http://imgs.xkcd.com/comics/scantron.png",
    "http://imgs.xkcd.com/comics/secretary_part_5.png",
    "http://imgs.xkcd.com/comics/secretary_part_4.png",
    "http://imgs.xkcd.com/comics/secretary_part_3.png",
    "http://imgs.xkcd.com/comics/secretary_part_2.png",
    "http://imgs.xkcd.com/comics/secretary_part_1.png",
    "http://imgs.xkcd.com/comics/actuarial.png",
    "http://imgs.xkcd.com/comics/scrabble.png",
    "http://imgs.xkcd.com/comics/twitter.png",
    "http://imgs.xkcd.com/comics/morning_routine.png",
    "http://imgs.xkcd.com/comics/going_west.png",
    "http://imgs.xkcd.com/comics/steal_this_comic.png",
    "http://imgs.xkcd.com/comics/numerical_sex_positions.png",
    "http://imgs.xkcd.com/comics/i_am_not_a_ninja.png",
    "http://imgs.xkcd.com/comics/depth.png",
    "http://imgs.xkcd.com/comics/flash_games.png",
    "http://imgs.xkcd.com/comics/fiction_rule_of_thumb.png",
    "http://imgs.xkcd.com/comics/height.png",
    "http://imgs.xkcd.com/comics/listen_to_yourself.png",
    "http://imgs.xkcd.com/comics/spore.png",
    "http://imgs.xkcd.com/comics/tones.png",
    "http://imgs.xkcd.com/comics/the_staple_madness.png",
    "http://imgs.xkcd.com/comics/typewriter.png",
    "http://imgs.xkcd.com/comics/one-sided.png",
    "http://imgs.xkcd.com/comics/further_boomerang_difficulties.png",
    "http://imgs.xkcd.com/comics/turn-on.png",
    "http://imgs.xkcd.com/comics/still_raw.png",
    "http://imgs.xkcd.com/comics/house_of_pancakes.png",
    "http://imgs.xkcd.com/comics/aversion_fads.png",
    "http://imgs.xkcd.com/comics/the_end_is_not_for_a_while.png",
    "http://imgs.xkcd.com/comics/improvised.png",
    "http://imgs.xkcd.com/comics/fetishes.png",
    "http://imgs.xkcd.com/comics/x_girls_y_cups.png",
    "http://imgs.xkcd.com/comics/moving.png",
    "http://imgs.xkcd.com/comics/quantum_teleportation.png",
    "http://imgs.xkcd.com/comics/rba.png",
    "http://imgs.xkcd.com/comics/voting_machines.png",
    "http://imgs.xkcd.com/comics/freemanic_paracusia.png",
    "http://imgs.xkcd.com/comics/google_maps.png",
    "http://imgs.xkcd.com/comics/paleontology.png",
    "http://imgs.xkcd.com/comics/holy_ghost.png",
    "http://imgs.xkcd.com/comics/regrets.png",
    "http://imgs.xkcd.com/comics/frustration.png",
    "http://imgs.xkcd.com/comics/cautionary.png",
    "http://imgs.xkcd.com/comics/hats.png",
    "http://imgs.xkcd.com/comics/rewiring.png",
    "http://imgs.xkcd.com/comics/upcoming_hurricanes.png",
    "http://imgs.xkcd.com/comics/mission.png",
    "http://imgs.xkcd.com/comics/impostor.png",
    "http://imgs.xkcd.com/comics/the_sea.png",
    "http://imgs.xkcd.com/comics/things_fall_apart.png",
    "http://imgs.xkcd.com/comics/good_morning.png",
    "http://imgs.xkcd.com/comics/too_old_for_this_shit.png",
    "http://imgs.xkcd.com/comics/in_popular_culture.png",
    "http://imgs.xkcd.com/comics/i_am_not_good_with_boomerangs.png",
    "http://imgs.xkcd.com/comics/macgyver_gets_lazy.png",
    "http://imgs.xkcd.com/comics/know_your_vines.png",
    "http://imgs.xkcd.com/comics/xkcd_loves_the_discovery_channel.png",
    "http://imgs.xkcd.com/comics/babies.png",
    "http://imgs.xkcd.com/comics/road_rage.png",
    "http://imgs.xkcd.com/comics/thinking_ahead.png",
    "http://imgs.xkcd.com/comics/internet_argument.png",
    "http://imgs.xkcd.com/comics/suv.png",
    "http://imgs.xkcd.com/comics/how_it_happened.png",
    "http://imgs.xkcd.com/comics/purity.png",
    "http://imgs.xkcd.com/comics/xkcd_goes_to_the_airport.png",
    "http://imgs.xkcd.com/comics/journal_5.png",
    "http://imgs.xkcd.com/comics/journal_4.png",
    "http://imgs.xkcd.com/comics/delivery.png",
    "http://imgs.xkcd.com/comics/every_damn_morning.png",
    "http://imgs.xkcd.com/comics/fantasy.png",
    "http://imgs.xkcd.com/comics/starwatching.png",
    "http://imgs.xkcd.com/comics/bad_timing.png",
    "http://imgs.xkcd.com/comics/geohashing.png",
    "http://imgs.xkcd.com/comics/fortune_cookies.png",
    "http://imgs.xkcd.com/comics/security_holes.png",
    "http://imgs.xkcd.com/comics/finish_line.png",
    "http://imgs.xkcd.com/comics/a_better_idea.png",
    "http://imgs.xkcd.com/comics/making_hash_browns.png",
    "http://imgs.xkcd.com/comics/jealousy.png",
    "http://imgs.xkcd.com/comics/forks_and_spoons.png",
    "http://imgs.xkcd.com/comics/stove_ownership.png",
    "http://imgs.xkcd.com/comics/the_man_who_fell_sideways.png",
    "http://imgs.xkcd.com/comics/zealous_autoconfig.png",
    "http://imgs.xkcd.com/comics/restraining_order.png",
    "http://imgs.xkcd.com/comics/mistranslations.png",
    "http://imgs.xkcd.com/comics/new_pet.png",
    "http://imgs.xkcd.com/comics/startled.png",
    "http://imgs.xkcd.com/comics/techno.png",
    "http://imgs.xkcd.com/comics/math_paper.png",
    "http://imgs.xkcd.com/comics/electric_skateboard_double_comic.png",
    "http://imgs.xkcd.com/comics/overqualified.png",
    "http://imgs.xkcd.com/comics/cheap_gps.png",
    "http://imgs.xkcd.com/comics/venting.png",
    "http://imgs.xkcd.com/comics/journal_3.png",
    "http://imgs.xkcd.com/comics/convincing_pickup_line.png",
    "http://imgs.xkcd.com/comics/1000_miles_north.png",
    "http://imgs.xkcd.com/comics/large_hadron_collider.png",
    "http://imgs.xkcd.com/comics/important_life_lesson.png"]










    @IBOutlet var botImageView: UIImageView!
    @IBOutlet var topImageView: UIImageView!


    let mixpanel : Mixpanel = Mixpanel.sharedInstance()
    let panel : JKNotificationPanel = JKNotificationPanel()
    @IBOutlet var garmentTop: NSLayoutConstraint!
    var test = 6
    @IBOutlet var modelIndicator: UIActivityIndicatorView!


    @IBOutlet var doneOutlet: UIButton!

    @IBOutlet var background: QuestionsCollectionView!
    @IBOutlet var garmentCollectionView: UICollectionView!


    @IBAction func refreshAction(sender: AnyObject) {

    
    }

      var garments = [UIImage(named : "1Model"),UIImage(named : "2Model"),UIImage(named : "3Model"),UIImage(named : "4Model" ) , UIImage(named : "5Model" ) ]

    var garmentsOption = [UIImage(named : "1Garment"),UIImage(named : "2Garment"),UIImage(named : "3Garment"),UIImage(named : "4Garment") , UIImage(named : "5Garment" )]
    var condition = false
   
    @IBOutlet var bottomImageView: UIImageView!
    var topUploaded = false
   
    
    let kScreenSize = UIScreen.mainScreen().bounds.size
    
    override func viewDidAppear(animated: Bool) {
       
    }
    @IBAction func showprepopulated(sender: AnyObject) {

        let test = Prepopulated.instanceFromNib()
        test.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.view.addSubview(test)

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.mainQuestionview.hidden = false
        
        let value = NSUserDefaults.standardUserDefaults().objectForKey("freshLogin")
        let realValue = String(value)
        
//        if realValue.containsString("false"){
//            
//            self.mainQuestionview.hidden = true
//        }
        
        //modelIndicator.hidden = true
        
  
        let triggerTime = (Int64(NSEC_PER_SEC) * 4)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            
           // self.garmentCollectionView.hidden = false
            print("Totla number of garments")
            print(GlobalVariables.globalNumberOfGarments)
            print(GlobalVariables.modelStatus)
          
            if GlobalVariables.globalTopAndBottom.count > 0 {
                print("greater than zero is running")
                
                print(GlobalVariables.modelStatus)
                let myModelStatus = GlobalVariables.modelStatus
                
            if   (myModelStatus == "nil"){
                                    
            print("greater than zero and model nil is running")
            print(GlobalVariables.modelStatus)
                
                }else{
            print("greater than zero else is running")
                                  
                                    
                                }
            }
            
            else
            {
     
            }
            
        })
        
        
    
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
                  
                    
                } else {
                    
               
                }
            }
            else
            {
                
              
                
            }

                
        } else {
            
            self.topImageView.image = UIImage(named: "fairtriangletop")
            self.bottomImageView.image = UIImage(named: "fairtrianglebottom")
            
            
            
            
        }
       
        
        
 
        
    
        
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
//     
    let current_user_id = GlobalVariables.globalFacebookId!
    let bust = modelObject.bust
    let hip = modelObject.hip
    let waist = modelObject.waist
    let height = modelObject.height
    let complexion =    "Dark"         // modelObject.complexion
    NSUserDefaults.standardUserDefaults().setObject(current_user_id, forKey: "usr_id")
    NSUserDefaults.standardUserDefaults().setObject(bust, forKey: "bust")
    NSUserDefaults.standardUserDefaults().setObject(hip, forKey: "hip")
    NSUserDefaults.standardUserDefaults().setObject(waist, forKey: "waist")
    NSUserDefaults.standardUserDefaults().setObject(height, forKey: "height")
    NSUserDefaults.standardUserDefaults().setObject(complexion, forKey: "complexion")
        
 
      
       
       print("http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/populate?user_id=\(GlobalVariables.globalFacebookId!)&garments_selected=\(GlobalVariables.globalStarterPack.description)&user_name=\(GlobalVariables.globalUserName!.componentsSeparatedByString(" ")[0])&bust=32&hip=32&waist=32&height=142&complexion=Dark")
       
//        //7000/processing_panel_populate?user_id=fbid&garment_selected = string&user_name & bust
//        
       Alamofire.request(.POST, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/populate?user_id=1069249093136307&garments_selected=[1,2]&user_name=Aditya&bust=32&hip=32&waist=32&height=142&complexion=Dark")
          .validate()
          .responseJSON { response in
                print(response)
            
                print("Model Garment in saved on Server")
                self.panel.timeUntilDismiss = 3
//                let mixpanel = Mixpanel.sharedInstance()
//                let properties = ["LoginCompleted": "Done"]
//                mixpanel.track("Completed Model", properties: properties)
              //  self.panel.showNotify(withStatus: .SUCCESS, inView: self.view, message: "Your garments will now start getting uploaded, Happy Uploading 😀")
          
// 
//                
        }
        
         NSUserDefaults.standardUserDefaults().setObject("true", forKey: "freshLogin")
       self.mainQuestionview.hidden = true
        
       getGarmentInformation()

    }
    
    func getGarmentInformation(){
        
        print("GETTING GARMENT INFORMATION")
        
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
                    arrayCount = (json["garments"].count)
                    
                    
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["garment_style"].string{
                            
                            
                            GlobalVariables.garmentInformation.append(quote)
                            print(GlobalVariables.garmentInformation[number])
                            
                            
                            
                            number += 1
                            print("garment info Added \(number)")
                        }
                        
                        
                        
                        if number == arrayCount! {
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                           self.getModelWardrobeImages()
                        }
                    }
                    
                    
                }}
    }
    
    func getModelWardrobeImages(){ //VIEW 1
        
        var arrayCount : Int?
        
        print("WARDROBEIMAGES RAN")
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
                    
                    
                    arrayCount = (json["garments"].count)
                    GlobalVariables.finalGarmentCount = arrayCount!
                    
                    print(arrayCount!)
                    print("final garment is")
                    
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        if let quote = json["garments"][number]["wardrobe_url"].string{
                            
                            
                            GlobalVariables.globalTopAndBottom.append(quote)
                            
                            print("appending now")
                            
                            number += 1
                            print(number)
                        }
                        
                        
                        
                        if number == arrayCount! {
                            
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                            print("Now TrUE")
                            for i in 0..<GlobalVariables.globalTopAndBottom.count {
                                
                                self.model.append(Model(imageName:GlobalVariables.globalTopAndBottom[i]))
                                
                            }
                            
                            self.garmentCollectionView.reloadData()
                            
                            
                        }
                        
                    }
                    
                    
                }}
    
        
        
    }


    
    func getProcessedImageData(){
        
        print("GETTING Processed INFORMATION")
        
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    print(jsonValue)
                    print("THis is  a json")
                    
                    
                    
                    arrayCount = (json["garments"].count)
                    
                    print(json["garments"][1]["processed"].stringValue)
                    print(arrayCount!)
                    
                    
                    var number = 0
                    
                    
                    while number  < arrayCount! {
                        let quote = json["garments"][1]["processed"].stringValue
                        
                        print("printing quote")
                        print(quote)
                        
                        GlobalVariables.processedImageStatus.append(quote)
                        
                        number += 1
                        print("garment Processed \(number)")
                        
                        
                        
                        
                        if number == arrayCount! {
                            
                            GlobalVariables.globalSafeToFetch = true
                            
                            print("Now TrUE")
                        }
                    }
                }}
        
    }
    

    @IBOutlet var mainQuestionview: UIView!
    @IBOutlet var garmentCollectionViewTop: NSLayoutConstraint!
    
    func showTheModel(){
        
        //http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=1069249093136307
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_all_user_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    print(json)
                    
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
            self.topImageView.image = UIImage(named: "darkinvertedtriangletop")
            self.bottomImageView.image = UIImage(named: "darkinvertedtrianglebottom")
            
            NSUserDefaults.standardUserDefaults().setObject("darkinvertedtriangletop", forKey: "topImage")
            NSUserDefaults.standardUserDefaults().setObject("darkinvertedtrianglebottom", forKey: "botImage")
            
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
        
        
        let mixpanel = Mixpanel.sharedInstance()
        let properties = ["Model Started": "Done"]
        mixpanel.track("Started Creating Model", properties: properties)
        
              print("This is the Count \(GlobalVariables.finalGarmentCount)")
        
        if GlobalVariables.finalGarmentCount! == 0{
            
      
            
            let alert = UIAlertView(title: "Cannot create model", message: "To create model you need to upload a garment", delegate: self, cancelButtonTitle: "Ok")
            alert.show()
            
            
            
        } else {
        
        self.mixpanel.track("\(GlobalVariables.globalUserName!) has has begun creating Model.")
            
        self.modelButton.hidden = true
       // self.doneOutlet.hidden = false
       
        self.questionCollectionViewCell.hidden = false
       
        NSUserDefaults.standardUserDefaults().setObject("true", forKey: "garmentSelected")
        
        GlobalVariables.isBodyTypeSelected = true
            
            let mixpanel = Mixpanel.sharedInstance()
            let properties = ["LoginCompleted": "Done"]
            mixpanel.track("Started Creating Model", properties: properties)
        
        }
    }
    
   
    

    @IBOutlet var CollectionViewMover: UIButton!
    
}


extension View1 : UICollectionViewDataSource {
    

    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
          let sectionKey = NSUserDefaults.standardUserDefaults()
         _ = (sectionKey.objectForKey("section"))
        // let mytest = test!.integerValue
       
       
        if GlobalVariables.globalTopAndBottom.count > 0 {
            
            return GlobalVariables.globalBottomWardrobe.count
         
            
            
        } else {
            
        return GlobalVariables.globalBottomWardrobe.count
       

        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        // This will cancel all unfinished downloading task when the cell disappearing.
        (cell as! ModelGarmentCollectionViewCell).garmentImage.kf_cancelDownloadTask()
    }
    

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        self.garmentCollectionView.registerNib((UINib.init(nibName: "ModelGarmentCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "modelCell")
        
        
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("modelCell", forIndexPath: indexPath) as! ModelGarmentCollectionViewCell
        
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 5)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
           
            
            if  GlobalVariables.globalTopAndBottom.count > 0 {
                print(GlobalVariables.globalTopAndBottom.count)
                print(GlobalVariables.processedImageStatus.count)
                print(GlobalVariables.modelStatus)
                
              
            
                let URLString = GlobalVariables.globalTopAndBottom[indexPath.row]
                print(URLString)
         
             let URL = NSURL(string: URLString)!
               
                cell.garmentImage.kf_showIndicatorWhenLoading = true
          
                
              
                
                
                cell.garmentImage.kf_setImageWithURL(URL, placeholderImage: nil,
                    optionsInfo: [.Transition(ImageTransition.Fade(1))],
                    progressBlock: { receivedSize, totalSize in
                        print("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
                    },
                    completionHandler: { image, error, cacheType, imageURL in
                        print("\(indexPath.row + 1): Finished")
                        
                })
            }
          
            
            
        })
        

        
    return cell
    
    }
    

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
   
        
        
        switch GlobalVariables.globalGarmentType[indexPath.row] {
            
        case "TopWear":

            if GlobalVariables.garmentInformation[indexPath.row].containsString("Long") {
                
                
               self.mixpanel.track("\(GlobalVariables.globalUserName!) just viewed a Long Topwear on model.")
               topImageView.superview?.bringSubviewToFront(topImageView)
              
                 self.topImageView.hnk_setImageFromURL(NSURL(string: GlobalVariables.globalModelUrl[indexPath.row])!)
                
            
                
                print("IndexPath : \(indexPath.row) + The top is long")
                
            } else if GlobalVariables.garmentInformation[indexPath.row].containsString("Waist") {
               
                
                self.mixpanel.track("\(GlobalVariables.globalUserName!) just viewed a Waist Topwear on model.")
                topImageView.superview?.bringSubviewToFront(topImageView)
                self.topImageView.hnk_setImageFromURL(NSURL(string: GlobalVariables.globalModelUrl[indexPath.row])!)
                
                print("IndexPath : \(indexPath.row) + The top is waist")
                
                
            } else if GlobalVariables.garmentInformation[indexPath.row].containsString("Short"){
                
                self.mixpanel.track("\(GlobalVariables.globalUserName!) just viewed a Short Topwear on model.")
                
                bottomImageView.superview?.bringSubviewToFront(bottomImageView)
                self.topImageView.hnk_setImageFromURL(NSURL(string: GlobalVariables.globalModelUrl[indexPath.row])!)
                
                print("IndexPath : \(indexPath.row) + The top is Short")
                
                
                
                
            }else if GlobalVariables.garmentInformation[indexPath.row].containsString("Crop"){
                
                bottomImageView.superview?.bringSubviewToFront(bottomImageView)
                self.topImageView.hnk_setImageFromURL(NSURL(string: GlobalVariables.globalModelUrl[indexPath.row])!)
                
                print("IndexPath : \(indexPath.row) + The top is Crop")
                

            }
            else
            {
                print("Else for topwear running")
                self.mixpanel.track("\(GlobalVariables.globalUserName!) just viewed Topwear on model.")
                self.topImageView.hnk_setImageFromURL(NSURL(string: GlobalVariables.globalModelUrl[indexPath.row])!)
                self.view.bringSubviewToFront(self.topImageView)
                
            }
     
            
        case "BottomWear" :
            
            print("This is a bottommmmmmm")
    
            
            
            
        self.bottomImageView.hnk_setImageFromURL(NSURL(string: GlobalVariables.globalModelUrl[indexPath.row])!)
            //self.bottomImageView.bringSubviewToFront(bottomImageView)
            
                        self.mixpanel.track("\(GlobalVariables.globalUserName!) just viewed a Bottomwear on model.")
            
        default:
            print("Not found")
        }
        
//        modelIndicator.stopAnimating()
//        modelIndicator.hidden = true
        
  
    }
    
    
   

}

extension View1 : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       
        return CGSize(width: 75, height: 75)
    }
}






