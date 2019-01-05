//
//  CommentCell.swift
//  JIVE
//
//  Created by RSS on 9/10/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class CommentCell: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibName()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibName()
    }
    
    func loadNibName() {
        let view = Bundle.main.loadNibNamed("CommentCell", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }

}
