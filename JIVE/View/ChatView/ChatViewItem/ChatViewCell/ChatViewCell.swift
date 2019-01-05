//
//  ChatViewCell.swift
//  JIVE
//
//  Created by RSS on 10/26/17.
//  Copyright © 2017 LOVI. All rights reserved.
//

import UIKit

class ChatViewCell: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibName()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibName()
    }
    
    func loadNibName() {
        let view = Bundle.main.loadNibNamed("ChatViewCell", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }

}
