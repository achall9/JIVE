//
//  SocialMediaVC.swift
//  JIVE
//
//  Created by Lee Sheng Jin on 2018/11/17.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class SocialMediaVC: UIViewController {

    @IBOutlet var scrView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrView.contentSize = CGSize(width: 0, height: 667)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
