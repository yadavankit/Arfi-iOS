//
//  ViewController.swift
//  SnapchatCamera
//
//  Created by Jared Davidson on 8/26/15.
//  Copyright (c) 2015 Archetapp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.z
        
        let v1 : View1 = View1(nibName: "View1", bundle: nil)
        let v2 : View2 = View2(nibName: "View2", bundle: nil)
        let v3 : View3 = View3(nibName: "View3", bundle: nil)
        
        self.addChildViewController(v1)
        self.scrollView.addSubview(v1.view)
        v1.didMoveToParentViewController(self)
        
        self.addChildViewController(v2)
        self.scrollView.addSubview(v2.view)
        v2.didMoveToParentViewController(self)
        
        self.addChildViewController(v3)
        self.scrollView.addSubview(v3.view)
        v3.didMoveToParentViewController(self)
        
        var v2Frame : CGRect = v2.view.frame
        v2Frame.origin.x = self.view.frame.width
        v2.view.frame = v2Frame
        
        var v3Frame : CGRect = v3.view.frame
        v3Frame.origin.x = self.view.frame.width * 2
        v3.view.frame = v3Frame
        
       let value = NSUserDefaults.standardUserDefaults().objectForKey("freshLogin")
        let realValue = String(value)
        
        if GlobalVariables.freshLogin == true || realValue.containsString("true") {
//           
//           NSUserDefaults.standardUserDefaults().setObject("true", forKey: "freshLogin")
//           let starterPackScreen = Prepopulated.instanceFromNib()
//         starterPackScreen.frame = CGRectMake(0 ,0 , self.view.frame.width , self.view.frame.height)
//           self.view.addSubview(starterPackScreen)
        
            //self.scrollView.contentOffset.x = self.view.frame.size.width
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
          
            
        } else {
        
      self.scrollView.contentOffset.x = self.view.frame.size.width
      self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
        }
    }

  


}

