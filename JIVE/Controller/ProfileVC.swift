//
//  ProfileVC.swift
//  JIVE
//
//  Created by RSS on 9/10/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class ProfileVC: BaseViewController {

    @IBOutlet weak var scrProfile: UIScrollView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var txtBio: UITextView!
    
    var isCover: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrProfile.contentSize = CGSize(width: 0, height: 640)
        self.initView()
    }
    
    func initView() {
        self.imgProfile.loadImageWithCache(urlString: baseAmazonURL.appending(User.sharedInstance.profile!.profile_pic!))
        self.imgCover.loadImageWithCache(urlString: baseAmazonURL.appending(User.sharedInstance.profile!.cover_photo!))
        lblName.text = User.sharedInstance.profile?.name
        lblUsername.text = User.sharedInstance.profile?.username
        txtBio.text = User.sharedInstance.profile?.bio
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionGotoSetting(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionBrowse(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BrowseVC") as! BrowseVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionPhoto(_ sender: UIButton) {
        self.view.endEditing(true)
        if sender.tag == 200 {
            self.isCover = false
        }else {
            self.isCover = true
        }
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            if let popoverController = alert.popoverPresentationController {
                let barButtonItem = UIBarButtonItem(customView: sender)
                popoverController.barButtonItem = barButtonItem
            }
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if self.isCover {
            self.imgCover.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }else {
            self.imgProfile.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        
        let imgData = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage, 0.8)
        self.showHUD()
        API.sharedInstance.uploadImage(imgData!) { (photoURL) in
            DispatchQueue.main.async {
                self.hideHUD()
                if self.isCover {
                    User.sharedInstance.profile?.cover_photo = photoURL
                }else {
                    User.sharedInstance.profile?.profile_pic = photoURL
                }
                self.appDelegate.saveUser()
            }
        }
        dismiss(animated:true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
