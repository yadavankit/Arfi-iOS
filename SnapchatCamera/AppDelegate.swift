

import UIKit
import Mixpanel
import Alamofire
import AlamofireImage

import FBSDKCoreKit
@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userID : Int?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
       
 
//        let mi = Mixpanel()
//        mi.showNotificationOnActive = false
        
         application.statusBarHidden = true
//        Mixpanel.initialize(token: "39a4a3d35dc02d8a158effdeddbacc85")
        Mixpanel.initialize(token: "39a4a3d35dc02d8a158effdeddbacc85", launchOptions: launchOptions)
//        print(mi.distinctId)
        print("Distinct iD printed")

        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
//        Mixpanel.initialize(token: "39a4a3d35dc02d8a158effdeddbacc85")
        let mixpanel = Mixpanel.mainInstance()
        
        print("here is the distinct iiiiiidd")
        print(mixpanel.distinctId)
        
        //pass the project token from mixpanel account
        
        Mixpanel.mainInstance().identify(distinctId: mixpanel.distinctId)
//        let mixpanel = Mixpanel.sharedInstanceWithToken("39a4a3d35dc02d8a158effdeddbacc85")
        
//      mixpanel.identify(mixpanel.distinctId)
    
           print("here is device token")
        print(deviceToken)
        mixpanel.people.addPushDeviceToken(deviceToken)
     
//        Mixpanel.mainInstance().people.set(properties:
//            ["name": "Ankit Yadav", "$email": "email@emadddddil.com", "Plan": "Free", "$region" : "Australiaaa"])
        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        
        Mixpanel.mainInstance().trackPushNotification(userInfo)

        
        var alert1: String = ""
        if let aps = userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                if let message = alert["message"] as? NSString {
                    //Do stuff
                }
            } else if let alert = aps["alert"] as? NSString {
                print(alert)
                alert1 = alert as String
            }
        }
        let alertController = UIAlertController(title: "Notification", message:
            alert1, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
        
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

