//
//  NotificationCell.swift
//  JIVE
//
//  Created by RSS on 9/10/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class NotificationCell: UIView {

    @IBOutlet weak var gradientBk: GradientView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadNibName(_ type: Int) {
        let view = Bundle.main.loadNibNamed("NotificationCell", owner: self, options: nil)?[type] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }

}
