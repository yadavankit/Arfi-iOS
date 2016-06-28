//
//  View3.swift
//

import UIKit

class View3: UIViewController , UITableViewDataSource {
    
    
var categories = ["Topwear", "Bottomwear", "Footwear", "Top 10"]
    
    
    @IBOutlet var myTableView: UIView!
    
    override func viewDidLoad() {
        
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CategoryRow
       
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView,
                   heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let title = UILabel()
        title.font = UIFont(name: "Arial", size: 22)!
        title.textColor = UIColor.lightGrayColor()
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
        header.tintColor = UIColor.clearColor()
       
    }
    

    
    
}