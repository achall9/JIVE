//
//  SettingVC.swift
//  JIVE
//
//  Created by Lee Sheng Jin on 2018/11/17.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class SettingVC: BaseViewController {
    
    @IBOutlet var settingViews: [GradientView]!
    var prevView: Int = 100

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for view in settingViews {
            view.startColor = UIColor.clear
            view.endColor = UIColor.clear
        }
    }
    
    @IBAction func actionDown(_ sender: UIButton) {
        settingViews[prevView - 100].startColor = UIColor.clear
        settingViews[prevView - 100].endColor = UIColor.clear
        settingViews[sender.tag - 100].endColor = UIColor(red: 52 / 255, green: 53 / 255, blue: 143 / 255, alpha: 1.0)
        settingViews[sender.tag - 100].startColor = UIColor(red: 227 / 255, green: 24 / 255, blue: 127 / 255, alpha: 1.0)
        prevView = sender.tag
    }
    
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSettingDetail(_ sender: UIButton) {
        
        switch sender.tag {
        case 100:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountVC") as! AccountVC
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 101:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PasswordVC") as! PasswordVC
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 102:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SocialMediaVC") as! SocialMediaVC
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
            self.navigationController?.pushViewController(vc, animated: true)
            break
        }
    }
    
    @IBAction func actionLogout(_ sender: UIButton) {
        self.appDelegate.deleteUser()
        self.appDelegate.makingRoot("initial")
    }
    

}
