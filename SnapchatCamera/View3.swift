//
//  View3.swift
//

import UIKit


class View3: UIViewController , UITableViewDataSource {
    
    
var categories = ["Top Wear" , "Bottom Wear" ]
    
var timer: dispatch_source_t!
    
@IBOutlet var HelloUser: UILabel!
    
@IBOutlet var realTableView: UITableView!
    
@IBOutlet var emptyWardrobe: UILabel!

    
    
override func viewDidLoad() {
   
    if let userName = GlobalVariables.globalUserName {
        
        self.HelloUser.text = "Hello \(GlobalVariables.globalUserName!.componentsSeparatedByString(" ")[0])!"
    }

    }
    
 
    
   func startTimer() {
    
        let queue = dispatch_queue_create("com.domain.app.timer", nil)
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
      dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC, 1 * NSEC_PER_SEC) // every 60 seconds, with leeway of 1 second
       dispatch_source_set_event_handler(timer) {
        
            if GlobalVariables.globalTopAndBottom.count > 0 {
                
                self.HelloUser.text = "Hello \(GlobalVariables.globalUserName!.componentsSeparatedByString(" ")[0])!"
                 self.HelloUser.reloadInputViews()
                self.stopTimer()
               
                       } else {
               
            self.HelloUser.text = "Hello User!"
           }
        
        
      }
       dispatch_resume(timer)
  }
       func stopTimer() {
       dispatch_source_cancel(timer)
        timer = nil
    }
    
 // TableView Methods :
  

   
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
        
        
        
        if indexPath.section == 0 {
            
            let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! CategoryRow
            print("section : \(indexPath.section)")
            return cell

        }else if indexPath.section == 1 {
            
         
            let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("TableViewCell2") as! TableViewCell2
              print("section : \(indexPath.section)")
            
            return cell

        }  else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell3") as! TableViewCell2
            
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
    
 


    
    
}