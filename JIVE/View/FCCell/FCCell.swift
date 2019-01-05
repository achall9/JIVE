//
//  FCCell.swift
//  JIVE
//
//  Created by RSS on 9/10/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

protocol FCCellDelegate {
    func gotoDetail(_ cell: FCCell)
    func showProfile(_ cell: FCCell)
}

class FCCell: UITableViewCell {
    
    var delegate: FCCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func actionGotoDetail(_ sender: UIButton) {
        delegate?.gotoDetail(self)
    }
    
    @IBAction func actionShowActionSheet(_ sender: UIButton) {
        let vc = self.findViewController() as! HomeVC
        vc.showActionView()
    }
    
    @IBAction func actionShowProfile(_ sender: UIButton) {
        self.delegate?.showProfile(self)
    }
    
}
