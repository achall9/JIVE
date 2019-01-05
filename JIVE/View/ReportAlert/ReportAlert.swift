//
//  ReportAlert.swift
//  JIVE
//
//  Created by Lee Sheng Jin on 2018/11/17.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class ReportAlert: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibName()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibName()
    }
    
    func loadNibName() {
        let view = Bundle.main.loadNibNamed("ReportAlert", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func actionReport(_ sender: UIButton) {
        self.fadeOut { (success) in
            
        }
    }
    
}
