//
//  ChatView.swift
//  JIVE
//
//  Created by RSS on 10/26/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit
import AVFoundation

protocol ChatViewDelegate {
    func actoionRotate(_ type: Int)
    func actionClose()
}

class ChatView: UIView, AVCaptureFileOutputRecordingDelegate {
    
    @IBOutlet weak var camPreview: UIView!
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBOutlet weak var btnStartCapture: UIButton!
    @IBOutlet weak var chatView: ChatViewItem!
    
    var type: Int = 0
    var delegate: ChatViewDelegate?
    let captureSession = AVCaptureSession()
    let movieOutput = AVCaptureMovieFileOutput()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var activeInput: AVCaptureDeviceInput!
    var outputURL: URL!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadNibName(_ type: Int) {
        let view = Bundle.main.loadNibNamed("ChatView", owner: self, options: nil)?[type] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        if setupSession() {
            setupPreview()
            startSession()
        }
        self.type = type
        self.initView()
    }
    
    func initView() {
        self.pageCtrl.numberOfPages = 3
        self.pageCtrl.currentPage = 0
        self.scrView.isPagingEnabled = true
        self.scrView.isScrollEnabled = false
        var mainFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        for i in 0 ..< 3 {
            mainFrame.origin.x = self.scrView.frame.size.width * CGFloat(i)
            mainFrame.size = self.scrView.frame.size
            let view = ChatViewItem(frame: mainFrame)
            view.loadNibName(i)
            self.scrView.addSubview(view)
        }
        self.scrView.contentSize = CGSize(width: self.scrView.frame.size.width * 3, height: self.scrView.frame.size.height)
        chatView.loadNibName(1)
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageCtrl.currentPage) * scrView.frame.size.width
        scrView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    @IBAction func actionTab(_ sender: UIButton) {
        self.pageCtrl.currentPage = sender.tag - 300
        self.changePage(sender: sender)
    }
    
    @IBAction func actionClose(_ sender: UIButton) {
        if sender.tag == 300 {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: { (finished) -> Void in
                if finished{
                    
                }
            })
        }else {
            delegate?.actionClose()
        }
    }
    
    @IBAction func actionRefresh(_ sender: UIButton) {
        delegate?.actoionRotate(self.type)
    }
    
    @IBAction func actionStartCapture(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.chatView.alpha = 1.0
            self.btnStartCapture.transform = CGAffineTransform(translationX: 0, y: -self.frame.height + 143)
        }, completion: { (finished) -> Void in
            if finished{
                
            }
        })
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
    }
    
    func setupPreview() {
        // Configure previewLayer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = camPreview.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        camPreview.layer.addSublayer(previewLayer)
    }
    
    //MARK:- Setup Camera
    
    func setupSession() -> Bool {
        
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        
        // Setup Camera
        let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front) // AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let input = try AVCaptureDeviceInput(device: camera!)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
                activeInput = input
            }
        } catch {
            print("Error setting device video input: \(error)")
            return false
        }
        
        // Setup Microphone
        let microphone = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let micInput = try AVCaptureDeviceInput(device: microphone!)
            if captureSession.canAddInput(micInput) {
                captureSession.addInput(micInput)
            }
        } catch {
            print("Error setting device audio input: \(error)")
            return false
        }
        
        
        // Movie output
        if captureSession.canAddOutput(movieOutput) {
            captureSession.addOutput(movieOutput)
        }
        
        return true
    }
    
    func setupCaptureMode(_ mode: Int) {
        // Video Mode
        
    }
    
    //MARK:- Camera Session
    func startSession() {
        
        
        if !captureSession.isRunning {
            videoQueue().async {
                self.captureSession.startRunning()
            }
        }
    }
    
    func stopSession() {
        if captureSession.isRunning {
            videoQueue().async {
                self.captureSession.stopRunning()
            }
        }
    }
    
    func videoQueue() -> DispatchQueue {
        return DispatchQueue.main
    }
    
    
    
    func currentVideoOrientation() -> AVCaptureVideoOrientation {
        var orientation: AVCaptureVideoOrientation
        
        switch UIDevice.current.orientation {
        case .portrait:
            orientation = AVCaptureVideoOrientation.portrait
        case .landscapeRight:
            orientation = AVCaptureVideoOrientation.landscapeLeft
        case .portraitUpsideDown:
            orientation = AVCaptureVideoOrientation.portraitUpsideDown
        default:
            orientation = AVCaptureVideoOrientation.landscapeRight
        }
        
        return orientation
    }
    
    func startCapture() {
        
        startRecording()
        
    }
    
    //EDIT 1: I FORGOT THIS AT FIRST
    
    func tempURL() -> URL? {
        let directory = NSTemporaryDirectory() as NSString
        
        if directory != "" {
            let path = directory.appendingPathComponent(NSUUID().uuidString + ".mp4")
            return URL(fileURLWithPath: path)
        }
        
        return nil
    }
    
    
    func startRecording() {
        
        if movieOutput.isRecording == false {
            
            let connection = movieOutput.connection(with: AVMediaType.video)
            if (connection?.isVideoOrientationSupported)! {
                connection?.videoOrientation = currentVideoOrientation()
            }
            
            if (connection?.isVideoStabilizationSupported)! {
                connection?.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.auto
            }
            
            let device = activeInput.device
            if (device.isSmoothAutoFocusSupported) {
                do {
                    try device.lockForConfiguration()
                    device.isSmoothAutoFocusEnabled = false
                    device.unlockForConfiguration()
                } catch {
                    print("Error setting configuration: \(error)")
                }
                
            }
            
            //EDIT2: And I forgot this
            outputURL = tempURL()
            movieOutput.startRecording(to: outputURL, recordingDelegate: self)
            
        }
        else {
            stopRecording()
        }
        
    }
    
    func stopRecording() {
        
        if movieOutput.isRecording == true {
            movieOutput.stopRecording()
        }
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        if (error != nil) {
            print("Error recording movie: \(error!.localizedDescription)")
        } else {
            
            _ = outputURL as URL
            
        }
        outputURL = nil
    }
    
}
