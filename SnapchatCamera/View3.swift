//
//  View3.swift
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class View3: UIViewController , UITableViewDataSource {
    
    
var categories = ["Top Wear" , "Bottom Wear" ]
    
    @IBOutlet var HelloUser: UILabel!
    
    @IBOutlet var myTableView: UIView!
   
    @IBOutlet var realTableView: UITableView!
    
    @IBOutlet var emptyWardrobeImage: UIImageView!
    @IBOutlet var emptyWardrobe: UILabel!
    override func viewDidLoad() {
        
         hideAndUnhide()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        let userDetails = NSUserDefaults.standardUserDefaults().objectForKey("fb_user_name")
        
        self.HelloUser.text = "Hello, User"
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 3)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
         
              self.HelloUser.text = "Hello, \(userDetails!.componentsSeparatedByString(" ")[0])"
            self.hideAndUnhide()
           
            
        })
        
      
 
        
    }
    
    func hideAndUnhide(){
        
        if GlobalVariables.globalTopAndBottom.count == 0 {
            
            self.realTableView.hidden = true
            self.emptyWardrobe.hidden = false
            self.emptyWardrobeImage.hidden = false
            
        } else {
            self.realTableView.hidden = false
            self.emptyWardrobe.hidden = true
            self.emptyWardrobeImage.hidden = true
           
        }
    }
   
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }
    
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView.registerNib((UINib.init(nibName: "CategoryRow", bundle: nil)), forCellReuseIdentifier: "cell")
        
       tableView.registerNib(UINib.init(nibName: "TableViewCell2", bundle: nil), forCellReuseIdentifier: "TableViewCell2")
        
        tableView.registerNib(UINib.init(nibName: "TableViewCell3", bundle: nil), forCellReuseIdentifier: "TableViewCell3")
        
          tableView.registerNib(UINib.init(nibName: "TableViewCell4", bundle: nil), forCellReuseIdentifier: "TableViewCell4")
        
        tableView.registerNib(UINib.init(nibName: "TableViewCell5", bundle: nil), forCellReuseIdentifier: "TableViewCell5")
        
        tableView.registerNib(UINib.init(nibName: "TableViewCell6", bundle: nil), forCellReuseIdentifier: "TableViewCell6")
        
        
        if indexPath.section == 0 {
            
            let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! CategoryRow
            print("section : \(indexPath.section)")
            return cell

        }else if indexPath.section == 1 {
            
            let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("TableViewCell2") as! TableViewCell2
              print("section : \(indexPath.section)")
            
            return cell

        } else if indexPath.section == 2 {
            
            
            let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell3") as! TableViewCell3
            
            return cell
            
            
            
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell3") as! TableViewCell3
            
            return cell
            
            
            
        }
        
        
        
       
        
    }
    
    
    func tableView(tableView: UITableView,
                   heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let title = UILabel()
        title.font = UIFont(name: "HelveticaNeue-UltraLight",
                            size: 22.0)
        title.textColor = UIColor.blackColor()
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
        header.tintColor = UIColor.clearColor()
       
    }
    
    @IBOutlet var testImage: UIImageView!
    var arrayCount : Int?

    @IBOutlet var testa: UIButton!
    @IBAction func testAction(sender: AnyObject) {
        
        
       "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_categorized_garments?user_id=1069249093136307&category=TopWear"
        
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_categorized_garments?user_id=1069249093136307&category=TopWear")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    
                        
                   self.arrayCount = (json["garments"].count)
                    print(self.arrayCount)
                    
                    var number = 0
        
                    while number  < self.arrayCount! {
                    if let quote = json["garments"][number]["wardrobe_url"].string{
                        
                        print(quote)
                  
                        
                        number += 1
                       
                    }
                        
                        GlobalVariables.globalSafeToFetch = true
                }
                }}
        

    }
    
    
}