//
//  AccountVC.swift
//  JIVE
//
//  Created by Lee Sheng Jin on 2018/11/17.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class AccountVC: BaseViewController {

    @IBOutlet var scrView: UIScrollView!
    @IBOutlet weak var txtDob: DPTextField!
    @IBOutlet weak var txtGender: CustomTextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrView.contentSize = CGSize(width: 0, height: 667)
        self.initView()
    }
    
    func checkFields() -> String? {
        if txtName.text == "" {
            return "Please input your name."
        }
        if txtUsername.text == "" {
            return "Please input your username."
        }
        if txtEmail.text == "" {
            return "Please input your email."
        }
        if txtPhone.text == "" {
            return "Please input your phone number."
        }
        if txtDob.text == "" {
            return "Please input your password correctly."
        }
        if txtGender.text == "" {
            return "Please input your gender."
        }
        return nil
    }
    
    func initView() {
        self.txtDob.text = User.sharedInstance.account?.birthdate
        self.txtGender.text = User.sharedInstance.account?.gender
        self.txtName.text = User.sharedInstance.profile?.name
        self.txtUsername.text = User.sharedInstance.account?.username
        self.txtEmail.text = User.sharedInstance.account?.email
        self.txtPhone.text = User.sharedInstance.account?.phone
        let gender_option: [String] = ["Male", "Female"]
        txtDob.initField()
        txtGender.options = gender_option
        txtGender.initTextField()
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionUpdateAccount(_ sender: UIButton) {
        if self.checkFields() != nil {
            self.alertViewController(title: "Oops!", message: self.checkFields()!)
            return
        }
        self.showHUD()
        User.sharedInstance.account?.birthdate = txtDob.text
        User.sharedInstance.account?.gender = txtGender.text
        User.sharedInstance.profile?.name = txtName.text
        User.sharedInstance.account?.username = txtUsername.text
        User.sharedInstance.account?.email = txtEmail.text
        User.sharedInstance.account?.phone = txtPhone.text
        API.sharedInstance.updateUser(User.sharedInstance.account?.id ?? "") { (errMsg) in
            DispatchQueue.main.async {
                self.hideHUD()
                if errMsg == nil {
                    self.navigationController?.popViewController(animated: true)
                }else {
                    self.alertViewController(title: "Oops!", message: errMsg!)
                }
            }
        }
    }
    

}
