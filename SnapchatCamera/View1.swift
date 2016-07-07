//
//  View1.swift

//

import UIKit
import Alamofire
import AlamofireImage
import CircleSlider
import Kingfisher
import Haneke




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

        items = ["http://imgs.xkcd.com/comics/election.png",
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
            "http://imgs.xkcd.com/comics/important_life_lesson.png" ]
        
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
     var items : [String] = []
    
   
    
    

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
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
        
        
        switch GlobalVariables.globalGarmentType[indexPath.row] {
            
        case "TopWear":
             print(GlobalVariables.globalModelUrl[indexPath.row])
            
            self.topImageView.hnk_setImageFromURL(NSURL(string: GlobalVariables.globalModelUrl[indexPath.row])!)
            
        case "BottomWear" :
            
            self.bottomImageView.hnk_setImageFromURL(NSURL(string: GlobalVariables.globalModelUrl[indexPath.row])!)
            
        default:
            print("Not founf")
        }
        
  
    }
    
    
   

}

extension View1 : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       
        return CGSize(width: 60, height: 60)
    }
}






