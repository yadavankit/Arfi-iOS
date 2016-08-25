 //
 //  View2.swift
 //
 //
 import UIKit
 import AVFoundation
 import ZAlertView
 import JKNotificationPanel
 import Alamofire
 import Petal
 import YBAlertController
 import ImageCropView
 import Toucan
 import FBSDKCoreKit
 import DropDown
 import SwiftyJSON
 import Mixpanel
 import Social
 import Crashlytics
 import PopupDialog
 
 
 class View2 : UIViewController, UIImagePickerControllerDelegate, UIScrollViewDelegate, UINavigationControllerDelegate{
    
    
    //For Scoring Purposes only
    
    @IBOutlet var scoreView: UIView!
    
    @IBOutlet var LevelLabel: UILabel!
    
    @IBOutlet var ScoreLabel: UILabel!
    
    @IBOutlet var ProgressView: UIProgressView!
    
    
    
    
    @IBOutlet var TypeOfGarment: UIButton!
    let myView = PremiumView.instanceFromNib()
    @IBOutlet var QuestionDone: UIButton!
    @IBOutlet var question4View: UIButton!
    @IBOutlet var questionView: UIView!
    
    @IBOutlet var mainQuestionsView: UIView!
    @IBOutlet var questionView2: UIButton!
    
    @IBOutlet var cubeCamera: UIView!
    
    
    
    
    
    
    
    
    
    //when Back Button on Garment Questions View is Pressed
    @IBAction func backPressed(sender: AnyObject)
    {
        self.mainQuestionsView.hidden = true
        self.cameraImage.hidden = true
        self.cameraButtonOutlet.hidden = false
        self.perimeterOutlet.hidden = false
        self.flashIcon.hidden = false
    }
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    
    @IBOutlet var label3: UILabel!
    @IBOutlet var type2View: UIView!
    @IBOutlet var shareButton: UIButton!
    
    @IBOutlet var swipeup: UILabel!
    
    @IBOutlet var ActivityIndicator: activityIndicator!
    @IBOutlet weak var settingUpWardrobe: UILabel!
    @IBOutlet weak var tickmarkOutlet: UIButton!
    let panel : JKNotificationPanel = JKNotificationPanel()
    let warningPanel : JKNotificationPanel = JKNotificationPanel()
    var firstLaunchEver : Bool = false
    var permanentView : UIView?
    var garmentAddView : UIView?
    var userClickedPhoto : UIImage?
    var currentIndex : Int?
    var finalImage : UIImage?
    var userUniqueIdentifier : String?
    var ScoreNib : UIView?
    var mainCamera : AVCaptureDevice?
    var facebookId = "404"
    var facebookUser = "Mark Zuckerberg"
    var instructionsShown : Bool = false
    var numberOfGarmentsUploaded = 0
    let clothes : NSMutableArray = ["Top", "Shorts", "Shirt", "Jeans", "TShirt", "Trousers", "Capris", "Culottes" , "Leggings" , "Cargos" ,"Palazzo" ,  "Skirt" , "Kurta" , "Jackets" , "Sweaters" ,"Sweatshirt" ,"Shrugs"]
    
    var instructionsImages: [UIImage] = [
        UIImage(named: "rule1")!,
        UIImage(named: "rule2")!,
        UIImage(named: "rule3")!]
    
    
    var frame:CGRect = CGRectMake(0,0,0,0)
    
    
    
    var myGarments = [ "Tshirt" , "shirt" , "Top"]
    
    @IBOutlet var cameraImage: UIImageView!
    
    @IBOutlet var flashIcon: UIButton!
    
    let alertController = YBAlertController(title: "Add garment type", message: "Help us identify your garment typee", style: .Alert)
    
    @IBAction func crossClicked(sender: AnyObject) { //when cross button is clicked
        
                self.cross.hidden = true
        self.cameraImage.hidden = true
        self.cameraButtonOutlet.hidden = false
        self.perimeterOutlet.hidden = false
        self.tickmarkOutlet.hidden = true
        self.flashIcon.hidden = false

    }
    
    
    @IBOutlet weak var cross: UIButton!
    
    
    @IBOutlet weak var cameraButtonOutlet: UIButton!
    
    
    
    
    @IBAction func tickmarkAction(sender: AnyObject) {    // when user clicks on the tick mark
        
        self.view.addSubview(self.mainQuestionsView)
        
        tickmarkOutlet.hidden = true
        cross.hidden = true
        self.questionView2.hidden = true
        self.question3View.hidden = true
        self.QuestionDone.hidden = true
        
        self.mainQuestionsView.hidden = false
        
        
    }
    
    @IBOutlet weak var perimeterOutlet: UIImageView!
    var captureSession : AVCaptureSession?
    var stillImageOutput : AVCaptureStillImageOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?
    @IBOutlet var cameraView: UIView!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var myLabel: UILabel!
    var myButton: UIButton!
    
    
    func showCustomDialog() {
        
        
        print("showingggggggg")
        // Create a custom view controller
        let ratingVC = RatingViewController(nibName: "RatingViewController", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: ratingVC, transitionStyle: .BounceDown, buttonAlignment: .Horizontal, gestureDismissal: true)
        
        // Create first button
        let buttonOne = CancelButton(title: "CONFIRM") {
            
            //            print(ratingVC.commentTextField.text!)
            if let number = ratingVC.commentTextField.text
            {
                Alamofire.request(.GET, "http://backend.arfi.in:4000/processing_panel/set_paytm", parameters: ["user_id": GlobalVariables.globalFacebookId!,"paytm_number": number])
                    .validate()
                    .responseJSON { response in
                        
                        
                }
                
            }
            
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne])
        
        // Present dialog
        presentViewController(popup, animated: true, completion: nil)
    }
    
    
    
    func refreshScore()
    {
        
        //Setup level score whatever
        self.LevelLabel.text = "Level : " + String(GlobalVariables.is_on_level!)
        let camera_uploads = String(GlobalVariables.camera_uploads!)
        let first_level_status = String(GlobalVariables.first_level_status!)
        let second_level_status = String(GlobalVariables.second_level_status!)
        let third_level_status = String(GlobalVariables.third_level_status!)
        var out_of = ""
        var uploads_for_level = ""
        var progress : Float = 0.0
        
        
        let is_on_level = String(GlobalVariables.is_on_level!)
        if is_on_level == "1"
        {
            if first_level_status == "7"
            {
                if(NSUserDefaults.standardUserDefaults().boolForKey("hasSeenFirstSeven") == false)
                {
                    self.showPopup("GREAT, ALMOST THERE", message: "Upload 7 more Garments to clear LEVEL 1 and see your paytm wallet getting fatter by ₹ 100", image_name: "camera_trans")
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSeenFirstSeven")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                
                
            }
            if first_level_status == "3"
            {
                if(NSUserDefaults.standardUserDefaults().boolForKey("hasSeenFirstThree") == false)
                {
                    self.showPopup("GREAT, ALMOST THERE", message: "Upload 3 more Garments to clear LEVEL 1 and see your paytm wallet getting fatter by ₹ 100", image_name: "camera_trans")
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSeenFirstThree")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                
            }
            out_of = "10"
            uploads_for_level = camera_uploads
            progress = Float(uploads_for_level)! / 10
            
        }
        else if is_on_level == "2"
        {
            if second_level_status == "15"
            {
                if(NSUserDefaults.standardUserDefaults().boolForKey("hasSeenFirstDone") == false)
                {
                        self.showCustomDialog()
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSeenFirstDone")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }

            }
            if second_level_status == "4"
            {
                if(NSUserDefaults.standardUserDefaults().boolForKey("hasSeenSecondFour") == false)
                {
                self.showPopup("GREAT, ALMOST THERE", message: "Upload 4 more Garments to clear LEVEL 2 and see your paytm wallet getting fatter by ₹ 150", image_name: "camera_trans")
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSeenSecondFour")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }


            }
            if second_level_status == "8"
            {
                if(NSUserDefaults.standardUserDefaults().boolForKey("hasSeenSecondEight") == false)
                {
                    self.showPopup("GREAT, ALMOST THERE", message: "Upload 8 more Garments to clear LEVEL 2 and see your paytm wallet getting fatter by ₹ 150", image_name: "camera_trans")
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSeenSecondEight")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                
            }
            
            out_of = "25"
            uploads_for_level = String(Int(camera_uploads)! - 10)
            progress = Float(uploads_for_level)! / 15
            
        }
        else if is_on_level == "3"
        {
            if third_level_status == "4"
            {
                if(NSUserDefaults.standardUserDefaults().boolForKey("hasSeenThirdFour") == false)
                {
                    self.showPopup("GREAT, ALMOST THERE", message: "Upload 4 more Garments to clear LEVEL 3 and see your paytm wallet getting fatter by ₹ 200", image_name: "camera_trans")
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSeenThirdFour")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                
            }
            if third_level_status == "8"
            {
                if(NSUserDefaults.standardUserDefaults().boolForKey("hasSeenThirdEight") == false)
                {
                    self.showPopup("GREAT, ALMOST THERE", message: "Upload 8 more Garments to clear LEVEL 3 and see your paytm wallet getting fatter by ₹ 200", image_name: "camera_trans")
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSeenThirdEight")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                
                
            }
            
            if third_level_status == "0"
            {
                if(NSUserDefaults.standardUserDefaults().boolForKey("hasSeenThirdDone") == false)
                {
                      self.showPopup("GREAT YOU CLEARED LEVEL 3", message: "₹ 200 will be transferred to your paytm wallet. :)", image_name: "cup3")
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSeenThirdDone")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                
                
            }
            
            
            if third_level_status == "15"
            {
                if(NSUserDefaults.standardUserDefaults().boolForKey("hasSeenSecondDone") == false)
                {
                    self.showPopup("GREAT YOU CLEARED LEVEL 2", message: "₹ 150 will be transferred to your paytm wallet. :)", image_name: "cup2")
                 
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSeenSecondDone")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                
            }
            out_of = "40"
            uploads_for_level = String(Int(camera_uploads)! - 25)
            progress = Float(uploads_for_level)! / 15
            
        }
        self.ScoreLabel.text = camera_uploads + "/" + out_of
        self.ProgressView.progress = progress
        self.ProgressView.layer.cornerRadius = 7.0
        self.ProgressView.clipsToBounds = true
        print("progresssssss")
        print(progress)
        self.ProgressView.setNeedsDisplay()
        self.scoreView.setNeedsDisplay()
//        self.setNeedsFocusUpdate()
        
        let left_uploads = Int(out_of)! - Int(camera_uploads)!
        
        let key_name = "seenUpload" + String(left_uploads) + "onLevel" + is_on_level
        if(NSUserDefaults.standardUserDefaults().boolForKey(key_name) == false)
        {

            self.panel.timeUntilDismiss = 5
            self.panel.showNotify(withStatus: .SUCCESS, inView: (self.parentViewController?.view)!, message: "You are just \(left_uploads) uploads away from the next level and a great reward 😀")
            
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: key_name)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
    }
    
    
    func screenSwiped(gesture: UISwipeGestureRecognizer)
    {
        
        let test = GamifyScore.instanceFromNib()
        ScoreNib = test
        test.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.view.addSubview(test)
        
        
        
    }
    
    func removeScoreView(gesture: UISwipeGestureRecognizer)
    {
        
        ScoreNib?.removeFromSuperview()
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.refreshScore()
        
        self.startTimer()
        
        
        
        
        //Add Upward Swipe Gesture Recognizer
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(View2.screenSwiped(_:)))
        swipeUp.direction = .Up
        self.view.addGestureRecognizer(swipeUp)
        
        //Down Swipe to Remove
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(View2.removeScoreView(_:)))
        swipeDown.direction = .Down
        self.view.addGestureRecognizer(swipeDown)
        
        
        
        
        
        
        
        
        //Instruction screen scrollview & page control
        self.scrollView = UIScrollView(frame: CGRectMake(0,0, self.view.frame.size.width, UIScreen.mainScreen().bounds.height))
        self.myLabel = UILabel(frame: CGRectMake(0,self.scrollView.frame.height - 150, UIScreen.mainScreen().bounds.width, 70))
        self.myLabel.text = "Make sure lighting is as bright as Sun"
        self.myLabel.numberOfLines = 2
        self.myLabel.textAlignment = NSTextAlignment.Center
        
        self.scrollView.backgroundColor = UIColor.whiteColor()
        self.pageControl = UIPageControl(frame: CGRectMake((UIScreen.mainScreen().bounds.width / 2) - 25, UIScreen.mainScreen().bounds.height - 100, 50, 50))
        
        scrollView.delegate = self
        configurePageControl()
        
        print(self.cross.layer.frame)
        self.cross.layer.frame.size.height = 100
        self.cross.layer.frame.size.width = 100
        
        
        
        print("Global number og garmnets")
        print(GlobalVariables.globalTopAndBottom.count)
        
        
        self.mainQuestionsView.hidden = true
        self.QuestionDone.hidden = true
        
        self.question3View.titleLabel!.numberOfLines = 0
        self.question3View.titleLabel!.adjustsFontSizeToFitWidth = true
        
        self.questionView2.hidden = true
        self.question3View.hidden = true
        self.settingUpWardrobe.hidden = true
        self.ActivityIndicator.hidden = true
        ActivityIndicator.strokeColor = UIColor(red:0.98, green:0.13, blue:0.25, alpha:1.0)
        
        
        if(NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce"))
        {
            print("App is already launchedd")
            
            // app already launched
            
        }
        else
        {
            print("App is launching for first tym")
            
            self.firstLaunchEver = true
//            panel.timeUntilDismiss = 6
//            perimeterOutlet.hidden = false
//            panel.showNotify(withStatus: .SUCCESS, inView: self.view, message: "Tap on the circle to upload garments 👇")
//            
            
            userUniqueIdentifier = UIDevice.currentDevice().identifierForVendor!.UUIDString
            print(userUniqueIdentifier)
            
            // This is the first launch ever
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedOnce")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        self.cross.hidden = true
        self.tickmarkOutlet.hidden = true
        
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        //find the page number you are on
        print("Scroll View delegate ")
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1);
        
        if page == 0
        {
            self.myLabel.text = "Make sure lighting is as bright as Sun"
        }
        if page == 1
        {
            self.myLabel.text = "The more distinct the background, the better"
        }
        
        if page == 2
        {
            self.myLabel.text = "Place your garment perfectly in the marked area"
            
            self.myButton = UIButton(frame: CGRectMake(0, self.view.frame.height-50, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - (self.view.frame.height - 50)))
            myButton.backgroundColor = UIColor.redColor()
            myButton.setTitle("Got It", forState: .Normal)
            myButton.addTarget(self, action: #selector(View2.removeScrollView), forControlEvents: .AllTouchEvents)
            myButton.titleLabel?.text = "Got it"
            myButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            myButton.backgroundColor = UIColor(red:0.98, green:0.13, blue:0.25, alpha:1.0)
            self.view.addSubview(myButton)
            
        }
        
        pageControl.currentPage = page;
    }
    
    
    //Removes ScrollView on touching Got It Button
    func removeScrollView()
    {
        
        //This crashes app (just uncomment if u want to see destruction)
        //Crashlytics.sharedInstance().crash()
        
        Mixpanel.mainInstance().track(event: "Clicked GotIt on Instruction Screen",
                                      properties: ["SeenInstructions" : "Yes"])
        self.cameraButtonOutlet.hidden = false
        self.scrollView.hidden = true
        self.scrollView.removeFromSuperview()
        self.pageControl.hidden = true
        self.myLabel.hidden = true
        self.myButton.hidden = true
        self.view.addSubview(cameraView)
        self.view.addSubview(flashIcon)
        self.view.addSubview(shareButton)
        self.view.addSubview(cameraButtonOutlet)
        self.view.addSubview(mainQuestionsView)
        self.view.addSubview(scoreView)
        self.view.addSubview(perimeterOutlet)
        self.view.addSubview(cameraImage)
        self.view.addSubview(tickmarkOutlet)
        self.view.addSubview(cross)
        self.view.addSubview(shareButton)
        self.flashIcon.hidden = false
        
        //Inapp after Got it Instruction screen
        self.panel.timeUntilDismiss = 0
        self.panel.enableTapDismiss = true
        self.panel.showNotify(withStatus: .SUCCESS, inView: (self.parentViewController?.view)!, message: "Swipe Left to see your wardrobe organized. 👈 Tap to dismiss 🤗")
        
    }
    
    //Set Page Control according to Page in ScrollView
    func configurePageControl()
    {
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
        self.pageControl.tintColor = UIColor.redColor()
        self.pageControl.pageIndicatorTintColor = UIColor.blackColor()
        self.pageControl.currentPage = 0
        
    }
    
    //Sets Page in Scroll View
    func setPageViewInScroll()
    {
        for index in 0..<3
        {
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.view.frame.size
            self.scrollView.pagingEnabled = true
            
            let subView = UIView(frame: frame)
            
            let imageView = UIImageView(image: instructionsImages[index])
            imageView.center = CGPointMake(self.view.frame.size.width  / 2,
                                           self.view.frame.size.height / 2);
            
            subView.addSubview(imageView)
            self.scrollView.addSubview(subView)
        }
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.height)
    }
    
    
    
    
    
    func getUserDetails()
    {
        
        var arrayCount : Int?
        
        Alamofire.request(.GET, "http://backend.arfi.in:4000/processing_panel/user_api?user_id=\(GlobalVariables.globalFacebookId!)")
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    
                    let json = JSON(jsonValue)
                    print(json)
                    
                    let is_on_level = json["is_on_level"].string
                    let first_level_status = json["first_level_status"].string
                    let second_level_status = json["second_level_status"].string
                    let third_level_status = json["third_level_status"].string
                    let camera_uploads = json["camera_uploads"].string
                    
                    GlobalVariables.is_on_level = is_on_level
                    GlobalVariables.camera_uploads = camera_uploads
                    GlobalVariables.first_level_status = first_level_status
                    GlobalVariables.second_level_status = second_level_status
                    GlobalVariables.third_level_status = third_level_status
                    
                    
                    
                }
                
        }
        
        self.refreshScore()
    }
    
    
    
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        setPageViewInScroll()
        previewLayer?.frame = cameraView.bounds
    }
    
    
    
    override func viewWillAppear(animated: Bool) { //when the screen loads
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        mainCamera = backCamera
        
        // configure()
        
        
        var error : NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if (error == nil && captureSession?.canAddInput(input) != nil){
            
            captureSession?.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            if (captureSession?.canAddOutput(stillImageOutput) != nil){
                captureSession?.addOutput(stillImageOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                cameraView.layer.addSublayer(previewLayer!)
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.captureSession?.startRunning()
                    
                })
                
                
            }
        }
    }
    
    
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("TextField did begin editing method called")
    }
    
    
    
    
    
    
    
    func displayInstructions()
    {
        
        print("displaying instructions")
        self.view.addSubview(myLabel)
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
        self.view.bringSubviewToFront(myLabel)
        self.view.bringSubviewToFront(pageControl)
    }
    
    func didPressTakePhoto(){  //image capture mechanism
        
        print("photo li gyi hai")
        
        if let videoConnection = stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo){
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {
                (sampleBuffer, error) in
                
                if sampleBuffer != nil {
                    
                    
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider  = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    
                    
                    self.cameraImage.hidden = false
                    self.cameraImage.image = image
                    self.view.addSubview(self.cameraImage)
                    self.view.addSubview(self.tickmarkOutlet)
                    self.view.addSubview(self.cross)
                    
                    
                    self.finalImage = Toucan(image: image).resizeByCropping(CGSizeMake(300, 300)).image
                    
                    
                    
                }
                
                
            })
        }
        
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    var didTakePhoto = Bool()
    
    func didPressTakeAnother(){
        if didTakePhoto == true{
            cameraImage.hidden = true
            didTakePhoto = false
            
        }
        else{
            captureSession?.startRunning()
            didTakePhoto = true
            didPressTakePhoto()
            
        }
        
    }
    
    //
    func getNumberOfGarmentsForUser()
    {
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_garments?user_id=\(GlobalVariables.globalFacebookId!)")
            .validate()
            .responseString { response in
                print("Prepopulation k baad garment count")
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(response.result.value)")
                
                
                if let numberOfGarments = response.result.value
                {
                    GlobalVariables.finalGarmentCount = Int(numberOfGarments)
                }
                
        }
        
    }
    
    
    
    @IBAction func clicked (sender : UIButton) {  // main camera button clicked
        
        self.cameraButtonOutlet.hidden = true
        print("Global top and bottom ka count")
        print(GlobalVariables.globalTopAndBottom.count)
        print("Prepopulated wala")
        print(GlobalVariables.globalStarterPack.count)
        
        if(NSUserDefaults.standardUserDefaults().boolForKey("hasSeenInstructions") == false)
        {
            displayInstructions()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSeenInstructions")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        else
        {
            
            
            print(firstLaunchEver)
            self.flashIcon.hidden = true
            
            
            perimeterOutlet.hidden = false
            
            let triggerTime = (Int64(NSEC_PER_SEC) * 3)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                
                self.perimeterOutlet.hidden = false
                
            })
            
            
            firstLaunchEver = false
            
            
            Mixpanel.mainInstance().track(event: "Garment Upload Begin",
                                          properties: ["Upload" : "Start"])
            
            
            
            didPressTakePhoto()
            
            self.cross.hidden = false
//            cameraButtonOutlet.hidden = true
            perimeterOutlet.hidden = false
            self.tickmarkOutlet.hidden = false
        }
        
    }
    
    
    func showPopup(title: String, message: String, image_name: String)
    {
        // Prepare the popup assets
        let title = title
        let message = message
        let image = UIImage(named: image_name)
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)
        
        // Create buttons
        let buttonOne = CancelButton(title: "UPLOAD MORE") {
            
        }
        
        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
        popup.addButtons([buttonOne])
        
        // Present dialog
        self.presentViewController(popup, animated: true, completion: nil)
        
        
    }
    
    
    var image = UIImage(named: "arfi-logo-1536x1536-1")
    @IBAction func share(sender: AnyObject) {
        
        //self.showCustomDialog()
        
        
        
        
        //FACEBOOK SHARE CODE
        //displayInstructions()
        
        let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        vc.setInitialText("arfi is a 24/7 AI based assistant that helps women with their existing wardrobe. Follow the link to download the app.")
        vc.addImage(image)
        vc.addURL(NSURL(string: "https://appsto.re/in/teTIbb.i"))
        presentViewController(vc, animated: true, completion: nil)
        
    }
    @IBOutlet var optionCollectionView: UICollectionView!
    
    func garmentAdded(){
        
        self.alertController.removeFromParentViewController()
        
        
    }
    
    
    func removeView () {
        permanentView?.removeFromSuperview()
    }
    
    
    func sendImageToServer(){  // backend code to send image to server
        
        
        tickmarkOutlet.hidden = true
        cross.hidden = true
        settingUpWardrobe.hidden = true
        
        let imageData = UIImageJPEGRepresentation(self.finalImage! , 1 )
        
        let testValue = Int(GlobalVariables.numberOfGarments!)
        
        let value = testValue! + 1
        
        
        
        
        let typeOFGarment = GlobalVariables.mainDetail + "," + GlobalVariables.detail1 + "," + GlobalVariables.detail2 + "," + GlobalVariables.detail3
        
        Alamofire.upload(
            .POST,
            "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:4000/processing_panel/upload",
            multipartFormData: { multipartFormData in
                
                
                multipartFormData.appendBodyPart(data: imageData!, name: "garment_image", fileName: "\(value)" + ".jpg", mimeType: "image/jpeg") // image
                
                
                multipartFormData.appendBodyPart(data: GlobalVariables.globalFacebookId!.dataUsingEncoding(NSUTF8StringEncoding , allowLossyConversion:  false)!, name :"user_id") // user_id
                
                
                multipartFormData.appendBodyPart(data:GlobalVariables.globalUserName!.dataUsingEncoding(NSUTF8StringEncoding , allowLossyConversion:  false)!, name: "user_name") //user_name
                
                
                multipartFormData.appendBodyPart(data: typeOFGarment.dataUsingEncoding(NSUTF8StringEncoding , allowLossyConversion: false)!, name: "style") // style
                
                GlobalVariables.numberOfGarments = String(value)
                print("Total number of garments \(value)")
                print("The user id is \(GlobalVariables.globalFacebookId!)")
                print("The user name is \(GlobalVariables.globalUserName)")
                
                
                let premium = PremiumView.instanceFromNib()
                premium.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
                
                
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    
                    upload.progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                        print("Uploading Avatar \(totalBytesWritten) / \(totalBytesExpectedToWrite)")
                        
                        
                        dispatch_async(dispatch_get_main_queue(),{
                            
                            self.cross.hidden = true
                            self.cameraImage.hidden = true
                            self.cameraButtonOutlet.hidden = false
                            self.cameraButtonOutlet.alpha = 0.3
                            self.perimeterOutlet.hidden = false
                            self.tickmarkOutlet.hidden = true
                            self.flashIcon.hidden = false
                            self.cameraButtonOutlet.hidden = false
                            self.cameraButtonOutlet.alpha = 0.3
                            self.swipeup.text = "Wait"
                            self.cameraButtonOutlet.userInteractionEnabled = false


//                            self.crossClicked(self)
                            self.settingUpWardrobe.hidden = true
                            self.flashIcon.hidden = false
                            
                            
                            let bustObject = NSUserDefaults.standardUserDefaults().objectForKey("bust")
                            
                            if bustObject != nil {
                                
                                
                                self.sendModelDetails()
                                
                            }
                            
                            /**
                             *  Update UI Thread about the progress
                             */
                        })
                    }
                    upload.responseJSON { (JSON) in
                        dispatch_async(dispatch_get_main_queue(),{
                            //Show Alert in UI
                            
                            
                            print("Pohocha diya bhaiya")
                            self.cameraButtonOutlet.hidden = false
                            self.swipeup.text = "Swipe Up"
                            self.cameraButtonOutlet.alpha = 1.0
                            self.refreshScore()
                            self.scoreView.setNeedsDisplay()
                            self.ProgressView.setNeedsDisplay()
                            self.cameraButtonOutlet.userInteractionEnabled = true
                            
                            
                            
                            
                            Mixpanel.mainInstance().track(event: "Garment Upload Ended",
                                properties: ["Uploaded Image Number" : value])
                            
                            
                            
                            self.getUserDetails()
                            
                            self.refreshScore()
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        })
                    }
                    
                case .Failure( _):
                    //Show Alert in UI
                    print("Avatar failed");
                }
            }
        );
        
        
        
        
        
    }
    
    
    
    
    
    @IBAction func flash(sender: UIButton) {
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == AVCaptureTorchMode.On) {
                    device.torchMode = AVCaptureTorchMode.Off
                } else {
                    try device.setTorchModeOnWithLevel(1.0)
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
        
        if device.torchMode == AVCaptureTorchMode.Off {
            if let image = UIImage(named:"no-flash") {
                sender.setImage(image, forState: .Normal)
            }
        } else if device.torchMode == AVCaptureTorchMode.On {
            
            if let image = UIImage(named:"flash-1") {
                sender.setImage(image, forState: .Normal)
            }
            
        }
    }
    
    var timer: dispatch_source_t!
    
    func startTimer() {
        let queue = dispatch_queue_create("com.domain.app.timer", nil)
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC, 1 * NSEC_PER_SEC) // every 60 seconds, with leeway of 1 second
        dispatch_source_set_event_handler(timer) {
            
            self.getUserDetails()
//            self.refreshScore()
        }
        dispatch_resume(timer)
    }
    
    func stopTimer() {
        dispatch_source_cancel(timer)
        timer = nil
    }
    
    
    
    
    
    func removePremiumView(){
        
        myView.removeFromSuperview()
        
        
    }
    
    
    func configure(){ // autofocus code (not used)
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                device.focusMode = .AutoFocus
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
        
        
    }
    
    func returnUserData() //get user id and username
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                
                let userId : String = result.valueForKey("id") as! String
                
                self.facebookId = userId
                
                
                
                let userName : String = result.valueForKey("name") as! String
                
                self.facebookUser = userName
                GlobalVariables.globalFacebookId = userId
                
                
                
            }
        })
    }
    
    
    func getNumberOfGarments () { //calculate the current number of garments on the server
        
        
        Alamofire.request(.GET, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/get_garments", parameters: ["user_id": self.facebookId])
            .responseJSON { response in
                
                
                if let JSON = response.result.value {
                    
                    
                    print (Int(JSON as! NSNumber))
                    
                    self.numberOfGarmentsUploaded = (Int(JSON as! NSNumber))
                    // GlobalVariables.globalNumberOfGarments = String((Int(JSON as! NSNumber)))
                    
                }
        }
        
        
    }
    
    
    @IBAction func showthebutton(sender: AnyObject) {
        dropDown.show()
        
        loadDropDown()
    }
    
    
    let dropDown = DropDown()
    let dropDown2 = DropDown()
    let dropDown3 = DropDown()
    let dropDown4 = DropDown()
    
    
    
    
    func loadDropDown() {
        
        dropDown.anchorView = self.questionView
        dropDown.dataSource = ["Shirt" , "Top" ,"TShirt", "Skirt" , "Jeans" , "Trouser" , "Capri" , "Culottes" , "Leggings" , "Cargos" , "Shorts" , "Palazzo", "Dress"]
        
        dropDown.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.label1.text = item
            self.question3View.hidden = true
            GlobalVariables.globalGarmentSelected = item
            GlobalVariables.detail1 = item
            
            switch item {
                
            case "Shirt":
                
                self.label2.text = "Type of Fitting"
                
                
            case "Top":
                self.label2.text = "Style"
                self.label3.text = "Length"
                
                
            case "TShirt":
                self.label2.text = "Length"
                
                
                
            case "Skirt":
                
                self.label2.text = "Skirt Style"
                self.label3.text = "Length"
                
            case "Jeans":
                self.label2.text = "Style"
                self.label3.text = "Fitting/Rise"
                
                
            case "Trouser":
                
                self.label2.text = "Rise"
                self.label3.text = "Length"
                
            case "Capri":
                
                self.label2.text = "Rise"
                self.label3.text = "Length"
                
            case "Culottes":
                self.label2.text = "Rise"
                self.label3.text = "Length"
                
            case "Leggings":
                
                self.label2.text = "Rise"
                self.label3.text = "Length"
                
            case "Cargos":
                
                self.label2.text = "Rise"
                self.label3.text = "Length"
                
            case "Shorts":
                
                self.label2.text = "Rise"
                self.label3.text = "Length"
                
            case "Palazzo":
                
                self.label2.text = "Rise"
                self.label3.text = "Length"
                
            case "Dress" :
                
                self.label2.text = "Style"
                self.label3.text = "Length"
                
            default:
                print("Fucked")
                
            }
            self.questionView2.hidden = false
            
        }
        
    }
    
    
    @IBAction func type2Action(sender: AnyObject) {
        
        dropDown2.anchorView = self.type2View
        dropDown2.show()
        switch GlobalVariables.globalGarmentSelected! {
            
        case "Dress" :
            
            dropDown2.dataSource = ["Sheath Dress" , "Shift Dress" , "Blouson Dress" , "Bodycon Dress" , "Skater Dress" , "Maxi Dress", "Shirt Dress" , "Peplum Dress" , "Aline Dress" , "Wrapped Dress" , "Gown" , "Pop over dress" , "Pencil Dress" , "Tshirt Dress" , "Fit and Flare Dress"]
            
        case "Shirt":
            
            dropDown2.dataSource = ["Slim Fit" , "Casual Fit" , "Oversized"]
            
            
        case "TShirt":
            
            dropDown2.dataSource = ["Long" , "Waist" , "Short length"]
            
            
            
        case "Top":
            dropDown2.dataSource = ["Peplum" , "Cami" , "Tank Top" , "Wrap" , "Kaftaan" , "Balloon Top" , "Tube Top"]
            
            
            
        case "Skirt":
            dropDown2.dataSource = ["A Line" , "Pencil" , "Pleated" , "Skater" , "Wrap" , "Gathered" ,"Peplum" , "Ruffled"  , "Straight" , "Origami" , "Trumpet" , "Tulip" , "Balloon"]
            
            
        case "Jeans":
            dropDown2.dataSource = ["Jogger/Jeggings" , "Straight" , "Loose/Relaxed" , "Bootcut" , "Crop Jeans" , "Skinny Jeans" ]
            
            
            
            
        case "Trouser":
            dropDown2.dataSource = ["High" , "Low" ]
            
            
        case "Capri":
            dropDown2.dataSource = ["High" , "Low" ]
            
            
        case "Culottes":
            dropDown2.dataSource = ["High" , "Low" ]
            
        case "Leggings":
            dropDown2.dataSource = ["Full" , "Calf" ]
            
            
        case "Cargos":
            dropDown2.dataSource = ["Midi" , "Calf" , "Full"]
            
            
        case "Shorts":
            dropDown2.dataSource = ["High" , "Low" ]
            
            
        case "Palazzo":
            dropDown2.dataSource = ["High" , "Low" ]
            
            
        case "Shorts":
            dropDown2.dataSource = ["High" , "Low" ]
            
            
            
            //        case "Stockings":
            //            dropDown2.dataSource = ["High" , "Low" ]
            
            
            
        default:
            print("done")
        }
        
        
        dropDown2.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            
            self.label2.text = item
            GlobalVariables.detail2 = item
            
            switch GlobalVariables.globalGarmentSelected! {
                
            case "Shirt":
                
                
                self.QuestionDone.hidden = false
                
            case "TShirt":
                
                
                self.QuestionDone.hidden = false
                
            case "Top":
                
                
                self.question3View.hidden = false
                
            case "Skirt":
                
                self.question3View.hidden = false
                
            case "Jeans":
                
                self.question3View.hidden = false
            
                
            case "Trouser":
                
                self.QuestionDone.hidden = false
                
            case "Capri":
                
                self.question3View.hidden = false
                
            case "Culottes":
                
                self.question3View.hidden = false
            case "Leggings":
                
                self.QuestionDone.hidden = false
                
            case "Cargos":
                
                self.QuestionDone.hidden = false
                
            case "Shorts":
                
                self.QuestionDone.hidden = false
                
            case "Palazzo":
                
                self.question3View.hidden = false
                
            case "Shorts":
                
                self.QuestionDone.hidden = false
                
            case "Dress" :
                
                self.question3View.hidden = false
                
                //            case "Stockings":
                //
                //                self.QuestionDone.hidden = false
                
                
            default:
                print("done")
            }
            
            
            
            
            
        }
        
        
    }
    @IBOutlet var question3View: UIButton!
    
    @IBAction func question3Action(sender: AnyObject) {
        
        
        
        dropDown3.anchorView = self.question3View
        dropDown3.show()
        
        if GlobalVariables.globalGarmentSelected == "Jeans" && self.label2.text == "Straight" {
            
            
            dropDown3.dataSource = ["Casual Fit/High Rise", "Casual Fit/Low Rise"]
            
        }
        else if GlobalVariables.globalGarmentSelected == "Jeans" && self.label2.text == "Loose/Relaxed" {
            
            
            dropDown3.dataSource = ["Casual Fit/High Rise", "Casual Fit/Low Rise"]
            
        }
        else if GlobalVariables.globalGarmentSelected == "Jeans" && self.label2.text == "Bootcut" {
            
            
            dropDown3.dataSource = ["Wide Legged/High Rise", "Wide Legged/Low Rise"]
            
        }
            
        else if GlobalVariables.globalGarmentSelected == "Jeans" && self.label2.text == "Crop Jeans" {
            
            
            dropDown3.dataSource = ["Skinny Fit/High Rise", "Skinny Fit/Low Rise"]
            
        }
            
        else if GlobalVariables.globalGarmentSelected == "Jeans" && self.label2.text == "Skinny Jeans" {
            
            
            dropDown3.dataSource = ["High Rise", "Low Rise"]
            
        }
        else if GlobalVariables.globalGarmentSelected == "Jeans" && self.label2.text == "Jogger/Jeggings" {
            
            
            self.QuestionDone.hidden = false
            self.question3View.hidden = true
            
        }
            
        else if GlobalVariables.globalGarmentSelected == "Top" && self.label2.text == "Peplum" {
            
            
            dropDown3.dataSource = ["Short Length", "Waist Length"]
            
        }
        else if GlobalVariables.globalGarmentSelected == "Top" && (self.label2.text == "Cami" || self.label2.text == "Tank Top") {
            
            
            dropDown3.dataSource = ["Crop Length/Slim Fit", "Crop Length/Casual Fit", "Waist Length/Slim Fit", "Waist Length/Casual Fit", "Long length/Slim Fit", "Long Length/Casual Fit"]
            
        }
            
        else if GlobalVariables.globalGarmentSelected == "Top" && self.label2.text == "Wrap" {
            
            
            dropDown3.dataSource = ["Crop Length", "Waist Length", "Long Length"]
            
        }
            
        else if GlobalVariables.globalGarmentSelected == "Top" && self.label2.text == "Kaftaan" {
            
            
            dropDown3.dataSource = ["Long Length", "Waist Length"]
            
        }
        else if GlobalVariables.globalGarmentSelected == "Top" && self.label2.text == "Tube Top" {
            
            
            dropDown3.dataSource = ["Crop Length", "Long Length"]
            
        }
            
        else if GlobalVariables.globalGarmentSelected == "Top" && self.label2.text != "Tube Top" && self.label2.text != "Cami" && self.label2.text != "Wrap" && self.label2.text != "Kaftaan" && self.label2.text != "Peplum"{
            
            
            self.QuestionDone.hidden = false
            self.question3View.hidden = true
            
        }
            
        else  if GlobalVariables.globalGarmentSelected == "Capri" {
            
            dropDown3.dataSource = ["Midi" , "Calf"]
            
        } else if GlobalVariables.globalGarmentSelected == "Culottes" {
            
            dropDown3.dataSource = ["midi" , "calf" , "full"]
        }else   if GlobalVariables.globalGarmentSelected == "Palazzo" {
            
            dropDown3.dataSource = ["Calf Length" , "Full Length"]
            
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Sheath Dress" {
            
            dropDown3.dataSource = ["Above knees" , "Below Knees"]
            
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Shift Dress" {
            
            dropDown3.dataSource = ["Mini Length" , "Midi Length"]
            
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Blouson Dress" {
            
            dropDown3.dataSource = ["Mini" , "Midi" , "Calf" , "Long"]
            
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Pop over dress" {
            
            dropDown3.dataSource = ["Mini" , "Midi" , "Calf" , "Long"]
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Bodycon Dress" {
            
            dropDown3.dataSource = ["Mini" , "Midi" , "Calf" ]
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Pencil Dress" {
            
            dropDown3.dataSource = ["Mini" , "Midi" , "Calf" ]
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Skater Dress" {
            
            dropDown3.dataSource = ["Mini"]
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Maxi Dress" {
            
            dropDown3.dataSource = ["Full"]
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Shirt Dress" {
            
            dropDown3.dataSource = ["Mini" , "Midi" , "Calf" ,"Full"]
        }
        else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Tshirt Dress" {
            
            dropDown3.dataSource = ["Mini" , "Midi" , "Calf" ,"Full"]
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Peplum Dress" {
            
            dropDown3.dataSource = ["Mini" , "Midi" , "Calf" ]
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Aline Dress" {
            
            dropDown3.dataSource = ["Mini" , "Midi" , "Calf", "Full" ]
        }
        else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Fit and Flare Dress" {
            
            dropDown3.dataSource = ["Mini" , "Midi" , "Calf"  , "Full"]
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Wrap Dress" {
            
            dropDown3.dataSource = ["Mini" , "Midi" , "Calf"  , "Full"]
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Drape Dress" {
            
            dropDown3.dataSource = ["Mini" , "Midi" , "Calf"  , "Full"]
        }else  if GlobalVariables.globalGarmentSelected == "Dress" && self.label2.text == "Gown" {
            
            dropDown3.dataSource = [ "Full"]
        }
            
          
        else   if GlobalVariables.globalGarmentSelected == "Skirt" && self.label2.text == "Balloon" {
            
            dropDown3.dataSource = ["Mini" , "Midi"]
            
        }
        else   if GlobalVariables.globalGarmentSelected == "Skirt" && self.label2.text != "Balloon" {
            
            dropDown3.dataSource = ["Mini" , "Midi", "Maxi", "Calf"]
            
        }
        
        dropDown3.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.label3.text = item
            self.QuestionDone.hidden = false
            GlobalVariables.detail3 = item
            
            
            
        }
        
    }
    
    @IBOutlet var question4anchor: UIView!
    
    @IBAction func question4Action(sender: AnyObject) {
        
        dropDown4.show()
        dropDown4.anchorView = self.question4anchor
        
        if GlobalVariables.globalGarmentSelected == "Trouser" {
            
            dropDown4.dataSource = ["Skinny" , "Straight" , "Loose"]
            
        } else  if GlobalVariables.globalGarmentSelected == "Capri" {
            
            dropDown4.dataSource = ["Skinny" , "Straight" , "Loose"]
            
        }
        
        dropDown4.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.label3.text = item
            
        }
        
        
    }
    
    
    @IBAction func done(sender: AnyObject) {
        switch GlobalVariables.detail1 {
            
        case "Shirt":
            
            GlobalVariables.mainDetail = "TopWear"
            
            
        case "Top":
            
            GlobalVariables.mainDetail = "TopWear"
            
        case "TShirt":
            
            GlobalVariables.mainDetail = "TopWear"
            
        case "Skirt":
            
            GlobalVariables.mainDetail = "BottomWear"
            
        case "Jeans":
            GlobalVariables.mainDetail = "BottomWear"
            
           
            
            
        case "Trouser":
            
            GlobalVariables.mainDetail = "BottomWear"
            
        case "Capri":
            
            GlobalVariables.mainDetail = "BottomWear"
            
        case "Culottes":
            
            GlobalVariables.mainDetail = "BottomWear"
            
        case "Leggings":
            
            GlobalVariables.mainDetail = "BottomWear"
            
        case "Cargos":
            
            GlobalVariables.mainDetail = "BottomWear"
            
        case "Shorts":
            
            GlobalVariables.mainDetail = "BottomWear"
            
        case "Palazzo":
            GlobalVariables.mainDetail = "BottomWear"
            
       
            
            //        case "Stockings":
            //
            //         GlobalVariables.mainDetail = "BottomWear"
            
            //        case "Dungarees Shorts":
            //
            //           GlobalVariables.mainDetail = "BottomWear"
            //
            //        case "Dunagrees Trouser":
            //
            //          GlobalVariables.mainDetail = "BottomWear"
            
            
            
        default:
            print("Fucked")
            
        }
        
        
        self.mainQuestionsView.hidden = true
        
        
        if GlobalVariables.finalGarmentCount == 0
        {
            
        }
        else
        {
            self.panel.timeUntilDismiss = 3
            self.panel.showNotify(withStatus: .SUCCESS, inView: self.view, message: "Garment queued for processing. We will notify you, once done. Happy Uploading 🤗")
        }
        
        
    }
    
    @IBAction func questionAction(sender: AnyObject) {
        
        
        self.mainQuestionsView.hidden = true
        
        self.sendImageToServer()
        self.label1.text = "Type of Garment"
        self.label2.text = "Size of Garment"
        self.label3.text = "Additional Details"
    }
    
    
    func sendModelDetails(){
        
        let currentUseridObject = NSUserDefaults.standardUserDefaults().objectForKey("usr_id")
        let bustObject = NSUserDefaults.standardUserDefaults().objectForKey("bust")
        let hipObject = NSUserDefaults.standardUserDefaults().objectForKey("hip")
        let waistObject = NSUserDefaults.standardUserDefaults().objectForKey("waist")
        let heightObject = NSUserDefaults.standardUserDefaults().objectForKey("height")
        let complexionObject = NSUserDefaults.standardUserDefaults().objectForKey("complexion")
        
        
        
        let current_user_id = currentUseridObject as! String
        let bust = bustObject as! String
        let hip = hipObject as! String
        let waist = waistObject as! String
        let height = heightObject as! String
        let complexion = complexionObject as! String
        
        
        Alamofire.request(.POST, "http://ec2-52-35-225-149.us-west-2.compute.amazonaws.com:7000/processing_panel/set_model_size", parameters: ["user_id": GlobalVariables.globalFacebookId!,"bust_size": bust,"height_size": height,"complexion": complexion,"waist_size": waist, "hip_size": hip])
            .validate()
            .responseJSON { response in
                print(current_user_id)
                print("Model Garment in saved on Server")
                
        }
        
    }
    
    
 }
 
