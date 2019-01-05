//
//  PaymentVC.swift
//  JIVE
//
//  Created by Lee Sheng Jin on 2018/11/17.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class PaymentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
