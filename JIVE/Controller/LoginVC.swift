//
//  LoginVC.swift
//  JIVE
//
//  Created by RSS on 9/10/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkFields() -> String? {
        if txtEmail.text == "" {
            return "Please input your email."
        }
        if txtPassword.text == "" {
            return "Please input your password."
        }
        return nil
    }
    
    @IBAction func actionLogin(_ sender: UIButton) {
        if checkFields() != nil {
            self.alertViewController(title: "Oops!", message: checkFields()!)
            return
        }
        self.showHUD()
        let param: [String: Any] = [
            "email": txtEmail.text!,
            "password": txtPassword.text!
        ]
        API.sharedInstance.login(param) { (errMsg) in
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
    
    @IBAction func actionSignUp(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionForgotPWD(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Forgot Password", message: "Please enter your email address.", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action : UIAlertAction!) -> Void in
        })

        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: {
            alert -> Void in
            let txtEmail = alertController.textFields![0] as UITextField

            if txtEmail.text == "" {
                self.alertViewController(title: "Ooops!", message: "Please input your email address.")
            }else {
                self.showHUD()
                API.sharedInstance.forgotPassword(txtEmail.text!, completion: { (errMsg) in
                    DispatchQueue.main.async {
                        self.hideHUD()
                        if errMsg == nil {
                            self.alertViewController(title: "Success", message: "Email sent successfully! Please check your mailbox.")
                        }else {
                            self.alertViewController(title: "Oops!", message: errMsg!)
                        }
                    }
                })
            }

        })

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Email"
            textField.borderStyle = .roundedRect
            textField.keyboardType = .default
        }

        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)

        for field in alertController.textFields! as [UITextField] {
            field.superview?.superview?.layer.borderWidth = 2
            field.superview?.superview?.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
}
