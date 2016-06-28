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


class View2 : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UIDropDownDelegate {
    
    
    
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
    var mainCamera : AVCaptureDevice?
    var facebookId = "404"
    var facebookUser = "Mark Zuckerberg"
    var numberOfGarmentsUploaded = 0
    let clothes : NSMutableArray = ["Top", "Shorts", "Shirt", "Jeans", "TShirt", "Trousers", "Capris", "Culottes" , "Leggings" , "Cargos" ,"Palazzo" , "Stockings" , "Dungree shorts" , "Dungree Trousers" , "Skirt" , "Kurta" , "Jackets" , "Sweaters" ,"Sweatshirt" ,"Shrugs" , "Harem pants" ,"Dress"]

 
    @IBOutlet var cameraImage: UIImageView!
    
    
     let alertController = YBAlertController(title: "Add garment type", message: "Help us identify your garment typee", style: .Alert)
    
    @IBAction func crossClicked(sender: AnyObject) { //when cross button is clicked
        
        self.cross.hidden = true
       self.cameraImage.hidden = true
        self.cameraButtonOutlet.hidden = false
        self.perimeterOutlet.hidden = false
        self.tickmarkOutlet.hidden = true
        
    }
    
    
    @IBOutlet weak var cross: UIButton!

 
    @IBOutlet weak var cameraButtonOutlet: UIButton!
    
    
    
    
    @IBAction func tickmarkAction(sender: AnyObject) {    // when user clicks on the tick mark
        

        tickmarkOutlet.hidden = true
        cross.hidden = true
  
        let frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        let dropDownView = UIView(frame: frame)
        garmentAddView = dropDownView
        dropDownView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.view.addSubview(dropDownView)
        
      let drop = UIDropDown(frame: CGRect(x: 0, y: 0, width: 300, height: 45))
        drop.center = dropDownView.center
        drop.delegate = self
        drop.options = clothes
        drop.placeholder = "Select a garment..."
        
        dropDownView.addSubview(drop)
        
    }
 
    
    
