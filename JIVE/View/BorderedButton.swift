//
//  BorderedButton.swift
//  JIVE
//
//  Created by RSS on 9/10/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class BorderedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.white.cgColor
    }
}
