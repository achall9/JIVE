//
//  PasswordVC.swift
//  JIVE
//
//  Created by Lee Sheng Jin on 2018/11/17.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class PasswordVC: BaseViewController {

    @IBOutlet var scrView: UIScrollView!
    @IBOutlet weak var txtCurrentPWD: UITextField!
    @IBOutlet weak var txtNewPWD: UITextField!
    @IBOutlet weak var txtConfirmPWD: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrView.contentSize = CGSize(width: 0, height: 667)
        // Do any additional setup after loading the view.
    }
    
    func checkFields() -> String? {
        if txtCurrentPWD.text == "" {
            return "Please input your current password."
        }
        if txtCurrentPWD.text!.count < 6{
            return "Password length at least 6 characters."
        }
        if txtNewPWD.text == "" {
            return "Please input your new password."
        }
        if txtConfirmPWD.text != txtNewPWD.text {
            return "Please input your password correctly."
        }
        return nil
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSavePassword(_ sender: UIButton) {
        if checkFields() != nil {
            self.alertViewController(title: "Oops!", message: checkFields()!)
            return
        }
        self.showHUD()
        let param: [String: Any] = [
            "oldPassword": txtCurrentPWD.text!,
            "newPassword": txtNewPWD.text!
        ]
        API.sharedInstance.updatePassword(param, User.sharedInstance.account?.id ?? "") { (errMsg) in
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
