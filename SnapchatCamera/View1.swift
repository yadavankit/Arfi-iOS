//
//  View1.swift

//

import UIKit
import Alamofire
import AlamofireImage


class View1: UIViewController {
    @IBOutlet var botImageView: UIImageView!
    @IBOutlet var topImageView: UIImageView!

    
    var topUploaded = false
    
    let kScreenSize = UIScreen.mainScreen().bounds.size
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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

}
