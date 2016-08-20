//
//  ViewController.swift
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import JKNotificationPanel

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    let panel : JKNotificationPanel = JKNotificationPanel()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.z
        
        let v1 : View1 = View1(nibName: "View1", bundle: nil)
        let v2 : View2 = View2(nibName: "View2", bundle: nil)
        let v3 : View4 = View4(nibName: "View4", bundle: nil)
        
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
        
        if  GlobalVariables.modelUrl.count > 0 {
            
            if GlobalVariables.prepopulatedComplete == true {
                
                 self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
                
                
            }else {
            
            
            self.scrollView.contentOffset.x = self.view.frame.size.width
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
            
            }
     
        }


}
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        //logic to find out on which page the user is
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1);
        
        
        if(NSUserDefaults.standardUserDefaults().boolForKey("seenInapps") == false)
        {
            
            
            if page == 1
            {
                GlobalVariables.twoShown = true
                self.panel.timeUntilDismiss = 3
                self.panel.showNotify(withStatus: .SUCCESS, inView: self.view, message: "Tap on Circle to know more 👍")
            }
            
            if page == 2
            {
                GlobalVariables.threeShown = true
                
                self.panel.timeUntilDismiss = 3
                self.panel.showNotify(withStatus: .SUCCESS, inView: self.view, message: "Here is your organized wardrobe 👇")
            }
            if GlobalVariables.twoShown == true && GlobalVariables.threeShown == true
                
            {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "seenInapps")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
        
        
        
    }
    
    
    
    
    func takeControl(){
        
        if  GlobalVariables.prepopulatedComplete == false {
            
            self.scrollView.contentOffset.x = self.view.frame.size.width
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
        } else {
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
            
        }
    }
  


    func checkForPrepopulation(){
        
        print(GlobalVariables.modelStatus)
        if GlobalVariables.modelStatus! == "No User Found"{
            
            
            let starterPackScreen = Prepopulated.instanceFromNib()
            starterPackScreen.frame = CGRectMake(0 ,0 , self.view.frame.width , self.view.frame.height)
            self.view.addSubview(starterPackScreen)
            
            //self.scrollView.contentOffset.x = self.view.frame.size.width
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
            
            
        } else {
            
            self.scrollView.contentOffset.x = self.view.frame.size.width
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
        }


    }
    
    
    
}

