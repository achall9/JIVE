//
//  SignUpVC.swift
//  JIVE
//
//  Created by RSS on 9/10/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class SignUpVC: BaseViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPWD: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        if txtPassword.text == "" {
            return "Please input your password."
        }
        if txtPassword.text!.count < 6{
            return "Password length at least 6 characters."
        }
        if txtConfirmPWD.text != txtPassword.text {
            return "Please input your password correctly."
        }
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionSignUp(_ sender: UIButton) {
        if checkFields() != nil {
            self.alertViewController(title: "Oops!", message: checkFields()!)
            return
        }
        self.showHUD()
        let param: [String: Any] = [
            "name": txtName.text!,
            "username": txtUsername.text!,
            "email": txtEmail.text!,
            "password": txtPassword.text!
        ]
        API.sharedInstance.register(param) { (errMsg) in
            DispatchQueue.main.async {
                self.hideHUD()
                if errMsg == nil {
                    self.appDelegate.makingRoot("enterApp")
                }else {
                    self.alertViewController(title: "Oops!", message: errMsg!)
                }
            }
        }
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
