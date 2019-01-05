//
//  BaseViewController.swift
//  Uptime
//
//  Created by RSS on 1/29/18.
//  Copyright © 2018 HTK. All rights reserved.
//

import UIKit
//import LGSideMenuController

class BaseViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var codeView: UIView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Side menu Controller
    
//    func setupMenuBarButton(){
//
//        let menuButtonImg = UIImageView(frame: CGRect(x: 15, y: 20, width: 50, height: 50))
//        menuButtonImg.image = #imageLiteral(resourceName: "hamburger-menu")
//
//        let menuButton = UIButton(frame: CGRect(x: 15, y: 20, width: 50, height: 50))
//        menuButton.addTarget(self, action: #selector(BaseViewController.showLGSideMenu(_:)), for: .touchUpInside)
//        self.view.addSubview(menuButtonImg)
//        self.view.addSubview(menuButton)
//
//    }
    
    //MARK: Gloabl Alert View Controller
    func alertViewController(title: String, message: String){
        let alert = UIAlertController(title: title.capitalized, message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Open Side menu Controller
//    @objc func showLGSideMenu(_ sender: UIBarButtonItem) {
//        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
//        
//    }
    
    func showHUD() {
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.show()
    }
    
    func hideHUD() {
        SVProgressHUD.dismiss()
    }

}