    @IBOutlet weak var perimeterOutlet: UIImageView!
    var captureSession : AVCaptureSession?
    var stillImageOutput : AVCaptureStillImageOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?
    @IBOutlet var cameraView: UIView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        returnUserData()
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            
              self.getNumberOfGarments()
            
        })
        

      
     
        self.settingUpWardrobe.hidden = true
        self.ActivityIndicator.hidden = true
        ActivityIndicator.strokeColor = UIColor(red:0.98, green:0.13, blue:0.25, alpha:1.0)
  
        if(NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce"))
        {
            // app already launched
        }
        else
        {
            
           perimeterOutlet.hidden = true
            warningPanel.showNotify(withStatus: .WARNING, inView: self.view, message: "Tap on the circle to know more")
            warningPanel.timeUntilDismiss = 3
            firstLaunchEver = true
            userUniqueIdentifier = UIDevice.currentDevice().identifierForVendor!.UUIDString
            print(userUniqueIdentifier)
            
            // This is the first launch ever
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedOnce")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    self.cross.hidden = true
    self.tickmarkOutlet.hidden = true
 
    }
    
    
  
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
                captureSession?.startRunning()
                
            }
        }
    }
    
    
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("TextField did begin editing method called")
    }

    
    
    
    
    
    
    func didPressTakePhoto(){  //image capture mechanism

        if let videoConnection = stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo){
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {
                (sampleBuffer, error) in
                
                if sampleBuffer != nil {
                    
                    
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider  = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    
                    self.cameraImage.image = image
                    self.cameraImage.hidden = false
                
                    
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
    
    
    
    
    @IBAction func clicked (sender : UIButton) {  // main camera button clicked
        
        
   
       
        if firstLaunchEver == true
        {
            perimeterOutlet.hidden = true
            
            
            let test = nn.instanceFromNib()
            test.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
            permanentView = test
            let buttonFrame = CGRectMake(20, self.view.frame.height-60, self.view.frame.width-50, 40)
            let myButton = UIButton(frame: buttonFrame)
            myButton.backgroundColor = UIColor.redColor()
            myButton.addTarget(self, action: #selector(View2.removeView), forControlEvents: .AllTouchEvents)
            myButton.titleLabel?.text = "Got it"
            myButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            myButton.backgroundColor = UIColor(red:0.98, green:0.13, blue:0.25, alpha:1.0)
            test.addSubview(myButton)
            self.view.addSubview(test)
            
           
            
            
            
        let triggerTime = (Int64(NSEC_PER_SEC) * 3)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                    
                    self.perimeterOutlet.hidden = false
            
                })
            
            
            firstLaunchEver = false
            
        } else {
        
        didPressTakePhoto()
        didPressTakeAnother()
        
      //  self.tempImageView.hidden = false
        self.cross.hidden = false
        cameraButtonOutlet.hidden = true
        perimeterOutlet.hidden = true
        self.tickmarkOutlet.hidden = false
        }
    }
    
    func garmentAdded(){
        
        self.alertController.removeFromParentViewController()
        
        
    }
 
    
    func removeView () {
        permanentView?.removeFromSuperview()
    }
    
    
    func sendImageToServer(){  // backend code to send image to server
        
        tickmarkOutlet.hidden = true
        cross.hidden = true
        settingUpWardrobe.hidden = false
        
        let imageData = UIImageJPEGRepresentation(self.finalImage! , 1 )
        
        ActivityIndicator.hidden = false
        ActivityIndicator.startLoading()
        
        numberOfGarmentsUploaded += 1
        
 
    
        Alamofire.upload(
            .POST,
            "http://192.168.182.60:7000/processing_panel/upload",
            multipartFormData: { multipartFormData in
                
                
                multipartFormData.appendBodyPart(data: imageData!, name: "garment_image", fileName: String(self.numberOfGarmentsUploaded) + ".jpg", mimeType: "image/jpeg") // image
                
                
                multipartFormData.appendBodyPart(data: self.facebookId.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"user_id") // user_id
                
                
                multipartFormData.appendBodyPart(data: self.facebookUser.dataUsingEncoding(NSUTF8StringEncoding , allowLossyConversion:  false)!, name: "user_name") //user_name
                
                
                multipartFormData.appendBodyPart(data: "TopWear".dataUsingEncoding(NSUTF8StringEncoding , allowLossyConversion: false)!, name: "style") // style
                
                
                print("Total number of garments \(self.numberOfGarmentsUploaded)")
                print("The user id is \(self.facebookId)")
                print("The user name is \(self.facebookUser)")
            
             
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                   
                    upload.progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                        //print("Uploading Avatar \(totalBytesWritten) / \(totalBytesExpectedToWrite)")
                        
                 
                        dispatch_async(dispatch_get_main_queue(),{
                            
                          
                            /**
                             *  Update UI Thread about the progress
                             */
                        })
                    }
                    upload.responseJSON { (JSON) in
                        dispatch_async(dispatch_get_main_queue(),{
                            //Show Alert in UI
                       self.ActivityIndicator.completeLoading(true)
                         self.settingUpWardrobe.hidden = true
                            self.crossClicked(self)
                            let triggerTime = (Int64(NSEC_PER_SEC) * 1)
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                                
                               self.ActivityIndicator.hidden = true
      
                            })
                            

                            self.panel.showNotify(withStatus: .SUCCESS, inView: self.view, message: "Wardrobe uploaded , swipe right.")
                        })
                    }
                    
                case .Failure( _):
                    //Show Alert in UI
                    print("Avatar failed");
                }
            }
        );
        

    }
    
    
    
    
    func dropDown(dropDown: UIDropDown, didSelectOption option: String, atIndex index: Int) {
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            
            self.garmentAddView?.removeFromSuperview()
            self.sendImageToServer()

            
        })

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
        if let image = UIImage(named:"flash-off") {
            sender.setImage(image, forState: .Normal)
        }
        } else if device.torchMode == AVCaptureTorchMode.On {
          
            if let image = UIImage(named:"flash") {
                sender.setImage(image, forState: .Normal)
            }
            
        }
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
    
                print(self.facebookId)
            
                let userName : String = result.valueForKey("name") as! String
              
                self.facebookUser = userName
                mainInstance.name = userId
                
                
                
            }
        })
    }
    
    
    func getNumberOfGarments () { //calculate the current number of garments on the server
        
        
        Alamofire.request(.GET, "http://192.168.182.60:7000/processing_panel/get_garments", parameters: ["user_id": self.facebookId])
            .responseJSON { response in
               
                
                if let JSON = response.result.value {

                 
                     print (Int(JSON as! NSNumber))
                    
                    self.numberOfGarmentsUploaded = (Int(JSON as! NSNumber))
                    mainInstance1.name = String((Int(JSON as! NSNumber)))
                    
                }
        }
      
        
    }

 

    
       }