//
//  View2.swift
// 
//
// 
//  Copyright (c) 2015 Archetapp. All rights reserved.
//

import UIKit
import AVFoundation
import ZAlertView
import JKNotificationPanel


class View2 : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var tickmarkOutlet: UIButton!
    let panel : JKNotificationPanel = JKNotificationPanel()
    let warningPanel : JKNotificationPanel = JKNotificationPanel()
    var firstLaunchEver : Bool = false
    var permanentView : UIView?
    var userClickedPhoto : UIImage?
    
    
    
    @IBAction func crossClicked(sender: AnyObject) {
        
        self.cross.hidden = true
        self.clickedPhoto.hidden = true
        self.cameraButtonOutlet.hidden = false
        self.perimeterOutlet.hidden = false
        self.tickmarkOutlet.hidden = true
        
    }
    
    
    @IBOutlet weak var cross: UIButton!
    @IBOutlet weak var clickedPhoto: UIImageView!
 
    @IBOutlet weak var cameraButtonOutlet: UIButton!
    @IBAction func tickmarkAction(sender: AnyObject) {
        
    
    
    }
    @IBOutlet weak var perimeterOutlet: UIImageView!
    var captureSession : AVCaptureSession?
    var stillImageOutput : AVCaptureStillImageOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?
    @IBOutlet var cameraView: UIView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        if(NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce"))
        {
            // app already launched
        }
        else
        {
            
           perimeterOutlet.hidden = true
            warningPanel.showNotify(withStatus: .WARNING, inView: self.view, message: "Tap on the circle to upload your wardrobe")
            warningPanel.timeUntilDismiss = 3
            firstLaunchEver = true
            
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
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
    
    
    
    @IBOutlet var tempImageView: UIImageView!
    
    
    func didPressTakePhoto(){
        
      
        
        if let videoConnection = stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo){
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {
                (sampleBuffer, error) in
                
                if sampleBuffer != nil {
                    
                    
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider  = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    
                    self.tempImageView.image = image
                    self.clickedPhoto.image = image
                    self.userClickedPhoto = image
                    self.tempImageView.hidden = true
                    self.clickedPhoto.hidden = false
                    
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
            tempImageView.hidden = true
            didTakePhoto = false
            
        }
        else{
            captureSession?.startRunning()
            didTakePhoto = true
            didPressTakePhoto()
            
        }
        
    }
    
    
    
    
    @IBAction func clicked (sender : UIButton) {
        
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
        
        self.cross.hidden = false
        cameraButtonOutlet.hidden = true
        perimeterOutlet.hidden = true
        self.tickmarkOutlet.hidden = false
        }
    }
    
    func removeView () {
        permanentView?.removeFromSuperview()
       
    }
    
    
    
    func sendImageToServer(){
        
        let cloudinary = CLCloudinary()
        
        cloudinary.config().setValue("www-udiva-in", forKey: "cloud_name")
        cloudinary.config().setValue("169749954379346", forKey: "api_key")
        cloudinary.config().setValue("gDh1C6AHlfYEJNeL2U4CUGM-pIc", forKey: "api_secret")
        
        let forUpload = UIImagePNGRepresentation(userClickedPhoto!)
       
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}